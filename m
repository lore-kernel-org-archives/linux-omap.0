From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 04/18] I2C: OMAP2+: hwmod data: Tag all OMAP2+ hwmod
 definitions with I2C IP revision
Date: Tue, 15 Mar 2011 19:56:18 +0000
Message-ID: <20110315195618.30000.53926.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62524 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab1COT4V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:56:21 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so915512wya.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:56:21 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>, Benoit Cousson <b-cousson@ti.com>

Since we cannot trust (or even reliably find) the OMAP I2C
peripheral unit's own revision register, we must inform the
OMAP I2C driver of which IP version it is running on.  We
do this by tagging the omap_hwmod_class for I2C on all the
OMAP2+ platform / cpu specific hwmod init and passing it up
to the driver (next patches).

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b85c630..64f60f9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -482,6 +482,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
+	.rev		= OMAP_I2C_IP_VERSION_1,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr;
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index eeb6348..feb8655 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -481,6 +481,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
+	.rev		= OMAP_I2C_IP_VERSION_1,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index cc94616..6b3ccb6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -662,6 +662,7 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 static struct omap_hwmod_class i2c_class = {
 	.name = "i2c",
 	.sysc = &i2c_sysc,
+	.rev  = OMAP_I2C_IP_VERSION_1,
 };
 
 /* I2C1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f8400a1..e50a79b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1111,6 +1111,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap44xx_i2c_sysc,
+	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
 /* i2c1 */

