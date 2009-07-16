From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 10/13] DSPBRIDGE: HACK: insert delay for DPLL
 stabilization
Date: Thu, 16 Jul 2009 11:53:03 +0300 (EEST)
Message-ID: <20090716.115303.71102875.Hiroshi.DOYU@nokia.com>
References: <1247669795-23895-9-git-send-email-ameya.palande@nokia.com>
	<1247669795-23895-10-git-send-email-ameya.palande@nokia.com>
	<1247669795-23895-11-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31087 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbZGPIxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 04:53:43 -0400
In-Reply-To: <1247669795-23895-11-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omar.ramirez@ti.com, x0095840@ti.com
Cc: linux-omap@vger.kernel.org, nm@ti.com, ameya.palande@nokia.com

Hi,

From: "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>
Subject: [PATCH 10/13] DSPBRIDGE: HACK: insert delay for DPLL stabilization
Date: Wed, 15 Jul 2009 16:56:33 +0200

> *HACK*: status register should be checked for this purpose.
> 
> [Hiroshi DOYU: split the original to logical ones]
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  drivers/dsp/bridge/wmd/tiomap_sm.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
> index 7d389e3..02e2675 100644
> --- a/drivers/dsp/bridge/wmd/tiomap_sm.c
> +++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
> @@ -141,6 +141,13 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
>  		temp = (temp & 0xFFFFFF08) | 0x37;
>  		*(REG_UWORD32 *)(resources.dwCmBase + 0x4) = temp;
>  
> +		/*
> +		 * This delay is needed to avoid mailbox timed out
> +		 * issue experienced while SmartReflex is ON.
> +		 * TODO: Instead of 1 ms calculate proper value.
> +		 */
> +		mdelay(1);
> +

I have tried the following patch and it seems that CM_IDLEST_PLL_IVA2
has never got locked.

Is any special sequence required?

>From af2ab46ad5bdcae57e7bf9ac735e3862ec2f45e6 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Thu, 16 Jul 2009 11:48:19 +0300
Subject: [PATCH 1/1] DSPBRIDGE: poll IDLEST_PLL register for DPLL locking

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/wmd/tiomap_sm.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c b/drivers/dsp/bridge/wmd/tiomap_sm.c
index ca9202d..aaea896 100644
--- a/drivers/dsp/bridge/wmd/tiomap_sm.c
+++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
@@ -137,12 +137,21 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
 		temp = (temp & 0xFFFFFF08) | 0x37;
 		*(REG_UWORD32 *)(resources.dwCmBase + 0x4) = temp;
 
-		/*
-		 * This delay is needed to avoid mailbox timed out
-		 * issue experienced while SmartReflex is ON.
-		 * TODO: Instead of 1 ms calculate proper value.
-		 */
-		mdelay(1);
+		/* Poll CM_IDLEST_PLL_IVA2 */
+		timeout = jiffies + msecs_to_jiffies(1000);
+		while (1) {
+			u32 l;
+
+			l = __raw_readl(resources.dwCmBase + 0x24);
+			if (l & 1)
+				break;
+
+			if (time_after(jiffies, timeout)) {
+				pr_err("%s(): dpll2 lock timeout\n", __func__);
+				return WMD_E_TIMEOUT;
+			}
+		}
+		pr_info("%s(): dpll2 locked\n", __func__);
 
 		/* Restore mailbox settings */
 		HW_MBOX_restoreSettings(resources.dwMboxBase);
-- 
1.6.0.4



>  		/* Restore mailbox settings */
>  		HW_MBOX_restoreSettings(resources.dwMboxBase);
>  
> -- 
> 1.6.2.4
> 
