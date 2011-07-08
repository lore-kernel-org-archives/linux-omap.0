From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/3] I2C: OMAP2+: Tag all OMAP2+ hwmod defintions with I2C IP revision
Date: Fri,  8 Jul 2011 09:11:43 -0700
Message-ID: <1310141504-13688-3-git-send-email-khilman@ti.com>
References: <1310141504-13688-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:56155 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752225Ab1GHQLu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 12:11:50 -0400
Received: by mail-pz0-f49.google.com with SMTP id 28so2549276pzk.22
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 09:11:50 -0700 (PDT)
In-Reply-To: <1310141504-13688-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Andy Green <andy@warmcat.com>, linux-arm-kernel@lists.infradead.org

From: Andy Green <andy@warmcat.com>

Since we cannot trust (or even reliably find) the OMAP I2C
peripheral unit's own revision register, we must inform the
OMAP i2c driver of which IP version it is running on.  We
do this by tagging the omap_hwmod_class for i2c on all the
OMAP2+ platform / cpu specific hwmod init and passing it up
to the driver (next patches).

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index c4d0ae8..2223c44 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1447,6 +1447,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
+	.rev		= OMAP_I2C_IP_VERSION_1,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr;
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 0c272be..dbcc36e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1524,6 +1524,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
+	.rev		= OMAP_I2C_IP_VERSION_1,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 78efb59..80839b1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1460,6 +1460,7 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 static struct omap_hwmod_class i2c_class = {
 	.name = "i2c",
 	.sysc = &i2c_sysc,
+	.rev  = OMAP_I2C_IP_VERSION_1,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ba5e05a..6578a36 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2125,6 +2125,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap44xx_i2c_sysc,
+	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
 /* i2c1 */
-- 
1.7.6

