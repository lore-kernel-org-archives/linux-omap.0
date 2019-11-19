From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Tue, 19 Nov 2019 10:32:47 -0800
Message-ID: <20191119183247.GN35479@atomide.com>
References: <20191118165236.22136-1-afd@ti.com>
 <20191118215759.GD35479@atomide.com>
 <b86e1d66-1566-521c-a445-4f0ae2fd95d6@ti.com>
 <20191118223128.GE35479@atomide.com>
 <29db708e-119e-8a89-7d43-e38e2a10dc07@ti.com>
 <20191119162157.GJ35479@atomide.com>
 <6e009ae3-6aa2-409b-749f-4947303940d8@ti.com>
 <20191119164227.GL35479@atomide.com>
 <20191119180546.GM35479@atomide.com>
 <9e15c170-c9fa-778c-d998-bd1111a6390d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e15c170-c9fa-778c-d998-bd1111a6390d@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [191119 18:21]:
> On 11/19/19 1:05 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [191119 16:43]:
> >> What I'd like to have though is to make arm_smccc_smc()
> >> work for optee and non-optee case for mach-omap2 as it
> >> already has the features necessary to do the runtime
> >> patching of the code for the quirks.
> > 
> > In any case sounds like we only need the r12 quirk when
> > optee is _not_ enabled.
> > 
> > So a modified version of your earlier smccc-call.S patch
> > modified to only enable the r12 quirk when no optee is
> > loaded just might be all we need :)
> 
> Doesn't change the reason the earlier patch was NAKd, we would still be
> modifying the core SMCCC call to be non-compliant.

Well let's see what Mark says about r12 quirk version
that is only needed when optee is not active.

> And doing it only when OP-TEE is not installed doesn't gain us anything,
> we already have our own SMC calls for when OP-TEE is not available, this
> patch is specifically so the OMAP2+ boot still works even when OP-TEE is
> installed.

It would allow us to completely change over to using
arm_smccc_smc() and forget the custom calls.

> If you can get Mark to take my old patch then we can think about moving
> more legacy SMC callers to the SMCCC, otherwise this patch is what we
> need to get OP-TEE enabled OMAP2+ platforms to boot and we will just
> stick to the custom SMC functions we already have for everything else.

To me it sounds like your old patch won't work as is though,
we just want the code modified dynamically if optee is not
present to enable the r12 quirk.

Of course if both the optee version without the r12 quirk,
and a non-optee version with the r12 of the arm_smccc_smc()
are needed the same time on a booted system, then they should
be kept separate.

Regards,

Tony
