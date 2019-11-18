From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Mon, 18 Nov 2019 17:13:44 -0500
Message-ID: <b86e1d66-1566-521c-a445-4f0ae2fd95d6@ti.com>
References: <20191118165236.22136-1-afd@ti.com>
 <20191118215759.GD35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191118215759.GD35479@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/18/19 4:57 PM, Tony Lindgren wrote:
> Hi,
> 
> * Andrew F. Davis <afd@ti.com> [191118 08:53]:
>> +#define OMAP_SIP_SMC_STD_CALL_VAL(func_num) \
>> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, ARM_SMCCC_SMC_32, \
>> +	ARM_SMCCC_OWNER_SIP, (func_num))
>> +
>> +void omap_smc1(u32 fn, u32 arg)
>> +{
>> +	struct device_node *optee;
>> +	struct arm_smccc_res res;
>> +
>> +	/*
>> +	 * If this platform has OP-TEE installed we use ARM SMC calls
>> +	 * otherwise fall back to the OMAP ROM style calls.
>> +	 */
>> +	optee = of_find_node_by_path("/firmware/optee");
>> +	if (optee) {
>> +		arm_smccc_smc(OMAP_SIP_SMC_STD_CALL_VAL(fn), arg,
>> +			      0, 0, 0, 0, 0, 0, &res);
>> +		WARN(res.a0, "Secure function call 0x%08x failed\n", fn);
>> +	} else {
>> +		_omap_smc1(fn, arg);
>> +	}
>> +}
> 
> I think we're better off just making arm_smccc_smc() work properly.
> See cat arch/arm*/kernel/smccc-call.S.
> 


arm_smccc_smc() does work properly already, I'm using it here.


> If quirk handling is needed, looks like ARM_SMCCC_QUIRK_STATE_OFFS
> can be used.
> 


Tried that [0], was NAKd. Making quirk-free SMCCC calls if OP-TEE is
detected seems to be the suggested path forward, QCOM got a pass,
doesn't look like we will get the same.

+Mark, in case you want to comment if this patch matches what you had in
mind.

[0] https://www.spinics.net/lists/arm-kernel/msg607263.html

Andrew


> AFAIK this should work both for optee and the current use cases.
> 
> Regards,
> 
> Tony
> 
