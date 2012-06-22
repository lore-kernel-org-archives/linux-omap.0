From: Pankaj Jangra <jangra.pankaj9@gmail.com>
Subject: Re: [PATCH 01/11] ARM: omap: clk: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 23:12:17 +0530
Message-ID: <CADTbHxr27_DSrF4amviGicb2_5_=eTx19YecgeAOM5SGrnvscA@mail.gmail.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
	<1340372890-10091-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50198 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab2FVRmR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 13:42:17 -0400
Received: by pbbrp8 with SMTP id rp8so3839021pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 22 Jun 2012 10:42:17 -0700 (PDT)
In-Reply-To: <1340372890-10091-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> As part of Common Clk Framework (CCF) the clk_enable() operation
> was split into a clk_prepare() which could sleep, and a clk_enable()
> which should never sleep. Similarly the clk_disable() was
> split into clk_disable() and clk_unprepare(). This was
> needed to handle complex cases where in a clk gate/ungate
> would require a slow and a fast part to be implemented.
> None of the clocks below seem to be in the 'complex' clocks
> category and are just simple clocks which are enabled/disabled
> through simple register writes.
> Most of the instances also seem to be called in non-atomic
> context which means its safe to move all of those from
> using a clk_enable() to clk_prepare_enable() and clk_disable() to
> clk_disable_unprepare().
> For a few others where there is a possibility they get called from
> an interrupt or atomic context, there is an additonal clk_prepare()
> done immediately following a clk_get() and a clk_unprepare()
> immediately preceding the clk_put().
> This is in preparation of OMAP moving to CCF.
>
> Based on initial changes from Mike turquette.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-apollon.c =A0 =A0 | =A0 =A04 ++--
> =A0arch/arm/mach-omap2/board-h4.c =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++--=
-
> =A0arch/arm/mach-omap2/board-omap4panda.c =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/clock3xxx.c =A0 =A0 =A0 =A0 | =A0 =A08 ++++---=
-
> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++--
> =A0arch/arm/mach-omap2/gpmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +=
-
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0| =A0 =A03 +++
> =A0arch/arm/mach-omap2/omap_phy_internal.c | =A0 =A03 +++
> =A0arch/arm/mach-omap2/pm24xx.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 ++
> =A0arch/arm/mach-omap2/usb-fs.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++-=
-
> =A010 files changed, 23 insertions(+), 15 deletions(-)
>
> =A0}
>

> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/disp=
lay.c
> index 5fb47a1..e5f8e48 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -471,7 +471,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
>
> =A0 =A0 =A0 =A0for (i =3D oh->opt_clks_cnt, oc =3D oh->opt_clks; i > =
0; i--, oc++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (oc->_clk)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(oc->_clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_prepare_enable(oc->=
_clk);
>
> =A0 =A0 =A0 =A0dispc_disable_outputs();
>
> @@ -498,7 +498,7 @@ int omap_dss_reset(struct omap_hwmod *oh)
>
> =A0 =A0 =A0 =A0for (i =3D oh->opt_clks_cnt, oc =3D oh->opt_clks; i > =
0; i--, oc++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (oc->_clk)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(oc->_clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable_unprepare(o=
c->_clk);
>
Just a doubt. Isn't it the same clocks you are preparing in omap_hwmod.=
c ?

> =A0 =A0 =A0 =A0r =3D (c =3D=3D MAX_MODULE_SOFTRESET_WAIT) ? -ETIMEDOU=
T : 0;
>
d> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
b/arch/arm/mach-omap2/omap_hwmod.c
> index bf86f7e..2746bce 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -608,6 +608,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->name, oh->mai=
n_clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 clk_prepare(oh->_clk);
>
> =A0 =A0 =A0 =A0if (!oh->_clk->clkdm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("omap_hwmod: %s: missing cl=
ockdomain for %s.\n",
> @@ -644,6 +645,7 @@ static int _init_interface_clks(struct omap_hwmod=
 *oh)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 o=
h->name, os->clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_prepare(os->_clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0os->_clk =3D c;

You should do clk_prepare() after os->_clk =3D c statement. Otherwise
you are operating on a uninitialized structure pointer.
> =A0 =A0 =A0 =A0}
>
> @@ -671,6 +673,7 @@ static int _init_opt_clks(struct omap_hwmod *oh)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 o=
h->name, oc->clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_prepare(oc->_clk);

Same here. You are preparing the uninitialized clk structure.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oc->_clk =3D c;
> =A0 =A0 =A0 =A0}
>
d
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
