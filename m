From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 6/6] gnss: add w2sg0004 to Kconfig
Date: Thu,  3 May 2018 11:35:51 +0200
Message-ID: <7035d90fb71c4bc9d2e7c1090b77bdd6bdfd9871.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
In-Reply-To: <cover.1525340143.git.hns@goldelico.com>
References: <cover.1525340143.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, afd@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kevin Hilman <khilman@baylibre.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Allow to configure for w2sg0004 driver.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gnss/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
index 6abc88514512..ccc128bd0a3f 100644
--- a/drivers/gnss/Kconfig
+++ b/drivers/gnss/Kconfig
@@ -40,4 +40,14 @@ config GNSS_UBX_SERIAL
 
 	  If unsure, say N.
 
+config GNSS_W2SG0004
+	tristate "W2SG00x4 power on/off driver"
+	depends on GPIOLIB && SERIAL_DEV_BUS
+	help
+	  Enable on/off control of W2SG00x4 GPS module connected
+	  to some SoC UART to allow powering up/down if the /dev/gnss
+	  is opened/closed.
+
+	  It also provides a "rfkill gps" name to control the LNA power.
+
 endif # GNSS
-- 
2.12.2
