From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] RX-51: Fix probe order of SPI devices
Date: Sun, 31 Mar 2013 12:09:21 +0200
Message-ID: <1364724561-18045-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Joni Lapilainen <joni.lapilainen@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

=46rom: Joni Lapilainen <joni.lapilainen@gmail.com>

Without this patch LCD panel on Nokia RX-51 is still black

Signed-off-by: Joni Lapilainen <joni.lapilainen@gmail.com>
Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index b09b5da..03290b9 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -91,8 +91,8 @@
 /* list all spi devices here */
 enum {
 	RX51_SPI_WL1251,
-	RX51_SPI_MIPID,		/* LCD panel */
 	RX51_SPI_TSC2005,	/* Touch Controller */
+	RX51_SPI_MIPID,		/* LCD panel */
 };
=20
 static struct wl12xx_platform_data wl1251_pdata;
--=20
1.7.10.4
