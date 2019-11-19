From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Tue, 19 Nov 2019 08:42:27 -0800
Message-ID: <20191119164227.GL35479@atomide.com>
References: <20191118165236.22136-1-afd@ti.com>
 <20191118215759.GD35479@atomide.com>
 <b86e1d66-1566-521c-a445-4f0ae2fd95d6@ti.com>
 <20191118223128.GE35479@atomide.com>
 <29db708e-119e-8a89-7d43-e38e2a10dc07@ti.com>
 <20191119162157.GJ35479@atomide.com>
 <6e009ae3-6aa2-409b-749f-4947303940d8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e009ae3-6aa2-409b-749f-4947303940d8@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [191119 16:31]:
> arm_smccc_smc() only works on mach-omap2 platforms when OP-TEE is
> available. On older system or systems where OP-TEE has not been
> installed we need to fall back to our custom smc() calls.

Hmm OK so optee probably just adds support for new functions
when loaded.

Do the old bootrom functions stop working if optee is loaded?

If arm_smccc_smc() working depends on optee firmware being
loaded and the old omap_smc1 won't work, then you should
configure the function on init or dynamically modify the
code like we do in smp_on_up case for example.

What I'd like to have though is to make arm_smccc_smc()
work for optee and non-optee case for mach-omap2 as it
already has the features necessary to do the runtime
patching of the code for the quirks.

Mark do you have any comments on this?

Regards,

Tony
