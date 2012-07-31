From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
Date: Tue, 31 Jul 2012 13:16:42 -0500
Message-ID: <5018210A.1040902@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com> <1339104132-26885-9-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com> <500028B3.1040309@ti.com> <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com> <50045D17.9050704@ti.com> <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com> <50171841.40309@ti.com> <501760BF.8070801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54251 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755230Ab2GaSQo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 14:16:44 -0400
In-Reply-To: <501760BF.8070801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Paul,

On 07/30/2012 11:36 PM, Jon Hunter wrote:
> Hi Paul,
> 
> On 07/30/2012 06:26 PM, Jon Hunter wrote:
> 
> [...]
> 
>> 1. When HWMOD attempts to disable the clock domain for OMAP2/3 devices 
>>    we simply return without doing anything. Not sure if it is safe to 
>>    remove this but I can do some more testing on OMAP2/3. 
>>
>> commit a0307bd539ecef976793679a1c4ff0d47b22c4bd
>> Author: Jon Hunter <jon-hunter@ti.com>
>> Date:   Mon Jul 30 18:04:06 2012 -0500
>>
>>     ARM: OMAP2/3: Allow HWMOD to disable clock domains
>>     
>>     Currently when HWMOD attempts to disable a clock domain on OMAP2/3 devices we
>>     will return from the function clkdm_hwmod_disable() without actually disabling
>>     the clock domain. Per the comment this is deliberate because initially HWMOD
>>     OMAP2/3 devices did not support clock domains. However, clock domains are now
>>     supported by HWMOD for these devices and so allow HWMOD to disable the clock
>>     domains.
>>     
>>     XXX - Tested on OMAP3430 beagle board, but needs more testing on OMAP2/3
>>
>> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
>> index 011186f..8f7a941 100644
>> --- a/arch/arm/mach-omap2/clockdomain.c
>> +++ b/arch/arm/mach-omap2/clockdomain.c
>> @@ -1075,10 +1075,6 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>>   */
>>  int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
>>  {
>> -       /* The clkdm attribute does not exist yet prior OMAP4 */
>> -       if (cpu_is_omap24xx() || cpu_is_omap34xx())
>> -               return 0;
>> -
>>         /*
>>          * XXX Rewrite this code to maintain a list of enabled
>>          * downstream hwmods for debugging purposes?
>>
>>
>> 2. I need to make the following changes to your patch. The change to
>>    omap2_clkdm_clk_disable() was needed to get the EMU to turn off.
>>    At the same time I thought we should make the same change to
>>    omap2_clkdm_clk_enable().
>>
>> diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
>> index 09385a9..c94b2fb 100644
>> --- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
>> +++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
>> @@ -223,7 +223,8 @@ static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
>>                 _enable_hwsup(clkdm);
>>         } else {
>>                 if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
>> -                       omap2_clkdm_wakeup(clkdm);
>> +                       (cpu_is_omap24xx()) ? omap2_clkdm_wakeup(clkdm) :
>> +                               omap3_clkdm_wakeup(clkdm);
>>         }
>>  
>>         return 0;
>> @@ -257,7 +258,8 @@ static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)
>>                 _enable_hwsup(clkdm);
>>         } else {
>>                 if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
>> -                       omap2_clkdm_sleep(clkdm);
>> +                       (cpu_is_omap24xx()) ? omap2_clkdm_sleep(clkdm) :
>> +                               omap3_clkdm_sleep(clkdm);
>>         }
> 
> I just remembered you sending out a patch [1] to address #2 above. Let
> me know your thoughts about change #1.

So scratch item #1 above. As Rajendra pointed out in another thread this
is not right. The only other comment I have with your patch is maybe we
need to add the following to prevent the EMU PD being idled during
boot-up if enabled early in the boot process. 

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 011186f..84d3fbc 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -825,7 +825,8 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
        if (!clkdm)
                return;
 
-       if (!(clkdm->flags & CLKDM_CAN_ENABLE_AUTO)) {
+       if (!(clkdm->flags & CLKDM_CAN_ENABLE_AUTO) ||
+                       (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING)) {
                pr_debug("clock: automatic idle transitions cannot be enabled "
                         "on clockdomain %s\n", clkdm->name);
                return;

Cheers
Jon
