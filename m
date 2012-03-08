From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/7] non-critical fixes part3 for upcoming merge window
Date: Thu, 8 Mar 2012 12:53:29 -0800
Message-ID: <19682.9483997591$1331240057@news.gmane.org>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Olof,

Here are two more pre-emptive fixes for upcoming merge
window to pull into arm-soc/next/fixes-non-critical.

Now with the fixes finallny out of the way after all
the cleanup related changes, as a reply to this pull
request I'm posting some more pull requests for cleanup
and some minor board changes.

Regards,

Tony


The following changes since commit 9cf793f9b8b1ba9414e2a7591b2e911885f85a27:
  Kevin Hilman (1):
        ARM: OMAP: convert omap_device_build() and callers to __init

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical-part3

Tony Lindgren (2):
      ARM: OMAP2+: Fix section warnings for hsmmc_init_one
      ARM: OMAP2+: Fix build for omap4 only builds with missing include of linux/bug.h

 arch/arm/mach-omap2/hsmmc.c           |    2 +-
 arch/arm/mach-omap2/powerdomain44xx.c |    1 +
 arch/arm/mach-omap2/vc.c              |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)
