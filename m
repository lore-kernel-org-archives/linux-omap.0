From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 10:58:53 +0300
Message-ID: <1340611133.3395.3.camel@deskari>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
		 <1340372890-10091-6-git-send-email-rnayak@ti.com>
	 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-16Zo+LmbIn/FZexT1I9m"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53659 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753262Ab2FYH7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 03:59:13 -0400
Received: by lbbgj3 with SMTP id gj3so6755609lbb.11
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 00:58:49 -0700 (PDT)
In-Reply-To: <4FE80C43.6090802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org


--=-16Zo+LmbIn/FZexT1I9m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-06-25 at 12:29 +0530, Rajendra Nayak wrote:
> On Monday 25 June 2012 11:37 AM, Tomi Valkeinen wrote:
> > Hi,
> >
> > On Fri, 2012-06-22 at 19:18 +0530, Rajendra Nayak wrote:
> >> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_pre=
pare()
> >> and clk_unprepare() for the omapdss clocks.
> >
> > You used clk_prepare and clk_unprepare instead of clk_prepare_enable an=
d
> > clk_disable_unprepare. I didn't check the dss driver yet, but my hunch
> > is that the clocks are normally not enabled/disabled from atomic
> > context.
> >
> > What does the prepare/unprepare actually do? Is there any benefit in
> > delaying preparing, i.e. is there a difference between prepare right
> > after clk_get, or prepare right before clk_enable? (And similarly for
> > unprepare)
>=20
> clk_prepare/unprepare are useful for clocks which need the 'enable'
> logic to be implemented as a slow part (which can sleep) and a fast part
> (which does not sleep). For all the dss clocks in question we don't need
> a slow part and hence they do not have a .clk_prepare/unprepare
> platform hook.
>=20
> The framework however still does prepare usecounting (it has a prepare
> count and an enable count, and prepare count is expected to be non-zero
> while the clock is being enabled) and uses a mutex around to guard it.
> So while the dss driver would do multiple clk_enable/disable while its
> active, it seems fair to just prepare/unprepare the clocks once just
> after clk_get() and before clk_put() in this particular case.

But the driver should not presume anything special about the clocks. In
this case the dss driver would presume that the clocks it uses do not
have prepare and unprepare hooks.

If the generally proper way to use prepare/unprepare is in combination
of enable/disable, then I think we should try to do that.

I'll check if any of the dss clocks are enabled or disabled in atomic
context.

 Tomi


--=-16Zo+LmbIn/FZexT1I9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6Bo9AAoJEPo9qoy8lh71DWoP+gOZ2tWXeq7+eJkFtSUewC7w
pAszW84deRa3Dn9J2Xo9BCwSEwkOCKBaYHiXhDEsnJMms52uF7Lcdt8fY6iXjkwx
+G1p9MRNTkG7gfCqssQrObRO9M1W5/CR34q6y0hnjaFSfuJ+deBCjtf6VLzH6nWh
aCdyhzjfjGM2TvwDmwkW6yy8ZCYtozxsCWoA0f3pBkmvlHuBxAFW/By2amz+vb3V
ArSIkxLvy/DdNgkvAFEiZ7bgwDnuksv+bN8UfONYU5+NvhjS/QAugRBzeDFhNap+
BXAN8vAdt6eZ3j5fpZRe7lFLEV2Qrdamh8YRys0JksfHZQBi4eyOi98GEqUx01lt
ZS83n+fpHHG0WyaO3WOMAGiwhy4TAOsAEQSEWE78NtZcS3ncQ+C9yhOrdAYA4X5v
anXt1fcLToUZZtpR8NEPnLd6v2BWYhSzDQsPuK+L9/086bizck2XoG1tHA1XBkCx
+DXShYbq4Yd4neqSl3LJQvpGXmLHVJ/LOgzxeOLGQA4N/IBMV5IbjuFw6efcgF79
M+yDzFAuwm0Yrmy2xLkfKjBdxhgpgM4PNiSP0qqKNOLXAIUy5CyNtFSwgFIkZKQm
lbOgTy1pKPivrfrbf+uUfs3IF+Cyjo80UoYIiPFYSCmldK8TOs6eS7bMxg+NfBaZ
nAp6sNfjLKlNKJnOVMQn
=Hch2
-----END PGP SIGNATURE-----

--=-16Zo+LmbIn/FZexT1I9m--

