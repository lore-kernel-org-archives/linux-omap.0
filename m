From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/5] omap pm fixes for v3.10 merge window
Date: Mon, 8 Apr 2013 21:51:00 -0700
Message-ID: <13262.4219557785$1365483100@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit c309f7f46167e85d1aae2fd31f23e7d2b5cdfbe0:

  Merge branch 'for_3.10/omap_generic_cleanup_v2' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into omap-for-v3.10/cleanup-v2 (2013-03-28 14:45:31 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-pm-signed

for you to fetch changes up to 5e7deed71290136cf70944e158f40401d0eed784:

  Merge tag 'omap-pm-v3.10/fixes/pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.10/fixes-pm (2013-04-08 09:58:00 -0700)

----------------------------------------------------------------

Non-critical PM fix via Kevin Hilman <khilman@linaro.org>:

OMAP PM fixes for v3.10

Note that this has a dependency to omap-for-v3.10/cleanup-v2-signed.

----------------------------------------------------------------
Santosh Shilimkar (1):
      ARM: OMAP4+: PM: Restore CPU power state to ON with clockdomain force wakeup method

Tony Lindgren (1):
      Merge tag 'omap-pm-v3.10/fixes/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.10/fixes-pm

 arch/arm/mach-omap2/cpuidle44xx.c |  1 +
 arch/arm/mach-omap2/omap-smp.c    | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)
