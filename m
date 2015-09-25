From: Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH 2/2] arm: omap2+: PM: change trace_power_domain_target
 event format.
Date: Fri, 25 Sep 2015 16:57:49 +0200
Message-ID: <560560ED.5000803@baylibre.com>
References: <1443187345-14834-1-git-send-email-mtitinger+renesas@baylibre.com>
 <1443187345-14834-3-git-send-email-mtitinger+renesas@baylibre.com>
 <20150925101025.6b3862bf@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150925101025.6b3862bf@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: khilman@kernel.org, rjw@rjwysocki.net, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 25/09/2015 16:10, Steven Rostedt wrote:
> On Fri, 25 Sep 2015 15:22:25 +0200
> Marc Titinger <mtitinger@baylibre.com> wrote:
>
>> From: Marc Titinger <mtitinger@baylibre.com>
>>
>> power_domain_target arg3 is now a string (event name) with generic power
>> domains. In the case of Omap, it is a hint to the prev/next switch op.
>> Incidentally this trace is now conditioned by CONFIG_PM_ADVANCED_DEBUG.
> I'm curious to why the addition of this config option?
>
I meant to be consistent with Juno/generic-power-domains, so that this 
trace always (or never) requires this switch.
I think I will remove this condition for both actually.

>> Compiled for Omap2+ but not tested.
>>
>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>> ---
>>   arch/arm/mach-omap2/powerdomain.c | 32 ++++++++++++++++++++------------
>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> index 78af6d8..cd77696 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -160,7 +160,7 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
>>   static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>>   {
>>   
>> -	int prev, next, state, trace_state = 0;
>> +	int prev, state;
>>   
>>   	if (pwrdm == NULL)
>>   		return -EINVAL;
>> @@ -177,18 +177,25 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>>   			pwrdm->state_counter[prev]++;
>>   		if (prev == PWRDM_POWER_RET)
>>   			_update_logic_membank_counters(pwrdm);
>> -		/*
>> -		 * If the power domain did not hit the desired state,
>> -		 * generate a trace event with both the desired and hit states
>> -		 */
>> -		next = pwrdm_read_next_pwrst(pwrdm);
>> -		if (next != prev) {
>> -			trace_state = (PWRDM_TRACE_STATES_FLAG |
>> +
>> +#ifdef CONFIG_PM_ADVANCED_DEBUG
> You do realize that you can add this to the block:
>
>
> 	if (trace_power_domain_target_enabled()) {
Nope I didn't, but now I do ;) thanks.

Marc.

>
> as it seems this code is only run to pass data to the tracepoint. The
> above if statement will keep this block in the 'out-of-line' path when
> tracing is not enabled via a static_key (jump-label).
>
> -- Steve
>
>> +		{
>> +			/*
>> +			 * If the power domain did not hit the desired state,
>> +			 * generate a trace event with both the desired and hit
>> +			 * states */
>> +			int next = pwrdm_read_next_pwrst(pwrdm);
>> +
>> +			if (next != prev) {
>> +				int trace_state = (PWRDM_TRACE_STATES_FLAG |
>>   				       ((next & OMAP_POWERSTATE_MASK) << 8) |
>>   				       ((prev & OMAP_POWERSTATE_MASK) << 0));
>> -			trace_power_domain_target(pwrdm->name, trace_state,
>> -						  smp_processor_id());
>> +				trace_power_domain_target(pwrdm->name,
>> +					trace_state, "PWRDM_STATE_PREV");
>> +			}
>>   		}
>> +#endif
>> +
>>   		break;
>>   	default:
>>   		return -EINVAL;
>> @@ -522,9 +529,10 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>>   		 pwrdm->name, pwrst);
>>   
>>   	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
>> +#ifdef CONFIG_PM_ADVANCED_DEBUG
>>   		/* Trace the pwrdm desired target state */
>> -		trace_power_domain_target(pwrdm->name, pwrst,
>> -					  smp_processor_id());
>> +		trace_power_domain_target(pwrdm->name, pwrst, "set_next_pwrst");
>> +#endif
>>   		/* Program the pwrdm desired target state */
>>   		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
>>   	}

