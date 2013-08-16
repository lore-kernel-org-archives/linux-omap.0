From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] usb phy nop rename for v3.12 merge window
Date: Fri, 16 Aug 2013 00:30:05 -0700
Message-ID: <40880.2803526216$1376638277@news.gmane.org>
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
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/usb-signed

for you to fetch changes up to 3fa4d7344be0afebd80382ffeea6b1787cccf971:

  usb: phy: rename nop_usb_xceiv => usb_phy_gen_xceiv (2013-08-09 17:26:00 +0300)

----------------------------------------------------------------
USB nop phy rename via Felipe Balbi <balbi@ti.com>:

Here's a pull request of one patch to avoid conflicts during the merge
window.

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      usb: phy: rename nop_usb_xceiv => usb_phy_gen_xceiv

 arch/arm/mach-omap2/board-omap3beagle.c            |  4 +-
 arch/arm/mach-omap2/board-omap3evm.c               |  4 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |  2 +-
 arch/arm/mach-omap2/usb-host.c                     | 10 ++---
 drivers/usb/dwc3/dwc3-exynos.c                     |  8 ++--
 drivers/usb/dwc3/dwc3-pci.c                        |  8 ++--
 drivers/usb/musb/am35x.c                           |  2 +-
 drivers/usb/musb/blackfin.c                        |  2 +-
 drivers/usb/musb/da8xx.c                           |  2 +-
 drivers/usb/musb/davinci.c                         |  2 +-
 drivers/usb/musb/musb_dsps.c                       |  2 +-
 drivers/usb/musb/tusb6010.c                        |  2 +-
 drivers/usb/phy/Makefile                           |  2 +-
 drivers/usb/phy/{phy-nop.c => phy-generic.c}       | 44 +++++++++++-----------
 .../usb/{nop-usb-xceiv.h => usb_phy_gen_xceiv.h}   |  4 +-
 15 files changed, 49 insertions(+), 49 deletions(-)
 rename drivers/usb/phy/{phy-nop.c => phy-generic.c} (83%)
 rename include/linux/usb/{nop-usb-xceiv.h => usb_phy_gen_xceiv.h} (81%)
