From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 3/3] OMAP UART: Adding support for omap-serial driver.
Date: Tue, 22 Sep 2009 22:34:54 +0530 (IST)
Message-ID: <51337.192.168.10.88.1253639094.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Govindraj R <govindraj.raja@ti.com>

This patch adds omap-serial driver support 3430SDP.

Signed-off-by:	Govindraj R <govindraj.raja@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 8a4a7e2..787d52e 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -880,6 +880,7 @@ CONFIG_SERIAL_8250_RSA=y
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_OMAP is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 # CONFIG_LEGACY_PTYS is not set

