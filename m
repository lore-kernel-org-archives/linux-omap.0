From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/5] USB: ehci-msm: USB_EHCI_MSM need not depend on USB_PHY
Date: Wed, 29 May 2013 14:43:29 +0300
Message-ID: <1369827811-534-4-git-send-email-rogerq@ti.com>
References: <1369827811-534-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369827811-534-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: balbi@ti.com, stern@rowland.harvard.edu, kishon@ti.com, arnd@arndb.de, adrienverge@gmail.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Pavankumar Kondeti <pkondeti@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

As the USB PHY drivers no longer depend on USB_PHY but
select it if needed, the controller drivers need not
depend on USB_PHY. They can safely select the necessary
PHY driver i.e. USB_MSM_OTG in this case.

Signed-off-by: Roger Quadros <rogerq@ti.com>
CC: Pavankumar Kondeti <pkondeti@codeaurora.org>
---
 drivers/usb/host/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 5561b47..48e1b70 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -186,7 +186,6 @@ config USB_EHCI_HCD_AT91
 config USB_EHCI_MSM
 	tristate "Support for Qualcomm QSD/MSM on-chip EHCI USB controller"
 	depends on ARCH_MSM
-	depends on USB_PHY
 	select USB_EHCI_ROOT_HUB_TT
 	select USB_MSM_OTG
 	---help---
-- 
1.7.4.1
