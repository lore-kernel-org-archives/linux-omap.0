From: Romit Dasgupta <romit@ti.com>
Subject: RE: omap3evm: touchscreen delays on pm branch
Date: Fri, 27 Nov 2009 14:37:39 +0530
Message-ID: <1259312859.19138.4.camel@boson>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com>
	 <4B0F9045.6030404@ti.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B90E2@dbde02.ent.ti.com>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48888 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbZK0JHi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Nov 2009 04:07:38 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAR97gkA013783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 03:07:44 -0600
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE7B90E2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2009-11-27 at 14:11 +0530, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: Dasgupta, Romit 
> > Sent: Friday, November 27, 2009 2:10 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: omap3evm: touchscreen delays on pm branch
> > 
> > Premi, Sanjeev wrote:
> > > Hi,
> > > 
> > > I am finding the response of touchscreen on the omap3evm very slow.
> > > 
> > > Here is my test:
> > > On console, I run : watch -n2 "cat /proc/interrupts"
> > > Then, I tap the touchscreen approximately once per second. However,
> > > (usually) no interrupts are registered. As I increase the frequency
> > > of 'taps' more and more interrupts are registered. But still not
> > > matching exact taps.
> > > 
> > > However, when I keep the cpu busy with "cat /dev/zero > /dev/null &"
> > > each tap is recognized.
> > > 
> > Do you see this even if we don't enable OFF?
> > 
> Yes. Sleep_while_idle=0; enable_off_mode=0
> ~sanjeev

Hopefully you have the same TSC driver. Nevertheless, can you please try
this (just to see if clock domain idling is causing any problem or not):

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1cfa5a6..79710a1 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -248,7 +248,8 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C2].threshold;
 	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
-	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C3 . MPU CSWR + Core inactive */
 	omap3_power_states[OMAP3_STATE_C3].valid =

