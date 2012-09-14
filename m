From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/21] OMAPDSS: DISPC changes for writeback pipeline
Date: Fri, 14 Sep 2012 13:57:18 +0300
Message-ID: <1347620238.2559.87.camel@deskari>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	  <1347611263.2559.44.camel@deskari> <1347612392.2559.54.camel@deskari>
	 <505305F2.4000602@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-YnUQqtJV5Aud74nn+dAk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:45618 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754739Ab2INK5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 06:57:24 -0400
Received: by lagy9 with SMTP id y9so2624462lag.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 03:57:21 -0700 (PDT)
In-Reply-To: <505305F2.4000602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-YnUQqtJV5Aud74nn+dAk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-14 at 15:54 +0530, Archit Taneja wrote:
> On Friday 14 September 2012 02:16 PM, Tomi Valkeinen wrote:
> > On Fri, 2012-09-14 at 11:27 +0300, Tomi Valkeinen wrote:
> >> On Thu, 2012-09-13 at 17:44 +0530, Archit Taneja wrote:
> >
> >>> This series prepares the low level DISPC driver(dispc.c) to configure=
 writeback
> >>> registers. The aim is to reuse most of the code as most of its regist=
ers are
> >>> like overlay or manager registers, and are configured in the same way=
 in most
> >>> cases. The first few patches rename dispc_ovl_* functions to dispc_pl=
ane_*
> >>
> >> I'm not sure if the renaming causes more confusion than clarity... It
> >> kinda creates a mishmash of ovl/plane names, and the term "plane"
> >> doesn't really sound like it's a base for both overlays and wb. Could =
we
> >> consider the wb as a special case, and keep the ovl name for most of t=
he
> >> things and have "wb" used for wb specific things?
> >
> > And while WB is a combination of overlays and ovl managers, do you thin=
k
> > it'd be difficult to consider WB as a special, extended overlay? So jus=
t
> > call it an overlay, and consider it as an overlay with special features=
,
> > at least inside dispc.c. We probably need to have it as a totally
> > different entity from user's point of view (i.e. the list of overlays
> > wouldn't return WB, etc).
>=20
> Yes, we could do that within dispc.c, we would still need some manager=
=20
> like functions which set GO or ENABLE. But apart from that it should be=
=20
> okay.

Yep, I was going through the WB registers, and to me it looks like 99%
of them are like overlay regs. Then there are a few bits like GO which
are special.

> I think for dispc.c in general, for future, it might be a good idea to=
=20
> represent each piece of HW(like scalar or color converter, or a timing=
=20

Scal_e_r! ;)

> FSM) as a little function/module, and construct=20
> overlay/writeback/manager out of those, it might be cleaner. However,=20
> this may be an overkill, and not needed much if there aren't any new=20
> blocks comprising of these little blocks.

I agree. In the minimum we should try to somehow group functions related
to certain block, perhaps with name prefixes etc. I think it'll also
help understanding the code.

We probably currently have functions that touch multiple different
blocks. Those funcs should be split to handle only one of the blocks.

 Tomi


--=-YnUQqtJV5Aud74nn+dAk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUw2OAAoJEPo9qoy8lh71SeYQAKM2jCDlj3xZdVKEdm6e/bre
c//Fn8g3+yHSrp3+b1NQsN/EgGFuG9Gx9pr8ZjM3Cr60VuJvaiOQpx3JMklPqkVK
mICyx2XsM1SyCo9Zm6ekLsPF0tOlK/5KmHl/02gSm2FvTdZr8wib6uyVLlnfeTUC
+Z878qI6TrRlocom/u0usGMNSNB0BfuK/dBvjwJv+d6ObR9hDflD9AomakLNO1ji
fWlTMo773GO8BOpPAvpJ4LddC+oWfCBkFlSe5QEfXQDwbaf6LjucO8g3am/oAuhn
KiEq+Q/iSkxj5rBS5PS3Fs6mflsWnGTsAvXZQ9twOkP0Ul2ORb4LfyWdPCjjRiy2
TNen0RBUZ3N8EclxfuANaB4YLHdrLpaOFGxoV721J51H/PPESONfAaHO/Mi665hQ
81hCWYlWoG1thwERVc/hQ0pgW1nPPP8FTid2IFUxlUhFAftwdcRDfyJN5PkCALfg
V43rC2R6+JGOcq959O6Df1hft/CPRu4YWSlRsPor26qSJeaI+VLrGGOS/oPX7aCE
B7Q746Y1HOGjI3H2THS0znHL+sIrIdSOJfyMfp5tDotDR2GU726t9IAbUepi2iw6
NgVVtlEGZNpNCDMWuLOcxbkFt36QV2xN2751pV/s1L09ska7SY8S+PWvqvMlDNhg
0XxMqLrWvbKRTrt5MByY
=5KY7
-----END PGP SIGNATURE-----

--=-YnUQqtJV5Aud74nn+dAk--

