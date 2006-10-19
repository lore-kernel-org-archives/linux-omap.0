From: Tony Lindgren <tony@atomide.com>
Subject: Re: Disable DSPGW fails
Date: Thu, 19 Oct 2006 16:50:30 +0300
Message-ID: <20061019135028.GH9983@atomide.com>
References: <4523752A.8020601@gmail.com>
	<200610041211.53114.openembedded@hrw.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610041211.53114.openembedded@hrw.one.pl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Marcin Juszkiewicz <openembedded@hrw.one.pl> [061004 13:12]:
> Dnia =C5=9Broda, 4 pa=C5=BAdziernika 2006 10:47, Dirk Behme napisa=C5=82=
:
>=20
> > while debugging the OSK issue, I tried to disable DSPGW
> > completely (CONFIG_OMAP_DSP is not set). On most recent git
> > this fails with
> >
> > arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_free':
> > mcbsp.c:(.text+0x44b8): undefined reference to
> > `omap_dsp_release_mem'
> > arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_request':
> > mcbsp.c:(.text+0x45cc): undefined reference to
> > `omap_dsp_request_mem'
> >
> > Anybody with an idea how to fix this?
>=20
> Attached patch fix it. Feel free to push it into correct maintainer to =
get=20
> it included in GIT tree.
>=20
> --=20
> JID: hrw-jabber.org
> OpenEmbedded developer
>=20
>              Today is the first day of the rest of your life.

>=20
> while debugging the OSK issue, I tried to disable DSPGW=20
> completely (CONFIG_OMAP_DSP is not set).=20
>=20
> On most recent git this fails with
>=20
> arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_free':
> mcbsp.c:(.text+0x44b8): undefined reference to=20
> `omap_dsp_release_mem'
> arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_request':
> mcbsp.c:(.text+0x45cc): undefined reference to=20
> `omap_dsp_request_mem'
>=20
> This patch fixes it.
>=20
> Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>
>=20
>=20
> Index: git/arch/arm/plat-omap/mcbsp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- git.orig/arch/arm/plat-omap/mcbsp.c 2006-09-27 12:17:21.000000000 +=
0200
> +++ git/arch/arm/plat-omap/mcbsp.c      2006-09-27 12:17:01.000000000 +=
0200
> @@ -197,7 +197,9 @@
>  static void omap_mcbsp_dsp_request(void)
>  {
>         if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
> +#ifdef CONFIG_OMAP_DSP
>                 omap_dsp_request_mem();
> +#endif
>                 clk_enable(mcbsp_dsp_ck);
>                 clk_enable(mcbsp_api_ck);

>=20
> @@ -216,7 +218,9 @@
>  static void omap_mcbsp_dsp_free(void)
>  {
>         if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
> +#ifdef CONFIG_OMAP_DSP
>                 omap_dsp_release_mem();
> +#endif
>                 clk_disable(mcbsp_dspxor_ck);
>                 clk_disable(mcbsp_dsp_ck);
>                 clk_disable(mcbsp_api_ck);

This patch disables using McBSP without CONFIG_OMAP_DSP. I've posted
another patch that should keep the old functionality, can you please try
that out?

Regards,

Tony
