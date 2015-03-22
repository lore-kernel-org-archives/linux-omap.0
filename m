From: Fabian Frederick <fabf@skynet.be>
Subject: Re: [PATCH 32/35 linux-next] clk: constify of_device_id array
Date: Sun, 22 Mar 2015 11:34:09 +0100 (CET)
Message-ID: <386731024.185864.1427020449384.open-xchange@webmail.nmp.proximus.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be> <1426535949-26107-1-git-send-email-fabf@skynet.be> <20150318141509.7930.28419@quantum>
Reply-To: Fabian Frederick <fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailsec101.isp.belgacom.be ([195.238.20.97]:47135 "EHLO
	mailsec101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751263AbbCVKeP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Mar 2015 06:34:15 -0400
In-Reply-To: <20150318141509.7930.28419@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, Michael Turquette <mturquette@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>



> On 18 March 2015 at 15:15 Michael Turquette <mturquette@linaro.org> w=
rote:
>
>
> Quoting Fabian Frederick (2015-03-16 12:59:06)
> > of_device_id is always used as const.
> > (See driver.of_match_table and open firmware functions)
> >
> > Signed-off-by: Fabian Frederick <fabf@skynet.be>
>
> Acked-by: Michael Turquette <mturquette@linaro.org>

Thanks :)

btw, something I forgot to mention in changelog is the __initdata -> __=
initconst
for ti_clkdm_match_table[]

I can send it again with a new changelog if necessary ...

Regards,
=46abian

