From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Tue, 19 Nov 2019 11:30:25 -0500
Message-ID: <6e009ae3-6aa2-409b-749f-4947303940d8@ti.com>
References: <20191118165236.22136-1-afd@ti.com>
 <20191118215759.GD35479@atomide.com>
 <b86e1d66-1566-521c-a445-4f0ae2fd95d6@ti.com>
 <20191118223128.GE35479@atomide.com>
 <29db708e-119e-8a89-7d43-e38e2a10dc07@ti.com>
 <20191119162157.GJ35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119162157.GJ35479@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/19/19 11:21 AM, Tony Lindgren wrote:
> * Andrew F. Davis <afd@ti.com> [191119 01:14]:
>> On 11/18/19 5:31 PM, Tony Lindgren wrote:
>>> * Andrew F. Davis <afd@ti.com> [191118 22:14]:
>>>> On 11/18/19 4:57 PM, Tony Lindgren wrote:
>>>>> Hi,
>>>>>
>>>>> * Andrew F. Davis <afd@ti.com> [191118 08:53]:
>>>>>> +#define OMAP_SIP_SMC_STD_CALL_VAL(func_num) \
>>>>>> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, ARM_SMCCC_SMC_32, \
>>>>>> +	ARM_SMCCC_OWNER_SIP, (func_num))
>>>>>> +
>>>>>> +void omap_smc1(u32 fn, u32 arg)
>>>>>> +{
>>>>>> +	struct device_node *optee;
>>>>>> +	struct arm_smccc_res res;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * If this platform has OP-TEE installed we use ARM SMC calls
>>>>>> +	 * otherwise fall back to the OMAP ROM style calls.
>>>>>> +	 */
>>>>>> +	optee = of_find_node_by_path("/firmware/optee");
>>>>>> +	if (optee) {
>>>>>> +		arm_smccc_smc(OMAP_SIP_SMC_STD_CALL_VAL(fn), arg,
>>>>>> +			      0, 0, 0, 0, 0, 0, &res);
>>>>>> +		WARN(res.a0, "Secure function call 0x%08x failed\n", fn);
>>>>>> +	} else {
>>>>>> +		_omap_smc1(fn, arg);
>>>>>> +	}
>>>>>> +}
>>>>>
>>>>> I think we're better off just making arm_smccc_smc() work properly.
>>>>> See cat arch/arm*/kernel/smccc-call.S.
>>>>>
>>>>
>>>>
>>>> arm_smccc_smc() does work properly already, I'm using it here.
>>>
>>> OK. I guess I don't follow then why we can't use arm_smccc_smc()
>>> for old code.
>>>
>>
>>
>> Our ROM code needs r12 to have the function code in it, where as the ARM
>> SMC calling convention standard requires that (plus some other
>> information) stored in r0. Our ROM doesn't know anything about the that
>> standard that came out years after we shipped these devices. And as such
>> is not complaint.
> 
> Right.
> 
>> A generic smc() call would be nice, but arm_smccc_smc() is specifically
>> for SMCCC.
> 
> To me it seeems that HAVE_ARM_SMCCC is a generic feature though.
> It's not limited to OPTEE. We have select HAVE_ARM_SMCCC if CPU_V7
> in arch/arm/Kconfig, and OPTEE depends on HAVE_ARM_SMCCC.
> 


It is not just for OP-TEE but for communicating with any compliant
system monitor/trustzone. Our ROM monitor is not compliant.


> From that point of view it seems that we could have HAVE_ARM_SMCCC
> enabled also for v6 and use it for all mach-omap2 with a wrapper.
> 
> So I'd like to have our smc callers eventually just call generic
> generic arm_smccc_smc(OMAP_SIP_SMC_STD_CALL_VAL(fn)...) rather
> than the custom calls. And we want to update to using the generic
> functions one case at a time as the features get tested :)
> 


It wont work, as said above, arm_smccc_smc() is not compatible with our
ROM, no wrapper around that function will make it work with our ROM, it
is not able to load our function number into r12 where the ROM expects
it. The function number for arm_smccc_smc() goes into r0, r12 is not
even exposed through arm_smccc_smc().


> In any case, you should do the necessary checks for HAVE_ARM_SMCCC
> only once during init. I'm not sure how much checking for
> "/firmware/optee" helps here, sounds like we have a broken system
> if the firmware is not there while the arm_smccc_smc() should
> still work just fine :)


arm_smccc_smc() only works on mach-omap2 platforms when OP-TEE is
available. On older system or systems where OP-TEE has not been
installed we need to fall back to our custom smc() calls.

Andrew


> 
> Regards,
> 
> Tony
> 
