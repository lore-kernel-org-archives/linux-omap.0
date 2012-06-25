From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 16:14:50 +0300
Message-ID: <1340630090.3395.85.camel@deskari>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
			 <1340372890-10091-6-git-send-email-rnayak@ti.com>
		 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>
	 <1340611133.3395.3.camel@deskari> <4FE85005.4090303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-o3UsSCQjmI8+5MoOpAni"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:51998 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753496Ab2FYNOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 09:14:44 -0400
Received: by lbok6 with SMTP id k6so7459036lbo.4
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 06:14:41 -0700 (PDT)
In-Reply-To: <4FE85005.4090303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org


--=-o3UsSCQjmI8+5MoOpAni
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 17:18 +0530, Rajendra Nayak wrote:
> On Monday 25 June 2012 01:28 PM, Tomi Valkeinen wrote:
> > On Mon, 2012-06-25 at 12:29 +0530, Rajendra Nayak wrote:
> >> On Monday 25 June 2012 11:37 AM, Tomi Valkeinen wrote:
> >>> Hi,
> >>>
> >>> On Fri, 2012-06-22 at 19:18 +0530, Rajendra Nayak wrote:
> >>>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_p=
repare()
> >>>> and clk_unprepare() for the omapdss clocks.
> >>>
> >>> You used clk_prepare and clk_unprepare instead of clk_prepare_enable =
and
> >>> clk_disable_unprepare. I didn't check the dss driver yet, but my hunc=
h
> >>> is that the clocks are normally not enabled/disabled from atomic
> >>> context.
> >>>
> >>> What does the prepare/unprepare actually do? Is there any benefit in
> >>> delaying preparing, i.e. is there a difference between prepare right
> >>> after clk_get, or prepare right before clk_enable? (And similarly for
> >>> unprepare)
> >>
> >> clk_prepare/unprepare are useful for clocks which need the 'enable'
> >> logic to be implemented as a slow part (which can sleep) and a fast pa=
rt
> >> (which does not sleep). For all the dss clocks in question we don't ne=
ed
> >> a slow part and hence they do not have a .clk_prepare/unprepare
> >> platform hook.
> >>
> >> The framework however still does prepare usecounting (it has a prepare
> >> count and an enable count, and prepare count is expected to be non-zer=
o
> >> while the clock is being enabled) and uses a mutex around to guard it.
> >> So while the dss driver would do multiple clk_enable/disable while its
> >> active, it seems fair to just prepare/unprepare the clocks once just
> >> after clk_get() and before clk_put() in this particular case.
> >
> > But the driver should not presume anything special about the clocks. In
> > this case the dss driver would presume that the clocks it uses do not
> > have prepare and unprepare hooks.
> >
> > If the generally proper way to use prepare/unprepare is in combination
> > of enable/disable, then I think we should try to do that.
>=20
> makes sense. Lets see if any of the clk_enable/disable happen in  atomic
> context, if not it would be just a matter of replacing all with a
> clk_prepare_enable/disable_unprepare. Else we might have to find a safe
> place sometime before clk_enable to prepare the clk and after
> clk_disable to unprepare it.
>=20
> >
> > I'll check if any of the dss clocks are enabled or disabled in atomic
> > context.

venc and hdmi use clk_enable/disable in runtime PM callbacks (suspend &
resume). If I understand correctly, the callbacks are not called in
atomic context if pm_runtime_irq_safe() has not been used. And it is not
used in omapdss.

dsi uses clk_enable/disable in a different manner, but not in atomic
context.

So as far as I see, clocks are never handled in atomic context. Is
everything related to the base clk stuff already in mainline? Can I take
the clk_prepare/unprepare patch into my omapdss tree?


A question about clk_prepare/unprepare, not directly related: let's say
I have a driver for some HW block. The driver doesn't use clk functions,
but uses runtime PM. The driver also sets pm_runtime_irq_safe().

Now, the driver can call pm_runtime_get_sync() in an atomic context, and
this would lead to the underlying framework (hwmod, omap_device, I don't
know who =3D) enabling the func clock for that HW. But this would happen
in atomic context, so the underlying framework can't use clk_prepare.

How does the underlying framework handle that case? (sorry if that's a
stupid question =3D).

 Tomi


--=-o3UsSCQjmI8+5MoOpAni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6GRKAAoJEPo9qoy8lh71sZ0P/2moiLGnh0LFTNTCP+D6BYcw
5dXO0larrl+Mq/tRVFwCPdDhR+jHcazGCrSDF1IPREzbuEWyyYSiTS1Zy0oF2/FT
4i4GsuKiyBBwvY5SjfNkSUYl0TTQOZr1lWI+ry7i7X/Tc/u6p93VOuyR2fOCasJu
3ddKH75dexewyJfQBQ/dG0hDRBwfT6Q37GhzFhN0Gvz3C6CUjtrYpwJ6upjOamfN
uLSqotIurY9mbv9l7Rbx1HNQeE3/48VCy8H/p2KvGYSvMjNmpB8Z9qKH6mYuJOiC
xWRbJmlDo1Fi8zj73Brj/GsZI6kQg4fQsRjyUpatV52RpsnSUepd5F98uCF9CTWw
bdWQYn60i0QO5VLc3FD6cQwsS4Aw+l6eGjdx6lU/muD0ttlmdX6mJOczSzseamcG
k71KCzj2wlxhta3p4/kXDdF6t/xS4BTKnm1qhCoIc7WcM99HyFdo8DAFkGy4A4E9
6rPHx1I5O97rmnKseh5UjJ0R/Noj6LdrVYBQnc4WD7pwK3aTHnnqc9NQgG/9ZIdv
ruOeCKaDsiRk6GkmvN/AurROXscSIdr7W2mpqik6sOLzZ4U491qjpByMdQODuNER
ZyRl9QIgzfOTHdfSAi+T99/dykslJoelN2O/VRKkm3GFn9KCdlxPOnClxTA4Ubwd
/P3dH71k/06XA7YJm1FA
=aZjM
-----END PGP SIGNATURE-----

--=-o3UsSCQjmI8+5MoOpAni--

