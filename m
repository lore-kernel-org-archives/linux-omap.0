From: Tony Lindgren <tony@atomide.com>
Subject: Re: Re: Build failure: bisected: v3.1-rc1 with config ARCH_OMAP &&
 !ARCH_OMAP4 fails with linker error
Date: Tue, 9 Aug 2011 06:39:54 -0700
Message-ID: <20110809133954.GT1866@atomide.com>
References: <1312819724.14483.29.camel@morsingpad>
 <alpine.DEB.2.00.1108081435340.4764@utopia.booyaka.com>
 <20110809131453.GR1866@atomide.com>
 <1789641.q69g0yHCiG@barack>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1789641.q69g0yHCiG@barack>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Daniel Morsing <daniel.morsing@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com> [110809 06:15]:
> Hi Tony, Paul,
>=20
> On Tuesday 09 August 2011 15:14:53 Tony Lindgren wrote:
> > * Paul Walmsley <paul@pwsan.com> [110808 13:31]:
> > > Hi
> > >=20
> > > On Mon, 8 Aug 2011, Daniel Morsing wrote:
> > > > Building the v3.1-rc1 kernel with ARCH_OMAP && !ARCH_OMAP4 supp=
ort
> > > > fails on linking with the following error
> > > >=20
> > > > ...
> > > >=20
> > > >   LD      .tmp_vmlinux1
> > > >=20
> > > > arch/arm/mach-omap2/built-in.o:(.data+0xf7d8): undefined refere=
nce
> > > > to `omap4430_phy_init'
> > > > arch/arm/mach-omap2/built-in.o:(.data+0xf7dc): undefined refere=
nce
> > > > to `omap4430_phy_exit'
> > > > arch/arm/mach-omap2/built-in.o:(.data+0xf7e0): undefined refere=
nce
> > > > to `omap4430_phy_power'
> > > > arch/arm/mach-omap2/built-in.o:(.data+0xf7e4): undefined refere=
nce
> > > > to `omap4430_phy_set_clk'
> > > > arch/arm/mach-omap2/built-in.o:(.data+0xf7e8): undefined refere=
nce
> > > > to `omap4430_phy_suspend'
> > > >=20
> > > > I've bisected the first bad commit to "OMAP4: Move common twl60=
30
> > > > configuration to twl-common" (commit-id
> > > > b22f954bae35be115a10c6426dc070f7d652b32e). The problem seems to=
 be
> > > > unconditionally taking a function pointer to an omap4430 specif=
ic
> > > > function in arch/arm/mach-omap2/twl-common.c. The definition fo=
r
> > > > omap4430_phy_init and friends is in
> > > > arch/arm/mach-omap2/omap_phy_internal.c, which is only compiled=
 when
> > > > building with support for one of the omap4430 boards.
> > >=20
> > > Thanks for the bisect; this should be fixed by
> > >=20
> > > https://patchwork.kernel.org/patch/963462/
> >=20
> > Hmm, there are also these when CONFIG_ARCH_OMAP4 is not selected:
> >=20
> > arch/arm/mach-omap2/built-in.o: In function `_enable_module':
> > arch/arm/mach-omap2/omap_hwmod.c:701: undefined reference to
> > `omap4_cminst_module_enable' arch/arm/mach-omap2/built-in.o: In fun=
ction
> > `_disable_module':
> > arch/arm/mach-omap2/omap_hwmod.c:726: undefined reference to
> > `omap4_cminst_module_disable' arch/arm/mach-omap2/built-in.o: In fu=
nction
> > `_wait_target_disable': arch/arm/mach-omap2/omap_hwmod.c:1179: unde=
fined
> > reference to `omap4_cminst_wait_module_idle' distcc[27594] ERROR: c=
ompile
> > (null) on localhost failed
> > make: *** [.tmp_vmlinux1] Error 1
> >=20
> > Care to take a look?
>=20
> I just sent a patch fixing this:
> http://marc.info/?l=3Dlinux-omap&m=3D131289342114258&w=3D2

But that still won't fix the omap4_cminst_* errors, only the omap4430_p=
hy_*
errors AFAIK.

Tony=20
