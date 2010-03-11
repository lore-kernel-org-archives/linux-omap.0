From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/19] omap: Fix gpio_resume_after_retention
Date: Thu, 11 Mar 2010 15:56:40 -0800
Message-ID: <20100311235640.GW2900@atomide.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
 <20100311234834.4500.12726.stgit@baageli.muru.com>
 <A24693684029E5489D1D202277BE894453FB11F8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xkXJwpr35CY/Lc3I"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59836 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997Ab0CKXzV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:55:21 -0500
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894453FB11F8@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Aguirre, Sergio <saaguirre@ti.com> [100311 15:47]:
> Hi Tony,
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Thursday, March 11, 2010 5:49 PM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: Aguirre, Sergio; linux-omap@vger.kernel.org
> > Subject: [PATCH 12/19] omap: Fix gpio_resume_after_retention
> > 
> > From: Tony Lindgren <Aguirre>
> 
> Something funky mix happened with the authorship here :)
> 
> Should be:
> 
> From: Sergio Aguirre <saaguirre@ti.com>

Thanks, updated patch below.

I think this issue is related to applying patches from
patchwork.kernel.org with email addresses in Lastname, Firstname
format..

Tony

--xkXJwpr35CY/Lc3I
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="gpio-fix.patch"

>From f00d649703fbedbdeb33d63c4c4731656e11297c Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Wed, 3 Mar 2010 16:21:08 +0000
Subject: [PATCH] omap: Fix gpio_resume_after_retention

For omap4 case, this was wrongly writing GPIO_LEVELDETECTx
registers with OMAP24XX_ offset and OMAP4_ offset.

Bug introduced in commit:

  commit 3f1686a9bfe74979c6ad538c78039730f665f77e
  Author: Tony Lindgren <tony@atomide.com>
  Date:   Mon Feb 15 09:27:25 2010 -0800

      omap: Fix gpio.c for multi-omap for omap4

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 337199e..76a347b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2140,18 +2140,18 @@ void omap2_gpio_resume_after_retention(void)
 		if (gen) {
 			u32 old0, old1;
 
-			if (cpu_is_omap24xx() || cpu_is_omap44xx()) {
+			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 				old0 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
 				old1 = __raw_readl(bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(old0 | gen, bank->base +
+				__raw_writel(old0 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(old1 | gen, bank->base +
+				__raw_writel(old1 | gen, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(old0, bank->base +
+				__raw_writel(old0, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(old1, bank->base +
+				__raw_writel(old1, bank->base +
 					OMAP24XX_GPIO_LEVELDETECT1);
 			}
 

--xkXJwpr35CY/Lc3I--
