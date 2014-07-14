From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v4 03/11] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clkevent device
Date: Mon, 14 Jul 2014 10:37:19 -0400
Message-ID: <53C3EB1F.2010109@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <1405047349-15101-4-git-send-email-d-gerlach@ti.com>
 <20140714111536.GC20068@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140714111536.GC20068@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tero Kristo <t-kristo@ti.com>, Russ Dill <russ.dill@ti.com>, Daniel Mack <daniel@zonque.org>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 14 July 2014 07:15 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [140710 19:59]:
>> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>>
>> OMAP timer code registers two timers - one as clocksource
>> and one as clockevent. Since AM33XX has only one usable timer
>> in the WKUP domain one of the timers needs suspend-resume
>> support to restore the configuration to pre-suspend state.
>>
>> commit adc78e6 (timekeeping: Add suspend and resume
>> of clock event devices) introduced .suspend and .resume
>> callbacks for clock event devices. Leverages these
>> callbacks to have AM33XX clockevent timer which is
>> in not in WKUP domain to behave properly across system
>> suspend.
>>
>> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>> v3->v4:
>> 	Only use for am33xx soc now.
>>
>>  arch/arm/mach-omap2/timer.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index 43d03fb..6fc1748 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -128,6 +128,29 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>>  	}
>>  }
>>  
>> +static void omap_clkevt_suspend(struct clock_event_device *unused)
>> +{
>> +	struct omap_hwmod *oh;
>> +
>> +	oh = omap_hwmod_lookup(clockevent_gpt.name);
>> +	if (!oh)
>> +		return;
>> +
>> +	omap_hwmod_idle(oh);
>> +}
>> +
>> +static void omap_clkevt_resume(struct clock_event_device *unused)
>> +{
>> +	struct omap_hwmod *oh;
>> +
>> +	oh = omap_hwmod_lookup(clockevent_gpt.name);
>> +	if (!oh)
>> +		return;
>> +
>> +	omap_hwmod_enable(oh);
>> +	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
>> +}
>> +
> 
> This is going to make moving the timer code into drivers one step
> tougher to do. And you don't need to look up the hwmod entry every
> time, just initialize it during the init.
> 
>> +	if (soc_is_am33xx()) {
>> +		clockevent_gpt.suspend = omap_clkevt_suspend;
>> +		clockevent_gpt.resume = omap_clkevt_resume;
>> +	}
>> +
> 
> Maybe try to set up things so we initialize the SoC specific
> timer suspend and resume functions in mach-omap2/timer.c
> in a way where eventually the device driver can easily use
> them?
> 
+1. I had similar comments on the previous version too.

Regards,
Santosh
