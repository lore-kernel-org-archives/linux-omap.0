From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Mon, 16 Dec 2019 17:34:06 -0500
Message-ID: <9adad579-98b4-f228-caf3-f4996dcaecda@ti.com>
References: <9e15c170-c9fa-778c-d998-bd1111a6390d@ti.com>
 <20191119183247.GN35479@atomide.com>
 <a351461a-f6a1-334b-6bdd-a56626914fb3@ti.com>
 <20191119190721.GO35479@atomide.com>
 <7fa11037-8d33-2274-c8cc-80e9630b38b0@ti.com>
 <20191119192029.GP35479@atomide.com>
 <0ad31b32-712e-5bef-5645-0336dfec99cc@ti.com>
 <20191119194425.GQ35479@atomide.com>
 <f2f53e5e-6c95-e32f-d67a-284bb88e73e0@ti.com>
 <1ff8ae4b-5de3-4fdf-7318-d33398dc7fc8@ti.com>
 <20191216210407.GR35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216210407.GR35479@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/16/19 4:04 PM, Tony Lindgren wrote:
> * Andrew F. Davis <afd@ti.com> [191216 20:57]:
>> Looks like the TI quirk idea is not moving forward, even the QCOM quirk
>> looks like it may get kicked out. arm_smccc_smc() will remain only for
>> SMCCC compliant calls, but it looks like a generic arm_smc() wouldn't be
>> too opposed upstream.
> 
> Yes so it seems.
> 
>> Either way this patch would still be valid as when OP-TEE is present
>> then arm_smccc_smc() will be the right call to make, how we handle the
>> legacy calls can be sorted out later if a generic SMC call is implemented.
> 
> Please see my comment regarding this patch earlier in this thread
> pasted below for convenience:
> 
> * Tony Lindgren <tony@atomide.com> [191119 16:22]:
>> In any case, you should do the necessary checks for HAVE_ARM_SMCCC
>> only once during init. I'm not sure how much checking for
>> "/firmware/optee" helps here, sounds like we have a broken system
>> if the firmware is not there while the arm_smccc_smc() should
>> still work just fine :)
> 
> So only check once during init. And during init, you should probably
> also check that arm_smccc_smc() actually infd optee if
> "/firmware/optee" is set, and only then set set the right function
> pointer or some flag.
> 

Okay, I'll check only once and make sure the node is "okay".

I'll do the check during the first call to an SMC caller, I wouldn't
want to pollute the OMAP generic init code for something that is only
called on HS platforms, plus these SMC calls are rare (only 3 calls
during boot of AM57x for instance) so performance is not critical, so I
don't want to do anything fancy like code patching :), I'll just use a flag.

Thanks,
Andrew


> Regards,
> 
> Tony
> 
