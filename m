From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
Date: Wed, 8 Jun 2016 02:47:48 -0700
Message-ID: <20160608094747.GG22406@atomide.com>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <574F6674.3010100@ti.com>
 <20160607042853.GA22406@atomide.com>
 <10295246.2MDnqWQbb8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10295246.2MDnqWQbb8@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Bill Mills <wmills@ti.com>, linux-omap@vger.kernel.org, "broonie@kernel.org" <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Arnd Bergmann <arnd@arndb.de> [160607 01:11]:
> A lot of these options are typical for all ARMv7 machines: AEABI, I2C, NEON,
> PM, REGULATOR and VFP are things that we probably want to default to enabled
> whenever we build a MULTI_V7 kernel, some also for V5 or V6, we just
> need to come up with a good way to do that while (probably for most of
> them) still allowing them to be disabled with CONFIG_EXPERT. I would
> feel more comfortable with having an ARCH_MULTIPLATFORM_TYPICAL
> Kconfig symbol than with the ARCH_OMAP2PLUS_TYPICAL one that ends up
> turning things on unconditionally whenever you add ARCH_OMAP2PLUS
> to some other configuration.

We still need to be careful about not changing the Kconfig option
name for something like this as it will cause the custom .config files
to fail unless the default is y. But yeah I agree, it would be nice
to have some multiarch sane default selects, then also do the platform
specific selects as needed. Naturally this needs to be kept down to
minimum ideally limited to silent options.

So we could have ARCH_MULTIPLATFORM_TYPICAL, then have the old
ARCH_OMAP2PLUS_TYPICAL select that one. That should keep things
behaving just fine if the old .config had ARCH_OMAP2PLUS_TYPICAL.

> For I2C_OMAP, MENELAUS and TWL4030, we could just add a
> 'default ARCH_OMAP3 || ARCH_OMAP4' or whatever is appropriate for
> each of them. I assume we want to handle TWL6040 the same way, though
> we currently don't do that. MENELAUS seems to be only needed for
> omap2420-n8x0.

We could yeah. TWL4030 is omap2430 to omap3, I don't think we currently
have any omap3 based ones not using twl4030.. But there certainly
are tons of usable devices with the Motorola CPCAP PMIC instead.

Then REGULATOR_FIXED_VOLTAGE we can have platform select like Mark
seems to prefer. HIGHMEM too should be platform specific.

The original reason for ARCH_OMAP2PLUS_TYPICAL was that if omap2plus
is selected with that you actually get a bootable system.

Regards,

Tony
