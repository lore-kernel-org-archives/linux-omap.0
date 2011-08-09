From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: Build failure: bisected: v3.1-rc1 with config ARCH_OMAP && !ARCH_OMAP4 fails with linker error
Date: Tue, 9 Aug 2011 16:21:45 +0300
Message-ID: <1789641.q69g0yHCiG@barack>
References: <1312819724.14483.29.camel@morsingpad> <alpine.DEB.2.00.1108081435340.4764@utopia.booyaka.com> <20110809131453.GR1866@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110809131453.GR1866@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Daniel Morsing <daniel.morsing@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony, Paul,

On Tuesday 09 August 2011 15:14:53 Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [110808 13:31]:
> > Hi
> >=20
> > On Mon, 8 Aug 2011, Daniel Morsing wrote:
> > > Building the v3.1-rc1 kernel with ARCH_OMAP && !ARCH_OMAP4 suppor=
t
> > > fails on linking with the following error
> > >=20
> > > ...
> > >=20
> > >   LD      .tmp_vmlinux1
> > >=20
> > > arch/arm/mach-omap2/built-in.o:(.data+0xf7d8): undefined referenc=
e
> > > to `omap4430_phy_init'
> > > arch/arm/mach-omap2/built-in.o:(.data+0xf7dc): undefined referenc=
e
> > > to `omap4430_phy_exit'
> > > arch/arm/mach-omap2/built-in.o:(.data+0xf7e0): undefined referenc=
e
> > > to `omap4430_phy_power'
> > > arch/arm/mach-omap2/built-in.o:(.data+0xf7e4): undefined referenc=
e
> > > to `omap4430_phy_set_clk'
> > > arch/arm/mach-omap2/built-in.o:(.data+0xf7e8): undefined referenc=
e
> > > to `omap4430_phy_suspend'
> > >=20
> > > I've bisected the first bad commit to "OMAP4: Move common twl6030
> > > configuration to twl-common" (commit-id
> > > b22f954bae35be115a10c6426dc070f7d652b32e). The problem seems to b=
e
> > > unconditionally taking a function pointer to an omap4430 specific
> > > function in arch/arm/mach-omap2/twl-common.c. The definition for
> > > omap4430_phy_init and friends is in
> > > arch/arm/mach-omap2/omap_phy_internal.c, which is only compiled w=
hen
> > > building with support for one of the omap4430 boards.
> >=20
> > Thanks for the bisect; this should be fixed by
> >=20
> > https://patchwork.kernel.org/patch/963462/
>=20
> Hmm, there are also these when CONFIG_ARCH_OMAP4 is not selected:
>=20
> arch/arm/mach-omap2/built-in.o: In function `_enable_module':
> arch/arm/mach-omap2/omap_hwmod.c:701: undefined reference to
> `omap4_cminst_module_enable' arch/arm/mach-omap2/built-in.o: In funct=
ion
> `_disable_module':
> arch/arm/mach-omap2/omap_hwmod.c:726: undefined reference to
> `omap4_cminst_module_disable' arch/arm/mach-omap2/built-in.o: In func=
tion
> `_wait_target_disable': arch/arm/mach-omap2/omap_hwmod.c:1179: undefi=
ned
> reference to `omap4_cminst_wait_module_idle' distcc[27594] ERROR: com=
pile
> (null) on localhost failed
> make: *** [.tmp_vmlinux1] Error 1
>=20
> Care to take a look?

I just sent a patch fixing this:
http://marc.info/?l=3Dlinux-omap&m=3D131289342114258&w=3D2

--=20
P=E9ter
