From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to
 add IVA OPP
Date: Fri, 16 Mar 2012 09:04:28 -0700
Message-ID: <CAOSpxdaTcMnp5tvNFO1AcvZJPXZ+X0GkVv6NBt59LmzuFGVdUA@mail.gmail.com>
References: <8762e6et1u.fsf@ti.com>
	<5448984682E7954C9BFF27F747A9C6CA56D6A8@dolphin.TIGRIS.local>
	<20120316142034.GA22234@senorita.am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46418 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031294Ab2CPQE3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 12:04:29 -0400
Received: by bkcik5 with SMTP id ik5so3017514bkc.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Mar 2012 09:04:28 -0700 (PDT)
In-Reply-To: <20120316142034.GA22234@senorita.am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Mar 16, 2012 at 7:20 AM, Nishanth Menon <nm@ti.com> wrote:
> From 5275d09c9f1a16c8f0814745e1c313c6cca049f6 Mon Sep 17 00:00:00 200=
1
> From: Nishanth Menon <nm@ti.com>
> Date: Fri, 16 Mar 2012 09:13:24 -0500
> Subject: [PATCH] OMAP2+: OPP: allow OPP enumeration to continue if de=
vice is not present
>
> On platforms such as OMAP3, certain variants may not have IVA, SGX
> or some specific component. We currently have a check to aid fixing
> wrong population of OPP entries for issues such as typos. This howeve=
r
> causes a conflict with valid requirement where the SoC variant does
> not actually have the module present.
>
> So, reduce the severity of the print to a debug statement and skip
> registering that specific OPP, but continue down the list.
>
> Reported-by: Steve Sakoman <steve@sakoman.com>
> Reported-by: Maximilian Schwerin <mvs@tigris.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> =A0arch/arm/mach-omap2/opp.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> index 9262a6b..de6d464 100644
> --- a/arch/arm/mach-omap2/opp.c
> +++ b/arch/arm/mach-omap2/opp.c
> @@ -64,10 +64,10 @@ int __init omap_init_opp_table(struct omap_opp_de=
f *opp_def,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh =3D omap_hwmod_lookup(opp_def->hwmo=
d_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!oh || !oh->od) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: no hwmod o=
r odev for %s, [%d] "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: no hwmod =
or odev for %s, [%d] "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"canno=
t add OPPs.\n", __func__,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0opp_de=
f->hwmod_name, i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev =3D &oh->od->pdev->dev;
>
> --
> 1.7.0.4

Acked-by: Steve Sakoman <steve@sakoman.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
