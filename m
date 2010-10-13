From: GERBER Patrick <Patrick.Gerber@heig-vd.ch>
Subject: [Patch] ADS7846: Changing chip detection channel due to improper
 detection
Date: Wed, 13 Oct 2010 16:47:06 +0200
Message-ID: <8959501C0BAF9F40956CEBAD13FB297F17F38C759B@EINTMBX.einet.ad.eivd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailcl2.heig-vd.ch ([193.134.216.183]:40051 "EHLO heig-vd.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751199Ab0JMOrL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Oct 2010 10:47:11 -0400
Content-Language: fr-CH
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "imre.deak@nokia.com" <imre.deak@nokia.com>

Hello,

I am using the TSC2046 (newer ADS7846 silicon) on a custom design where the AUX input is not used and so pulled to GND.
The ADS7846  driver is using the value of the AUX input to detect if a chip is connected or not. If the AUX value is 0x000 or 0xFFF the driver think that there is no chip.
In my case due to the fact that the AUX input is  pulled to GND the 0x000 value is normal.

Therefore I suggest to use the temp1 channel instead of the AUX channel. The temperature will probably never be 0x000.

Patrick


Signed-off-by: Patrick Gerber <patrick.gerber@heig-vd.ch>
---
 drivers/input/touchscreen/ads7846.c |   2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 930e780..20a5f4e 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1178,7 +1178,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
         * the touchscreen, in case it's not connected.
         */
        err = ads7846_read12_ser(&spi->dev,
-                         READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
+                         READ_12BIT_SER(temp1) | ADS_PD10_ALL_ON);
 
        /* if sample is all 0's or all 1's then there is no device on spi */
        if ( (err == 0x000) || (err == 0xfff)) {
