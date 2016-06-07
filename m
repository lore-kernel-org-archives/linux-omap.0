From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: Keystone: Introduce Kconfig option to compile in
 typical Keystone features
Date: Tue, 07 Jun 2016 10:09:46 +0200
Message-ID: <10295246.2MDnqWQbb8@wuerfel>
References: <1464816714-3900-1-git-send-email-nm@ti.com>
 <574F6674.3010100@ti.com> <20160607042853.GA22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160607042853.GA22406@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, Bill Mills <wmills@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday, June 6, 2016 9:28:54 PM CEST Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160601 15:51]:
> > On 06/01/2016 05:31 PM, Arnd Bergmann wrote:
> > > On Wednesday, June 1, 2016 4:31:54 PM CEST Nishanth Menon wrote:
> > >>
> > >> Hence the "KEYSTONE_TYPICAL" option is designed similar to commit 8d9166b519fd
> > >> ("omap2/3/4: Add Kconfig option to compile in typical omap features")
> > >> that can be enabled for most boards keystone platforms
> > >> without needing to rediscover these in defconfig all over again -
> > >> examples include multi_v7_defconfig base and optimizations done on top
> > >> of them for keystone platform.
> > > 
> > > I'd rather remove the option for OMAP as well, it doesn't really fit in with
> > > how we do things for other platforms, and selecting a lot of other Kconfig
> > > symbols tends to cause circular dependencies.
> > 
> > Hmm, fair enough -> adding Tony as well if he sees an problem with
> > dropping ARCH_OMAP2PLUS_TYPICAL.
> 
> Yes there's a problem. Removing that is going to make all the custom
> .config files unbootable almost certainly. Just search around on
> issues related to not having REGULATOR_FIXED_VOLTAGE selected.
> 
> I agree we should not force select things though. And the I2C selection
> at least is wrong, we can have PMICs that are not on I2C bus.
> 
> Anybody got better ideas what we should do to make the configuration
> options more intuitive?

Let's have a look at what we actually select:

config ARCH_OMAP2PLUS_TYPICAL
        bool "Typical OMAP configuration"
        default y
        select AEABI
        select HIGHMEM
        select I2C
        select I2C_OMAP
        select MENELAUS if ARCH_OMAP2
        select NEON if CPU_V7
        select PM
        select REGULATOR
        select REGULATOR_FIXED_VOLTAGE
        select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
        select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
        select VFP
        help
          Compile a kernel suitable for booting most boards

A lot of these options are typical for all ARMv7 machines: AEABI, I2C, NEON,
PM, REGULATOR and VFP are things that we probably want to default to enabled
whenever we build a MULTI_V7 kernel, some also for V5 or V6, we just
need to come up with a good way to do that while (probably for most of
them) still allowing them to be disabled with CONFIG_EXPERT. I would
feel more comfortable with having an ARCH_MULTIPLATFORM_TYPICAL
Kconfig symbol than with the ARCH_OMAP2PLUS_TYPICAL one that ends up
turning things on unconditionally whenever you add ARCH_OMAP2PLUS
to some other configuration.

For I2C_OMAP, MENELAUS and TWL4030, we could just add a
'default ARCH_OMAP3 || ARCH_OMAP4' or whatever is appropriate for
each of them. I assume we want to handle TWL6040 the same way, though
we currently don't do that. MENELAUS seems to be only needed for
omap2420-n8x0.

REGULATOR_FIXED_VOLTAGE is needed by a lot of platforms that usually
don't select it, so it might be good to add a 'default y' to its Kconfig
symbol, or we could add 'select REGULATOR_FIXED_VOLTAGE if REGULATOR'
to all platforms that need it. The driver is about 1.5KB in size, compared
to about 50KB for the regulator core.

HIGHMEM is a bit odd here, because there are a couple of boards that
really really want it to access all of their memory, while most other
boards (anything with <=768MB RAM) are better off not enabling it,
so I can't see a good strategy for when to enable it or not across
multiplatform builds. If we wanted to apply crude heuristics, we could
make it default-enabled for SMP configurations, and default-disabled
for UP, or we could default-enable it for ARMv7VE (Cortex-A7/A15/A17,
Krait-400, PJ4B-MP) and default-disable for ARMv7 (Cortex-A5/A8/A9,
Scorpion, Krait, PJ4, PJ4B) and older. This would get us the right
setting in most cases, but it would also be rather confusing as it gets
flipped based on options that it doesn't really have anything to
do with in the strict sense.

	Arnd
