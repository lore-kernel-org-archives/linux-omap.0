From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Tue, 17 Dec 2019 09:18:42 -0800
Message-ID: <20191217171842.GZ35479@atomide.com>
References: <20191119194425.GQ35479@atomide.com>
 <f2f53e5e-6c95-e32f-d67a-284bb88e73e0@ti.com>
 <1ff8ae4b-5de3-4fdf-7318-d33398dc7fc8@ti.com>
 <20191216210407.GR35479@atomide.com>
 <9adad579-98b4-f228-caf3-f4996dcaecda@ti.com>
 <20191216224105.GS35479@atomide.com>
 <35e4b682-0d2f-23b1-6df4-428c6bcb4d59@ti.com>
 <20191217150732.GW35479@atomide.com>
 <8d5d098f-26cb-c436-ec7b-bed0ed0a9ced@ti.com>
 <20191217171108.GY35479@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191217171108.GY35479@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191217 17:11]:
> * Andrew F. Davis <afd@ti.com> [191217 17:02]:
> > On 12/17/19 10:07 AM, Tony Lindgren wrote:
> > > * Andrew F. Davis <afd@ti.com> [191217 13:14]:
> > >> On 12/16/19 5:41 PM, Tony Lindgren wrote:
> > >>> Please just add omap_early_initcall() to omap-secure.c while at it
> > >>> to deal with this.
> > >>
> > >> omap_early_initcall()s are not called until after all the SMC calls have
> > >> already happened.
> > > 
> > > Oh OK. Then let's just add omap_secure_init() that's called from
> > > *_init_early() as late as possible. We will have more use for that
> > > init later on too.
> > > 
> > 
> > 
> > You mean add a call to this omap_secure_init() to every boards init
> > function?
> 
> Yes please. We also have some SoCs that need clocks enabled
> and disabled for omap_smc2() so we can then use that to
> intialize the clocks as needed.

And please add the call to omap_secure_init() the SoC specific
*_init_early() functions in:

$ git grep 'void __init ' arch/arm/mach-omap2/io.c | grep early
...

Regards,

Tony
