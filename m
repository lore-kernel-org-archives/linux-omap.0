From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of
 BTB) for secondary cores
Date: Mon, 25 Jun 2018 01:03:09 -0700
Message-ID: <20180625080309.GH112168@atomide.com>
References: <20180612213611.2484-1-nm@ti.com>
 <20180613101153.GD6920@n2100.armlinux.org.uk>
 <20180613132910.wr7ngq4nvxlgaoqi@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180613132910.wr7ngq4nvxlgaoqi@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [180613 13:31]:
> On 10:11-20180613, Russell King - ARM Linux wrote:
> > On Tue, Jun 12, 2018 at 04:36:11PM -0500, Nishanth Menon wrote:
> > > Call secure services to enable ACTLR[0] (Enable invalidates of BTB with
> > > ICIALLU) when branch hardening is enabled for kernel.
> > 
> > As mentioned elsewhere, I don't think this is a good idea - if the secure
> > world is not implementing the Spectre workarounds, then the _system_ is
> > exploitable.
> > 
> > If the secure world is implementing the spectre workarounds, it will
> > already have enabled the IBE bit (which is r/w from secure, read only
> > from non-secure.)
> > 
> > So, basically, lack of the IBE bit being set is basically telling the
> > kernel that it's running on a vulnerable platform _even if the kernel
> > were to set it through some means_.
> 
> On GP devices OMAP5/DRA7, there is no possibility to update secure side
> since "secure world" is ROM and there are no override mechanisms possible.
> on HS devices, I agree, appropriate PPA will do the workarounds as well.
> 
> However, this patch is to enable the IBE enable on GP device for _a_
> core can only be done via SMC services that ROM provides for
> specifically the reasons you have already stated. u-boot will only
> enable the IBE for the boot core, by the time the secondary cores start
> up, u-boot is long gone.. so someone has to invoke the SMC call to
> enable the IBE bit for the secondary core.
> 
> This is what the patch does.
> 
> If the above explanation makes sense, I will add that to the commit log
> as well.

Probably good idea to also add a comment to the code that this
is for the secondary core.

Regards,

Tony
