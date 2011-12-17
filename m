From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] OMAP4: mcbsp: Clock reparenting support
Date: Fri, 16 Dec 2011 17:37:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112161730080.12660@utopia.booyaka.com>
References: <1323941859-7946-1-git-send-email-peter.ujfalusi@ti.com> <1323941859-7946-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-980974019-1324081992=:12660"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38142 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1LQAhG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 19:37:06 -0500
In-Reply-To: <1323941859-7946-3-git-send-email-peter.ujfalusi@ti.com>
Content-ID: <alpine.DEB.2.00.1112161733210.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-980974019-1324081992=:12660
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1112161733211.12660@utopia.booyaka.com>

Hi P=E9ter

On Thu, 15 Dec 2011, Peter Ujfalusi wrote:

> With OMAP4 the clock names are different compared to OMAP2/3. The=20
> internal fclk name depends on the McBSP instance number. In case of=20
> MCBSP_TYPE4 (OMAP4) we should use different clock selection method=20
> compared to OMAP2/3.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c |   29 ++++++++++++++++++++++++++---
>  1 files changed, 26 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> index 9129003..829f4c7 100644
> --- a/arch/arm/mach-omap2/mcbsp.c
> +++ b/arch/arm/mach-omap2/mcbsp.c
> @@ -111,6 +111,23 @@ static int omap2_mcbsp_set_clk_src(struct device *de=
v, struct clk *clk,
>  =09return omap2_mcbsp_reparent_clk(dev, clk, fck_src_name);
>  }
> =20
> +/* McBSP CLKS source switching for OMAP4 */
> +static int omap4_mcbsp_set_clk_src(struct device *dev, struct clk *clk,
> +=09=09=09=09   const char *src)
> +{
> +=09struct omap_mcbsp *mcbsp =3D dev_get_drvdata(dev);
> +=09char fck_src_name[30];
> +
> +=09if (!strcmp(src, "clks_ext"))
> +=09=09strcpy(fck_src_name, "pad_clks_ck");
> +=09else if (!strcmp(src, "clks_fclk"))
> +=09=09sprintf(fck_src_name, "mcbsp%d_sync_mux_ck", mcbsp->id);
> +=09else
> +=09=09return -EINVAL;
> +
> +=09return omap2_mcbsp_reparent_clk(dev, clk, fck_src_name);
> +}

What do you think about using clkdev alias lines and hwmod optional clks=20
for this instead?  With these mechanisms, you can give clocks a consistent=
=20
"role name" for a given device, even if the underlying clock changes on=20
different platforms.

So in the mach-omap2/clock*_data.c files, you'd do something like

=09CLK("omap-mcbsp.1",=09"pad_fck",=09&mcbsp_clks,  CK_3XXX),

for OMAP3, and=20

=09CLK("omap-mcbsp.1",=09"pad_fck",=09&pad_clks_clk,  CK_44XX),

for OMAP4.

Then in the hwmod data files, you'd add them as optional clocks -=20
something like:

static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] =3D {
=09{ .role =3D "pad_fck", .clk =3D "mcbsp_clks" },
};

for OMAP3, and

static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] =3D {
=09{ .role =3D "pad_fck", .clk =3D "pad_clks_clk" },
};

for OMAP4.

I think this might work for your needs?


- Paul
--155748971-980974019-1324081992=:12660--
