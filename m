From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP34xx
Date: Fri, 10 Feb 2012 16:39:28 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202101637190.26931@utopia.booyaka.com>
References: <20120208231551.GA9009@kroah.com> <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com> <20120209004731.GA11343@kroah.com> <4F3374F0.3080002@bitmer.com> <20120209133739.GB2590@sirena.org.uk> <20120209183624.GJ1426@atomide.com>
 <20120209193442.GA1767@rexfeany.com> <87hayzzjlv.fsf@ti.com> <alpine.DEB.2.00.1202091919200.12732@utopia.booyaka.com> <20120210183117.GB40045@h115-84.vpn.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35613 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387Ab2BJXj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 18:39:29 -0500
In-Reply-To: <20120210183117.GB40045@h115-84.vpn.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Porter <mporter@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Rex Feany <rfeany@laeos.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Hello Matt, Vaibhav,

On Fri, 10 Feb 2012, Matt Porter wrote:

> On Thu, Feb 09, 2012 at 07:19:47PM -0700, Paul Walmsley wrote:
> > 
> > Kevin and I just doublechecked OMAP37xx BeagleBoard xM here with Tony's 
> > testing branch; it works.
> 
> Regarding the issue that Vaibhav reported with:
> 
> "omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck"
> 
> I also see it on my xM Rev. B. I went back and doublechecked 3.2.5 and
> this does not occur there. Enabled EHCI+SMSC95xx support on top of
> omap2plus_defconfig and that works fine for nfsroot in 3.2.5.

I was planning to send this for v3.4.  But maybe we should propose it for 
v3.3-rc1?  At this point I am unaware of any regressions directly related 
to the usbtll missing clockdomain, but perhaps someone knows of one?


- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 26 Jan 2012 12:19:04 -0700
Subject: [PATCH] ARM: OMAP3: clock data: fill in some missing clockdomains

Several clocks are missing clockdomains.  This can cause problems with
the hwmod and power management code.  Fill these in.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Matt Porter <mporter@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d75e5f6..5e167d6 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1392,6 +1392,7 @@ static struct clk cpefuse_fck = {
 	.name		= "cpefuse_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &sys_ck,
+	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_CPEFUSE_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1401,6 +1402,7 @@ static struct clk ts_fck = {
 	.name		= "ts_fck",
 	.ops		= &clkops_omap2_dflt,
 	.parent		= &omap_32k_fck,
+	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_TS_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1410,6 +1412,7 @@ static struct clk usbtll_fck = {
 	.name		= "usbtll_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll5_m2_ck,
+	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -1615,6 +1618,7 @@ static struct clk fshostusb_fck = {
 	.name		= "fshostusb_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_48m_fck,
+	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -2041,6 +2045,7 @@ static struct clk omapctrl_ick = {
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
 	.flags		= ENABLE_ON_INIT,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &followparent_recalc,
 };
 
@@ -2092,6 +2097,7 @@ static struct clk usb_l4_ick = {
 	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK,
 	.clksel		= usb_l4_clksel,
+	.clkdm_name	= "core_l4_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 
-- 
1.7.9

