From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Mon, 8 Oct 2012 17:24:15 -0500
Message-ID: <5073528F.2020902@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com> <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com> <50171841.40309@ti.com> <501760BF.8070801@ti.com> <5018210A.1040902@ti.com> <50187644.40308@ti.com> <alpine.DEB.2.00.1208010932270.21488@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53708 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264Ab2JHWYY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Oct 2012 18:24:24 -0400
In-Reply-To: <alpine.DEB.2.00.1208010932270.21488@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Madhav Vij <mvij@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 08/01/2012 10:36 AM, Paul Walmsley wrote:
> Hi Jon et al,
> 
> Here's what I'm planning to queue here.  The only changes from what Jon
> posted are the patch changelog and some checkpatch fixes.  If anyone
> has any final comments, please let me know.
> 
> 
> - Paul
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Wed, 1 Aug 2012 09:11:20 -0600
> Subject: [PATCH] ARM: OMAP2+: clockdomain/hwmod: add workaround for EMU
>  clockdomain idle problems

[snip]

> diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> index f99e65c..3f4b04b 100644
> --- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
> @@ -248,6 +248,17 @@ static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
>  	if (!clkdm->clktrctrl_mask)
>  		return 0;
>  
> +	/*
> +	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
> +	 * more details on the unpleasant problem this is working
> +	 * around
> +	 */
> +	if ((clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) &&
> +	    (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
> +		omap3_clkdm_wakeup(clkdm);
> +		return 0;
> +	}
> +
>  	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
>  				clkdm->clktrctrl_mask);
>  
> @@ -271,6 +282,17 @@ static int omap3xxx_clkdm_clk_disable(struct clockdomain *clkdm)
>  	if (!clkdm->clktrctrl_mask)
>  		return 0;
>  
> +	/*
> +	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
> +	 * more details on the unpleasant problem this is working
> +	 * around
> +	 */
> +	if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING &&
> +	    !(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
> +		_enable_hwsup(clkdm);
> +		return 0;
> +	}
> +
>  	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
>  				clkdm->clktrctrl_mask);

I was looking at what got merged and it appears that the above code was
added to the omap2 clkdm enable/disable functions and not omap3. I believe
that is a mistake? If so the below fixes this.

Cheers
Jon

>From 16db11f3373bc6e03254c4d1d92ee762f69cbacc Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Wed, 1 Aug 2012 09:36:13 -0600
Subject: [PATCH] ARM: OMAP3: fix workaround for EMU clockdomain

Commit b71c721 (ARM: OMAP2+: clockdomain/hwmod: add workaround for EMU
clockdomain idle problems) added a workaround for the EMU clock domain on
OMAP3/4 devices to prevent the clock domain for transitioning while it is
in use.

In the proposed patch [1] code was added to the omap3xxx_clkdm_clk_enable()
and omap3xxx_clkdm_clk_disable() functions to check for the flag
CLKDM_MISSING_IDLE_REPORTING and perform the appropriate action. However, in the
merged patch it appears that this code was added to the omap2_clkdm_clk_enable()
and omap2_clkdm_clk_disable() functions by mistake.

[1] http://marc.info/?l=linux-arm-kernel&m=134383567112518&w=2

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c |   44 ++++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index 9a7792a..70294f5 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -183,17 +183,6 @@ static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
-	/*
-	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
-	 * more details on the unpleasant problem this is working
-	 * around
-	 */
-	if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING &&
-	    !(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
-		_enable_hwsup(clkdm);
-		return 0;
-	}
-
 	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 
@@ -217,17 +206,6 @@ static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
-	/*
-	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
-	 * more details on the unpleasant problem this is working
-	 * around
-	 */
-	if ((clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) &&
-	    (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
-		omap3_clkdm_wakeup(clkdm);
-		return 0;
-	}
-
 	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 
@@ -269,6 +247,17 @@ static int omap3xxx_clkdm_clk_enable(struct clockdomain *clkdm)
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
+	/*
+	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
+	 * more details on the unpleasant problem this is working
+	 * around
+	 */
+	if ((clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) &&
+	    (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)) {
+		omap3_clkdm_wakeup(clkdm);
+		return 0;
+	}
+
 	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 
@@ -292,6 +281,17 @@ static int omap3xxx_clkdm_clk_disable(struct clockdomain *clkdm)
 	if (!clkdm->clktrctrl_mask)
 		return 0;
 
+	/*
+	 * The CLKDM_MISSING_IDLE_REPORTING flag documentation has
+	 * more details on the unpleasant problem this is working
+	 * around
+	 */
+	if (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING &&
+	    !(clkdm->flags & CLKDM_CAN_FORCE_SLEEP)) {
+		_enable_hwsup(clkdm);
+		return 0;
+	}
+
 	hwsup = omap2_cm_is_clkdm_in_hwsup(clkdm->pwrdm.ptr->prcm_offs,
 				clkdm->clktrctrl_mask);
 
-- 
1.7.9.5

