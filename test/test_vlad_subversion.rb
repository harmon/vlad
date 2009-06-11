require 'test/vlad_test_case'
require 'vlad'
require 'vlad/subversion'

class TestVladSubversion < VladTestCase
  def setup
    super
    @scm = Vlad::Subversion.new
    set :repository, "svn+ssh://repo/myproject"
    set :scm_path, "/scm_path"
    set :revision, 'HEAD'
    set :release_path, '/release_path'
  end

  def test_checkout
    cmd = @scm.checkout revision, scm_path
    assert_equal 'svn co -r HEAD svn+ssh://repo/myproject /scm_path', cmd
  end

  def test_export
    cmd = @scm.export scm_path, release_path
    assert_equal 'svn export /scm_path /release_path', cmd
  end

  def test_revision
    cmd = @scm.revision(revision)
    expected = "`svn info svn+ssh://repo/myproject | grep 'Revision:' | cut -f2 -d\\ `"
    assert_equal expected, cmd
  end
end
