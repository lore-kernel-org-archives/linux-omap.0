From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/6] DSP Gateway: remove manual clockdomain/powerdomain
	tweaking
Date: Tue, 20 May 2008 18:43:00 -0600
Message-ID: <20080521004152.6131.45906.stgit@localhost.localdomain>
References: <20080521003910.6131.63409.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45904 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933456AbYEUAqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 20:46:04 -0400
In-Reply-To: <20080521003910.6131.63409.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>

The recent powerdomain and clockdomain layer updates for OMAP24XX should
now control the DSP powerdomain and clockdomain automatically when
DSP Gateway calls clk_{enable,disable}().  Remove the manual
clockdomain/powerdomain register tweaks from DSP Gateway.


Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/dsp/dspgateway/dsp_core.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/dsp/dspgateway/dsp_core.c b/drivers/dsp/dspgateway/dsp_core.c
index 913376e..68cc9e6 100644
--- a/drivers/dsp/dspgateway/dsp_core.c
+++ b/drivers/dsp/dspgateway/dsp_core.c
@@ -460,16 +460,6 @@ static inline void dsp_clk_disable(void) {}
 #elif defined(CONFIG_ARCH_OMAP2)
 static inline void dsp_clk_enable(void)
 {
-	/*XXX should be handled in mach-omap[1,2] XXX*/
-	prm_write_mod_reg(OMAP24XX_FORCESTATE | (1 << OMAP_POWERSTATE_SHIFT),
-			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
-
-	cm_set_mod_reg_bits(OMAP2420_AUTO_DSP_IPI, OMAP24XX_DSP_MOD,
-			    CM_AUTOIDLE);
-
-	cm_set_mod_reg_bits(OMAP24XX_AUTOSTATE_DSP_MASK, OMAP24XX_DSP_MOD,
-			    CM_CLKSTCTRL);
-
 	clk_enable(dsp_fck_handle);
 	clk_enable(dsp_ick_handle);
 	__dsp_per_enable();
@@ -479,9 +469,6 @@ static inline void dsp_clk_disable(void)
 	__dsp_per_disable();
 	clk_disable(dsp_ick_handle);
 	clk_disable(dsp_fck_handle);
-
-	prm_write_mod_reg(OMAP24XX_FORCESTATE | (3 << OMAP_POWERSTATE_SHIFT),
-			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
 }
 #endif
 


