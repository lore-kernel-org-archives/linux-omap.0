From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 6/9] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clkevent device
Date: Thu, 8 Aug 2013 14:49:49 -0500
Message-ID: <5203F65D.9030501@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-7-git-send-email-d-gerlach@ti.com>
 <8738qkhwey.fsf@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8738qkhwey.fsf@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Vaibhav Bedia <vaibhav.bedia@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 08/08/2013 01:25 PM, Kevin Hilman wrote:
> Dave Gerlach <d-gerlach@ti.com> writes:
>
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
>>   arch/arm/mach-omap2/timer.c |   32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index b37e1fc..cce5d39 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -118,11 +118,43 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
>>   	}
>>   }
>>
>> +static void omap_clkevt_suspend(struct clock_event_device *unused)
>> +{
>> +	char name[10];
>> +	struct omap_hwmod *oh;
>> +
>> +	sprintf(name, "timer%d", clkev.id);
>> +	oh = omap_hwmod_lookup(name);
>
> /me stops reviewing here.  This should be a one-time thing.
>
> Seeing things *again* in patches that I've already reviewed (multiple
> times) is very frustrating.  It also increases the likelihood of future
> patches to be "filtered."  (in this case, you get a pass since you seem
> to have inherited Vaibhav's code, but please take care to address all
> reviewer comments, or at least explain why you didn'.)
>
> Kevin
>

Sorry for missing this. Seems I missed this patch completely when taking 
over. I'll make sure it's addressed in the next version.

Regards,
Dave
