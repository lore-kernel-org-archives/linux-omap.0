From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in typical Keystone features
Date: Wed, 08 Jun 2016 18:04:19 +0200
Message-ID: <8052110.nPS5mbu3uO@wuerfel>
References: <1464816714-3900-1-git-send-email-nm@ti.com> <10295246.2MDnqWQbb8@wuerfel> <20160608094747.GG22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608094747.GG22406@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, Bill Mills <wmills@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday, June 8, 2016 2:47:48 AM CEST Tony Lindgren wrote:
> 
> * Arnd Bergmann <arnd@arndb.de> [160607 01:11]:
> > A lot of these options are typical for all ARMv7 machines: AEABI, I2C, NEON,
> > PM, REGULATOR and VFP are things that we probably want to default to enabled
> > whenever we build a MULTI_V7 kernel, some also for V5 or V6, we just
> > need to come up with a good way to do that while (probably for most of
> > them) still allowing them to be disabled with CONFIG_EXPERT. I would
> > feel more comfortable with having an ARCH_MULTIPLATFORM_TYPICAL
> > Kconfig symbol than with the ARCH_OMAP2PLUS_TYPICAL one that ends up
> > turning things on unconditionally whenever you add ARCH_OMAP2PLUS
> > to some other configuration.
> 
> We still need to be careful about not changing the Kconfig option
> name for something like this as it will cause the custom .config files
> to fail unless the default is y. But yeah I agree, it would be nice
> to have some multiarch sane default selects, then also do the platform
> specific selects as needed. Naturally this needs to be kept down to
> minimum ideally limited to silent options.
> 
> So we could have ARCH_MULTIPLATFORM_TYPICAL, then have the old
> ARCH_OMAP2PLUS_TYPICAL select that one. That should keep things
> behaving just fine if the old .config had ARCH_OMAP2PLUS_TYPICAL.

If we make ARCH_MULTIPLATFORM_TYPICAL 'default y', it will be always
enabled in this case, and I think we can drop ARCH_OMAP2PLUS_TYPICAL.

The downside would be any users that want the options we enable there
turned off and have them silently enabled when upgrading the kernel.

> > For I2C_OMAP, MENELAUS and TWL4030, we could just add a
> > 'default ARCH_OMAP3 || ARCH_OMAP4' or whatever is appropriate for
> > each of them. I assume we want to handle TWL6040 the same way, though
> > we currently don't do that. MENELAUS seems to be only needed for
> > omap2420-n8x0.
> 
> We could yeah. TWL4030 is omap2430 to omap3, I don't think we currently
> have any omap3 based ones not using twl4030.. But there certainly
> are tons of usable devices with the Motorola CPCAP PMIC instead.

So should we enable both then?

> Then REGULATOR_FIXED_VOLTAGE we can have platform select like Mark
> seems to prefer. 

Ok

> HIGHMEM too should be platform specific.

I still don't see a good way to handle that, we should certainly not
just 'select' it, because we often want to leave it disabled.

> The original reason for ARCH_OMAP2PLUS_TYPICAL was that if omap2plus
> is selected with that you actually get a bootable system.

I understand. It's just not very scalable to have every platform do
this, in particular if they want to select conflicting options (none
of the ones you select should conflict, but we'd get there eventually).

	Arnd
