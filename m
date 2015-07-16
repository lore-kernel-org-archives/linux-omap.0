From: "R, Vignesh" <vigneshr@ti.com>
Subject: Re: [PATCH v2 1/5] ARM: OMAP2+: DRA7: clockdomain: change l4per2_7xx_clkdm
 to SW_WKUP
Date: Thu, 16 Jul 2015 20:56:54 +0530
Message-ID: <55A7CD3E.3030803@ti.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com> <1433332284-10766-2-git-send-email-vigneshr@ti.com> <alpine.DEB.2.02.1507151955330.32764@utopia.booyaka.com> <alpine.DEB.2.02.1507152020240.32764@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1507152020240.32764@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 07/16/2015 01:57 AM, Paul Walmsley wrote:
> On Wed, 15 Jul 2015, Paul Walmsley wrote:
> 
>> On Wed, 3 Jun 2015, Vignesh R wrote:
>>
>>> Legacy IPs like PWMSS, present under l4per2_7xx_clkdm, cannot support
>>> smart-idle when its clock domain is in HW_AUTO on DRA7 SoCs. Hence,
>>> program clock domain to SW_WKUP.
>>>
>>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
>>> index 57d5df0c1fbd..7581e036bda6 100644
>>> --- a/arch/arm/mach-omap2/clockdomains7xx_data.c
>>> +++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
>>> @@ -331,7 +331,7 @@ static struct clockdomain l4per2_7xx_clkdm = {
>>>  	.dep_bit	  = DRA7XX_L4PER2_STATDEP_SHIFT,
>>>  	.wkdep_srcs	  = l4per2_wkup_sleep_deps,
>>>  	.sleepdep_srcs	  = l4per2_wkup_sleep_deps,
>>> -	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
>>> +	.flags		  = CLKDM_CAN_SWSUP,
>>>  };
>>>  
>>>  static struct clockdomain mpu0_7xx_clkdm = {
>>
>> Thanks, queued for v4.2-rc fixes.  Note that I cannot test this, since I 
>> don't have a DRA7xx board.
> 
> You know, upon further thought, this doesn't make sense.  If the bug
> is with the PWMSS IP block specifically, why not just set 
> HWMOD_SWSUP_SIDLE on all the IP blocks where the hardware folks didn't 
> implement hardware smart-idle?  At least that way, if those legacy IP 
> blocks aren't in use, the clockdomain can still enter hardware-supervised 
> idle?

According to hardware folks, HW_AUTO (for clockdomain) and
HWMOD_SWSUP_SIDLE (PWMSS in NO-IDLE) for PWMSS *is not* a good
combination. If clockdomain is in HW_AUTO and PWMSS is put in NO-IDLE,
then IDLEST of PWMSSx_CLKCTRL reads "stuck in wakeup/ sleep transition"
which is not a consistent state (this is because of problems with PWM
IP). Hence, it is recommended to program the clock domain to SW_WKUP and
leave the PWMSS idlemode as smart-idle.

-- 
Regards
Vignesh
