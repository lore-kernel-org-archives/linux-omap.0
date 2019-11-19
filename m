From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Tue, 19 Nov 2019 11:07:21 -0800
Message-ID: <20191119190721.GO35479@atomide.com>
References: <b86e1d66-1566-521c-a445-4f0ae2fd95d6@ti.com>
 <20191118223128.GE35479@atomide.com>
 <29db708e-119e-8a89-7d43-e38e2a10dc07@ti.com>
 <20191119162157.GJ35479@atomide.com>
 <6e009ae3-6aa2-409b-749f-4947303940d8@ti.com>
 <20191119164227.GL35479@atomide.com>
 <20191119180546.GM35479@atomide.com>
 <9e15c170-c9fa-778c-d998-bd1111a6390d@ti.com>
 <20191119183247.GN35479@atomide.com>
 <a351461a-f6a1-334b-6bdd-a56626914fb3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a351461a-f6a1-334b-6bdd-a56626914fb3@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [191119 18:51]:
> On 11/19/19 1:32 PM, Tony Lindgren wrote:
> > It would allow us to completely change over to using
> > arm_smccc_smc() and forget the custom calls.
> 
> We would need more than just the r12 quirk to replace all our custom SMC
> handlers, we would need quirks for omap_smc2 which puts process ID in r1
> and puts #0xff in r6, and omap_smc3 that uses smc #1. All of our legacy
> SMC calls also trash r4-r11, that is very non SMCCC complaint as only
> r4-r7 need be caller saved. I don't see arm_smccc_smc() working with
> legacy ROM no matter how much we hack at it :(

We would just have omap_smc2() call arm_smccc_smc() and in that
case. And omap_smc2() would still deal with saving and restoring
the registers.

Certainly the wrapper functions calling arm_smccc_smc() can deal
with r12 too if the r12-quirk version and the plain version are
never needed the same time on a booted SoC.

Are they ever needed the same time on a booted SoC or not?

> I can make OP-TEE also compatible with the r12 quirk, which is what I
> used to do. That way we didn't need to do any detection. The issue was
> that non-standard SMC calls should not go through the common SMCCC
> handler (unless you are QCOM for some reason..).

Sounds like for optee nothing must be done for r12 :)

Regards,

Tony
