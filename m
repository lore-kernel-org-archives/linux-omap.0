From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] musb regression fixes for v3.7-rc4
Date: Fri, 9 Nov 2012 14:39:39 -0800
Message-ID: <20121109223939.GZ6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40248 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755968Ab2KIWjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Nov 2012 17:39:44 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc4/musb-regression-signed

for you to fetch changes up to 459bc971eba0fe84b3fe857cf0a71c5fd102f06b:

  ARM: OMAP: ocp2scp: create omap device for ocp2scp (2012-11-07 10:10:28 -0800)

----------------------------------------------------------------
This series fixes an annoying regression to make MUSB working
on omap4 again. Although it's getting rather late for these
changes for the -rc cycle, it is important as many devices
are using MUSB for charging and connectivity.

With the USB PHY changes, MUSB started using the newly added
drivers/usb/phy/omap-usb2.c driver introduced by commit
657b306a (usb: phy: add a new driver for omap usb2 phy)
that is using the newly introduced drivers/bus/omap-ocp2scp.c
introduced by commit 26a84b3e (drivers: bus: add a new driver
for omap-ocp2scp).

These changes allowed dropping a lot of PHY related code from
arch/arm/mach-omap2/omap_phy_internal.c and have it live in
the device driver like it should with commit c9e4412a (arm: omap:
phy: remove unused functions from omap-phy-internal.c).

However, MUSB on omap4 broke with these changes for legacy
platform data boot, and now only works with device tree for
omap4. Unfortunately we are still few critical bindings away
from being able to make omap4 usbale with device tree.

Fix the regression properly by adding platform data support
to the ocp2scp driver so we can avoid adding back the driver
code to arch/arm/mach-omap2.

----------------------------------------------------------------
Kishon Vijay Abraham I (3):
      drivers: bus: ocp2scp: add pdata support
      ARM: OMAP4: add _dev_attr_ to ocp2scp for representing usb_phy
      ARM: OMAP: ocp2scp: create omap device for ocp2scp

 arch/arm/mach-omap2/devices.c              | 79 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 28 +++++++++++
 drivers/bus/omap-ocp2scp.c                 | 68 +++++++++++++++++++++++--
 include/linux/platform_data/omap_ocp2scp.h | 31 ++++++++++++
 4 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/platform_data/omap_ocp2scp.h
