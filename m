From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Tue, 19 Nov 2019 13:20:14 -0500
Message-ID: <9e15c170-c9fa-778c-d998-bd1111a6390d@ti.com>
References: <20191118165236.22136-1-afd@ti.com>
 <20191118215759.GD35479@atomide.com>
 <b86e1d66-1566-521c-a445-4f0ae2fd95d6@ti.com>
 <20191118223128.GE35479@atomide.com>
 <29db708e-119e-8a89-7d43-e38e2a10dc07@ti.com>
 <20191119162157.GJ35479@atomide.com>
 <6e009ae3-6aa2-409b-749f-4947303940d8@ti.com>
 <20191119164227.GL35479@atomide.com> <20191119180546.GM35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119180546.GM35479@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/19/19 1:05 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [191119 16:43]:
>> What I'd like to have though is to make arm_smccc_smc()
>> work for optee and non-optee case for mach-omap2 as it
>> already has the features necessary to do the runtime
>> patching of the code for the quirks.
> 
> In any case sounds like we only need the r12 quirk when
> optee is _not_ enabled.
> 
> So a modified version of your earlier smccc-call.S patch
> modified to only enable the r12 quirk when no optee is
> loaded just might be all we need :)
> 


Doesn't change the reason the earlier patch was NAKd, we would still be
modifying the core SMCCC call to be non-compliant.

And doing it only when OP-TEE is not installed doesn't gain us anything,
we already have our own SMC calls for when OP-TEE is not available, this
patch is specifically so the OMAP2+ boot still works even when OP-TEE is
installed.

If you can get Mark to take my old patch then we can think about moving
more legacy SMC callers to the SMCCC, otherwise this patch is what we
need to get OP-TEE enabled OMAP2+ platforms to boot and we will just
stick to the custom SMC functions we already have for everything else.

Andrew


> Regards,
> 
> Tony
> 
