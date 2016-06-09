From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
Date: Wed, 8 Jun 2016 23:50:35 -0700
Message-ID: <20160609065035.GJ22406@atomide.com>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <10295246.2MDnqWQbb8@wuerfel>
 <20160608094747.GG22406@atomide.com>
 <8052110.nPS5mbu3uO@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8052110.nPS5mbu3uO@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, Bill Mills <wmills@ti.com>
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [160608 09:06]:
> On Wednesday, June 8, 2016 2:47:48 AM CEST Tony Lindgren wrote:
> > 
> > So we could have ARCH_MULTIPLATFORM_TYPICAL, then have the old
> > ARCH_OMAP2PLUS_TYPICAL select that one. That should keep things
> > behaving just fine if the old .config had ARCH_OMAP2PLUS_TYPICAL.
> 
> If we make ARCH_MULTIPLATFORM_TYPICAL 'default y', it will be always
> enabled in this case, and I think we can drop ARCH_OMAP2PLUS_TYPICAL.

Having "default y" there seems safe enough for me.

> The downside would be any users that want the options we enable there
> turned off and have them silently enabled when upgrading the kernel.

I think the long term solution here might be to generate the .config
out of dts files..

> > > For I2C_OMAP, MENELAUS and TWL4030, we could just add a
> > > 'default ARCH_OMAP3 || ARCH_OMAP4' or whatever is appropriate for
> > > each of them. I assume we want to handle TWL6040 the same way, though
> > > we currently don't do that. MENELAUS seems to be only needed for
> > > omap2420-n8x0.
> > 
> > We could yeah. TWL4030 is omap2430 to omap3, I don't think we currently
> > have any omap3 based ones not using twl4030.. But there certainly
> > are tons of usable devices with the Motorola CPCAP PMIC instead.
> 
> So should we enable both then?

No CPCAP support currently in mainline kernel.. And with most of
initcall level issues out of the way, any future support should
not be added to the TYPICAL because of all the issues discussed.

> > HIGHMEM too should be platform specific.
> 
> I still don't see a good way to handle that, we should certainly not
> just 'select' it, because we often want to leave it disabled.

Right. Leaving it out produces a bootable kernel though that could
produce some warning if configured memory is > 768MB.

> > The original reason for ARCH_OMAP2PLUS_TYPICAL was that if omap2plus
> > is selected with that you actually get a bootable system.
> 
> I understand. It's just not very scalable to have every platform do
> this, in particular if they want to select conflicting options (none
> of the ones you select should conflict, but we'd get there eventually).

Yeah. Seems like generating the base .confing out of the dts file
is better in the long run.

Regards,

Tony
