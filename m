From: Kalle Valo <kalle.valo@nokia.com>
Subject: [PATCH 3/3] Disable linux-omap version of menelaus
Date: Thu, 22 Jan 2009 15:19:20 +0200
Message-ID: <20090122131920.18315.68032.stgit@tikku>
References: <20090122131602.18315.84862.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60741 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZAVNTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 08:19:50 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0MDJWZX028917
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 15:19:47 +0200
Received: from [127.0.1.1] (essapo-nirac252253.europe.nokia.com [10.162.252.253])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0MDJKqY005521
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 15:19:21 +0200
In-Reply-To: <20090122131602.18315.84862.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fixes linker errors like this:

drivers/i2c/built-in.o: In function `menelaus_set_vdcdc':
lp5521.c:(.text+0x3910): multiple definition of `menelaus_set_vdcdc'
drivers/mfd/built-in.o:menelaus.c:(.text+0x95c): first defined here
drivers/i2c/built-in.o: In function `menelaus_set_vio':
lp5521.c:(.text+0x3990): multiple definition of `menelaus_set_vio'

Signed-off-by: Kalle Valo <kalle.valo@nokia.com>
---

 drivers/i2c/chips/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index b451369..d8bef8c 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_PCF8575)		+= pcf8575.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
-obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
 obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o

