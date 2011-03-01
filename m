From: Paul Walmsley <paul@pwsan.com>
Subject: RE: Integration branch base switchover to Tony's omap-for-linus
 branch
Date: Tue, 1 Mar 2011 14:33:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103011431240.16349@utopia.booyaka.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com> <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45154 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568Ab1CAVd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 16:33:57 -0500
In-Reply-To: <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org

Hi Santosh

On Tue, 1 Mar 2011, Santosh Shilimkar wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Saturday, February 26, 2011 5:56 AM
> > To: linux-omap@vger.kernel.org
> > Subject: Integration branch base switchover to Tony's omap-for-linus
> > branch
> >
> >
> > Hi,
> >
> > this is a quick note for anyone using the integration-2.6.39 branch
> > on
> > git://git.pwsan.com/linux-2.6: I've switched the base over from
> > mainline to Tony's omap-for-linus branch.
> >
> 
> I observed an issue when integrated omap-for-linus + your branch
> + OMAP4 PM patches. After debugging this with Rajendra, it seems
> that issue is seen only when static dependency between MPU
> and L4PER clock-domain is cleared _and_ L4_PER clock-domain
> is programmed to HW_SUP.
> 
> Since the issue is observed with only I2C IP block from L4_PER
> and none of the other modules are affected, the suspect is I2C
> IP block. The hardware team is investigating this issue.
> 
> So for now, to avoid this abort, there are two options
> 	- Remove HW_SUP from L4_PER CD
> 	- Keep MPU<->L4_PER static dependency.
> 
> We tried both the options and they seems to work.
> Which one you prefer till we have hardware root-cause
> of this issue?

Between the two alternatives you suggested, I'd prefer #1; but could you 
try forcing the I2C blocks to use software idle control instead and see if 
that fixes it without the need to change the clockdomains file?  Sample 
patch follows.  If that fixes it, it might be useful to know whether it is 
the HWMOD_SWSUP_SIDLE flag or HWMOD_NO_OCP_AUTOIDLE flag or both that is 
required.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 1 Mar 2011 14:11:31 -0700
Subject: [PATCH] OMAP4: I2C hwmods: Test patch to attempt to narrow down crashes

Put the I2C IP blocks into software-controlled idle to attempt to narrow down
some crashes.
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 79a8601..8415b97 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2124,7 +2124,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
 static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_SWSUP_SIDLE | HWMOD_NO_OCP_AUTOIDLE,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_irqs),
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
@@ -2177,7 +2177,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
 static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_SWSUP_SIDLE | HWMOD_NO_OCP_AUTOIDLE,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_irqs),
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
@@ -2230,7 +2230,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
 static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_SWSUP_SIDLE | HWMOD_NO_OCP_AUTOIDLE,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_irqs),
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
@@ -2283,7 +2283,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
 static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_RESET | HWMOD_SWSUP_SIDLE | HWMOD_NO_OCP_AUTOIDLE,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_irqs),
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
-- 
1.7.2.3