>
> > ---
> >=C2=A0 drivers/clk/clk-palmas.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-
> >=C2=A0 drivers/clk/st/clkgen-fsyn.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 2 +-
> >=C2=A0 drivers/clk/st/clkgen-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 8 ++++----
> >=C2=A0 drivers/clk/st/clkgen-pll.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 4 ++--
> >=C2=A0 drivers/clk/ti/clk-dra7-atl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 2 +-
> >=C2=A0 drivers/clk/ti/clockdomain.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 2 +-
> >=C2=A0 drivers/clk/versatile/clk-vexpress-osc.c | 2 +-
> >=C2=A0 7 files changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/clk/clk-palmas.c b/drivers/clk/clk-palmas.c
> > index 8d45992..45a535a 100644
> > --- a/drivers/clk/clk-palmas.c
> > +++ b/drivers/clk/clk-palmas.c
> > @@ -161,7 +161,7 @@ static struct palmas_clks_of_match_data
> > palmas_of_clk32kgaudio =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},
> >=C2=A0 };
> >=C2=A0
> > -static struct of_device_id palmas_clks_of_match[] =3D {
> > +static const struct of_device_id palmas_clks_of_match[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compa=
tible =3D "ti,palmas-clk32kg",
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =
=3D &palmas_of_clk32kg,
> > diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-f=
syn.c
> > index af94ed8..a917c4c 100644
> > --- a/drivers/clk/st/clkgen-fsyn.c
> > +++ b/drivers/clk/st/clkgen-fsyn.c
> > @@ -1057,7 +1057,7 @@ static struct clk * __init
> > st_clk_register_quadfs_fsynth(
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return clk;
> >=C2=A0 }
> >=C2=A0
> > -static struct of_device_id quadfs_of_match[] =3D {
> > +static const struct of_device_id quadfs_of_match[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compa=
tible =3D "st,stih416-quadfs216",
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =
=3D &st_fs216c65_416
> > diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mu=
x.c
> > index 9a15ec3..fdcff10 100644
> > --- a/drivers/clk/st/clkgen-mux.c
> > +++ b/drivers/clk/st/clkgen-mux.c
> > @@ -341,7 +341,7 @@ static struct clkgena_divmux_data st_divmux_c32=
odf3 =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.fb_start_bit_idx =3D 24,
> >=C2=A0 };
> >=C2=A0
> > -static struct of_device_id clkgena_divmux_of_match[] =3D {
> > +static const struct of_device_id clkgena_divmux_of_match[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compa=
tible =3D "st,clkgena-divmux-c65-hs",
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =
=3D &st_divmux_c65hs,
> > @@ -479,7 +479,7 @@ static struct clkgena_prediv_data prediv_c32_da=
ta =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.table =3D prediv_table16,
> >=C2=A0 };
> >=C2=A0
> > -static struct of_device_id clkgena_prediv_of_match[] =3D {
> > +static const struct of_device_id clkgena_prediv_of_match[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D "st,clkgena-pred=
iv-c65", .data =3D &prediv_c65_data },
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D "st,clkgena-pred=
iv-c32", .data =3D &prediv_c32_data },
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}
> > @@ -586,7 +586,7 @@ static struct clkgen_mux_data stih407_a9_mux_da=
ta =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.width =3D 2,
> >=C2=A0 };
> >=C2=A0
> > -static struct of_device_id mux_of_match[] =3D {
> > +static const struct of_device_id mux_of_match[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compa=
tible =3D "st,stih416-clkgenc-vcc-hd",
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =
=3D &clkgen_mux_c_vcc_hd_416,
> > @@ -693,7 +693,7 @@ static struct clkgen_vcc_data st_clkgenf_vcc_41=
6 =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.lock =3D &clkgenf_lock,
> >=C2=A0 };
> >=C2=A0
> > -static struct of_device_id vcc_of_match[] =3D {
> > +static const struct of_device_id vcc_of_match[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D "st,stih416-clkg=
enc", .data =3D &st_clkgenc_vcc_416 },
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D "st,stih416-clkg=
enf", .data =3D &st_clkgenf_vcc_416 },
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}
> > diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pl=
l.c
> > index 29769d7..d204ba8 100644
> > --- a/drivers/clk/st/clkgen-pll.c
> > +++ b/drivers/clk/st/clkgen-pll.c
> > @@ -593,7 +593,7 @@ static struct clk * __init clkgen_odf_register(=
const
> > char *parent_name,
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return clk;
> >=C2=A0 }
> >=C2=A0
> > -static struct of_device_id c32_pll_of_match[] =3D {
> > +static const struct of_device_id c32_pll_of_match[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compa=
tible =3D "st,plls-c32-a1x-0",
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =
=3D &st_pll3200c32_a1x_0,
> > @@ -708,7 +708,7 @@ err:
> >=C2=A0 }
> >=C2=A0 CLK_OF_DECLARE(clkgen_c32_pll, "st,clkgen-plls-c32", clkgen_c=
32_pll_setup);
> >=C2=A0
> > -static struct of_device_id c32_gpu_pll_of_match[] =3D {
> > +static const struct of_device_id c32_gpu_pll_of_match[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compa=
tible =3D "st,stih415-gpu-pll-c32",
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.data =
=3D &st_pll1200c32_gpu_415,
> > diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra=
7-atl.c
> > index 59bb4b3..d86bc46 100644
> > --- a/drivers/clk/ti/clk-dra7-atl.c
> > +++ b/drivers/clk/ti/clk-dra7-atl.c
> > @@ -294,7 +294,7 @@ static int of_dra7_atl_clk_remove(struct platfo=
rm_device
> > *pdev)
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> >=C2=A0 }
> >=C2=A0
> > -static struct of_device_id of_dra7_atl_clk_match_tbl[] =3D {
> > +static const struct of_device_id of_dra7_atl_clk_match_tbl[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D "ti,dra7-atl", }=
,
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{},
> >=C2=A0 };
> > diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdom=
ain.c
> > index b4c5fac..35fe108 100644
> > --- a/drivers/clk/ti/clockdomain.c
> > +++ b/drivers/clk/ti/clockdomain.c
> > @@ -52,7 +52,7 @@ static void __init of_ti_clockdomain_setup(struct
> > device_node *node)
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >=C2=A0 }
> >=C2=A0
> > -static struct of_device_id ti_clkdm_match_table[] __initdata =3D {
> > +static const struct of_device_id ti_clkdm_match_table[] __initcons=
t =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D "ti,clockdomain"=
 },
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ }
> >=C2=A0 };
> > diff --git a/drivers/clk/versatile/clk-vexpress-osc.c
> > b/drivers/clk/versatile/clk-vexpress-osc.c
> > index 765f1e0..89c0609 100644
> > --- a/drivers/clk/versatile/clk-vexpress-osc.c
> > +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> > @@ -110,7 +110,7 @@ static int vexpress_osc_probe(struct platform_d=
evice
> > *pdev)
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> >=C2=A0 }
> >=C2=A0
> > -static struct of_device_id vexpress_osc_of_match[] =3D {
> > +static const struct of_device_id vexpress_osc_of_match[] =3D {
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D "arm,vexpress-os=
c", },
> >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}
> >=C2=A0 };
> > --
> > 2.1.0
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
