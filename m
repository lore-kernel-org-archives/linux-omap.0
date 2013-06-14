From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 0/2] USB: PHY: Improve PHY selection logic
Date: Fri, 14 Jun 2013 12:51:40 +0300
Message-ID: <1371203502-29624-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, arnd@arndb.de, adrienverge@gmail.com, kishon@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Improve Kconfig so that the relevant PHY driver can be explicitely
selected by the controller driver instead of relying on the user
to do so.

Detailed description in patch 1.

v3:
- Fix linking problem when CONFIG_USB is m

v2:
- Merge patches 3-5 into the first patch to prevent circular dependency
between the Kconfig options during bisection.

cheers,
-roger
Roger Quadros (2):
  USB: PHY: Make PHY driver selection possible by controller drivers
  USB: ehci-omap: select NOP_USB_XCEIV PHY driver

 drivers/usb/Makefile       |    2 +-
 drivers/usb/gadget/Kconfig |    2 --
 drivers/usb/host/Kconfig   |    5 +----
 drivers/usb/phy/Kconfig    |   31 +++++++++++++++++++++----------
 4 files changed, 23 insertions(+), 17 deletions(-)

-- 
1.7.4.1
