From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 6/8] ARM: OMAP4: PM: support
 ret_logic/mem_off_counters
Date: Tue, 8 May 2012 11:36:38 +0300
Message-ID: <1336466198.2149.269.camel@sokoban>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
	 <1334913591-26312-7-git-send-email-t-kristo@ti.com> <87pqafv810.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36862 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab2EHIgp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 04:36:45 -0400
In-Reply-To: <87pqafv810.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Axel Haslam <axelhaslam@gmail.com>, Rajendra Nayak <rnayak@ti.com>

On Mon, 2012-05-07 at 17:19 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > From: Axel Haslam <axelhaslam@gmail.com>
> >
> > On OMAP4, there is no support to read previous logic state
> > or previous memory state achieved when a power domain transitions
> > to RET. Instead there are module level context registers.
> >
> > In order to support the powerdomain level logic/mem_off_counters
> > on OMAP4, instead use the previous power state achieved (RET) and
> > the *programmed* logic/mem RET state to derive if a powerdomain lost
> > logic or did not.
> 
> OK, but this also changes the behavior for OMAP3 as well, right?  I
> don't see in the changelog how this affects OMAP3 and whether it is
> still expected to work on OMAP3.  When changing common code like this,
> the changelog should describe the impacts on to all affected SoCs.
> 
> As suggested by Vaibhav Bedia, now might be the right time to add this
> function to the SoC specific function pointers (struct pwrdm_ops.)
> 
> Doing that, the existing function could be used for OMAP3 (and OMAP4 if
> the changelog describes that it can/should be used for both.)
> 
> Then, when AM33xx support is added, it will be obvious where they will
> need to plugin support for that SoC.

How about the following patch? It will add a couple of redundant
read_prev_pwrst calls, but works in the same way as the original patch,
without touching the generic code. Also, as there have been talks about
adding caching for some of the pwrdm registers (especially the
prev_pwrst), this might not be that big of an issue.

If this looks good to you, I'll re-post the set with this patch.

-Tero


diff --git a/arch/arm/mach-omap2/powerdomain44xx.c
b/arch/arm/mach-omap2/powerdomain44xx.c
index 9bfb8a0..3d5e8d4 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -155,6 +155,14 @@ static int omap4_pwrdm_read_logic_retst(struct
powerdomain *pwrdm)
 	return v;
 }
 
+static int omap4_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
+{
+	if (omap4_pwrdm_read_prev_pwrst(pwrdm) != PWRDM_POWER_RET)
+		return PWRDM_POWER_ON;
+
+	return omap4_pwrdm_read_logic_retst(pwrdm);
+}
+
 static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8
bank)
 {
 	u32 m, v;
@@ -183,6 +191,14 @@ static int omap4_pwrdm_read_mem_retst(struct
powerdomain *pwrdm, u8 bank)
 	return v;
 }
 
+static int omap4_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm,
u8 bank)
+{
+	if (omap4_pwrdm_read_prev_pwrst(pwrdm) != PWRDM_POWER_RET)
+		return PWRDM_POWER_ON;
+
+	return omap4_pwrdm_read_mem_retst(pwrdm, bank);
+}
+
 static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 {
 	u32 c = 0;
@@ -256,9 +272,11 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_clear_all_prev_pwrst	= omap4_pwrdm_clear_all_prev_pwrst,
 	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
+	.pwrdm_read_prev_logic_pwrst	= omap4_pwrdm_read_prev_logic_pwrst,
 	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
 	.pwrdm_read_mem_pwrst	= omap4_pwrdm_read_mem_pwrst,
 	.pwrdm_read_mem_retst	= omap4_pwrdm_read_mem_retst,
+	.pwrdm_read_prev_mem_pwrst	= omap4_pwrdm_read_prev_mem_pwrst,
 	.pwrdm_set_mem_onst	= omap4_pwrdm_set_mem_onst,
 	.pwrdm_set_mem_retst	= omap4_pwrdm_set_mem_retst,
 	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,


