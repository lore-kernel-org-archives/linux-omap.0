From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH v2] drivers/gpio: using common order: let 'static const' instead
 of 'const static'
Date: Wed, 06 Feb 2013 18:44:32 +0800
Message-ID: <51123410.40602@asianux.com>
References: <51122147.6080708@asianux.com> <5112241B.8050207@ti.com> <511232B1.7090206@asianux.com> <5112334F.1020508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:3369 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab3BFKoi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 05:44:38 -0500
In-Reply-To: <5112334F.1020508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: linux-omap@vger.kernel.org


  'const static ' is not a common order, better to use 'static const' instead.

building:
  make EXTRA_CFLAGS=-W ARCH=arm

  drivers/gpio/gpio-omap.c:1479:
    warning: 'static' is not at beginning of declaration
  drivers/gpio/gpio-omap.c:1485:
    warning: 'static' is not at beginning of declaration
  drivers/gpio/gpio-omap.c:1491:
    warning: 'static' is not at beginning of declaration


Signed-off-by: Chen Gang <gang.chen@asianux.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/gpio/gpio-omap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f1fbedb2..159f5c5 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1476,19 +1476,19 @@ static struct omap_gpio_reg_offs omap4_gpio_regs = {
 	.fallingdetect =	OMAP4_GPIO_FALLINGDETECT,
 };
 
-const static struct omap_gpio_platform_data omap2_pdata = {
+static const struct omap_gpio_platform_data omap2_pdata = {
 	.regs = &omap2_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = false,
 };
 
-const static struct omap_gpio_platform_data omap3_pdata = {
+static const struct omap_gpio_platform_data omap3_pdata = {
 	.regs = &omap2_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
 };
 
-const static struct omap_gpio_platform_data omap4_pdata = {
+static const struct omap_gpio_platform_data omap4_pdata = {
 	.regs = &omap4_gpio_regs,
 	.bank_width = 32,
 	.dbck_flag = true,
-- 
1.7.7.6
