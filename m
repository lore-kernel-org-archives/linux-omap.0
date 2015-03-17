From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: remove dead kconfig option OMAP4_ERRATA_I688
Date: Tue, 17 Mar 2015 10:10:00 -0700
Message-ID: <20150317171000.GD31346@atomide.com>
References: <1424889867-8980-1-git-send-email-stefan.hengelein@fau.de>
 <20150316233005.GA2598@atomide.com>
 <550855B7.3020905@oracle.com>
 <550856FF.9080702@ti.com>
 <20150317163440.GC31346@atomide.com>
 <CAGo_u6oHk9MXPGQv1rCpvW_oegzEzFTu3sZ_4j_6HFEivnXZXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGo_u6oHk9MXPGQv1rCpvW_oegzEzFTu3sZ_4j_6HFEivnXZXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, lkml <linux-kernel@vger.kernel.org>, Stefan Hengelein <stefan.hengelein@fau.de>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [150317 09:57]:
> On Tue, Mar 17, 2015 at 11:34 AM, Tony Lindgren <tony@atomide.com> wrote:
> >> On 03/17/2015 11:26 AM, santosh shilimkar wrote:
> >> >
> >> >
> >> > On 3/16/2015 4:30 PM, Tony Lindgren wrote:
> >> >> * Stefan Hengelein <stefan.hengelein@fau.de> [150225 10:48]:
> >> >>> The Kconfig-Option OMAP4_ERRATA_I688 is never visible due to a
> >> >>> contradiction in it's dependencies.
> >> >>> The option requires ARCH_MULTIPLATFORM to be 'disabled'. However, an
> >> >>> enclosing menu requires either ARCH_MULTI_V6 or ARCH_MULTI_V7 to be
> >> >>> enabled. These options inherit a dependency from an enclosing menu,
> >> >>> that requires ARCH_MULTIPLATFORM to be 'enabled'.
> >> >>> This is a contradiction and made this option also unavailable for
> >> >>> non-multiplatform configurations.
> >> >>>
> >> >>> Since there are no selects on OMAP4_ERRATA_I688, which would ignore
> >> >>> dependencies, the code related to that option is dead and can be
> >> >>> removed.
> >> >>>
> >> >>> This (logical) defect has been found with the undertaker tool.
> >> >>> (https://undertaker.cs.fau.de)
> >> >>>
> >> >>> Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>
> >> >>>
> >> >>> ---
> >> >>> Tony Lindgren suggested to remove the code since nobody complained for
> >> >>> a few years and Santosh Shilimkar agreed.
> >> >>> https://lkml.org/lkml/2015/2/25/449
> >> >>> ---
> >> >>> As far as I see, this should remove all the code related to
> >> >>> OMAP4_ERRATA_I688, I hope I didn't remove too much.
> >> >>
> >> >> Seems to boot fine, so applying into omap-for-v4.1/fixes-not-urgent.
> >> >>
> >> > Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> >>
> >> We no longer need i688? I do understand the need to cleanup the macros
> >> for multi-arch etc.. but loosing a bug workaround for a real silicon
> >> bug is really an invitation for hard to debug issues IMHO.
> >
> > Well that code has not been selectable for a few years now. Naturally
> > we can add it back when it actually does something with multiarch.
> >
> 
> I suppose we are sure that downstream kernels that actually try stuff
> out never went ahead and enabled this.. we do have non multi-platform
> builds as well... I am just saying... having been around during the
> discovery of i688, I kinda know how much pain it takes to find the
> damn thing in the first place. a simple boot was not ever an easy
> enough test for it. I do suggest at least adding a print for omap4
> saying that i688 is disabled..

Yes that's a good point and adding a printk is a good idea. Care to
crank out a separate patch for that?

Regards,

Tony
