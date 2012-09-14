From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 09/21] OMAPDSS: DISPC: Calculate scaling limits in a
 more generic way
Date: Fri, 14 Sep 2012 13:18:13 +0300
Message-ID: <1347617893.2559.73.camel@deskari>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	   <1347538505-25359-10-git-send-email-archit@ti.com>
	  <1347612788.2559.57.camel@deskari> <5052F547.9090102@ti.com>
	 <1347616145.2559.70.camel@deskari> <505300FC.3020706@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-r4D1pH2Stzf3yr+y4jak"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41682 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753822Ab2INKSX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 06:18:23 -0400
Received: by lbbgj3 with SMTP id gj3so2632288lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 03:18:15 -0700 (PDT)
In-Reply-To: <505300FC.3020706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-r4D1pH2Stzf3yr+y4jak
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-14 at 15:33 +0530, Archit Taneja wrote:
> On Friday 14 September 2012 03:19 PM, Tomi Valkeinen wrote:

> > I see your reasoning. I'm a bit reluctant to add a new clock term to
> > omapdss. You can't (probably) find it in the TRM. Does the TRM talk
> > about clocks with regard to WB?
>=20
> Yes, you can't find the word pixel clock linked to WB in the TRM.

Is there some other term for the clock related to WB?

> Yes, we could do that. I can check if zero leads to some bad results, or=
=20
> we could just bypass the scaler clock stuff if the pixel clock is 0.

I think 0 value would make more sense than a dummy 1. 1 is still a valid
clock, and it could go unnoticed in some other code paths that would use
the function to get the clock.

Of course, the scaler check function could internally check if the pck
is 0, and then use 1 in its calculations, if that makes the function
simpler.

 Tomi


--=-r4D1pH2Stzf3yr+y4jak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUwRlAAoJEPo9qoy8lh71DZkQAJgqRZl4EQLlBK0HuGKlRxcb
Ymjf190zsdt/m8nfl42rpb8APJkecLF7jWTEROtetqqTqOqE8TWpc/crCyEUQMPh
EYW4/XizRx+SdzVauaXLiFnyhzDLIv1754mRJ4xqp5RbiRCzbIshPE09bdtT6+1c
0N1zfLtHNiGzzqZ6SyWDnEa8FsFwJ7t27613uAGR6YNd4Jc5qFfnShQDJdQ0EVjL
8hm/EBlH10jGQKyt0oi2c+LgrcMl9Fbq5x3Q3OTIVZJ/eTLKWg/OcEYLMbSqs24B
80Ow7EtZRZmx/Wu3di40CLpWoiuoKboWwGgDf1Aa9LmLTSdYngyNfHTEHdxyVGeb
wVVuWyi1pi8mIZBeopUiQ7yoJV4gzHxAsPmb902y8/1n+1yk9hhCtAPYtr5SJ5I+
Ah+wuqr8BZCAEOqPBStrvY5R92I8vXGL/3n0mI0zqdr+15/pMZulcDrbTvNYPC8K
oyLPZWBzNAqkMyjxOVRbZ02v8jUG0/9BReYx2Bq1CAJc4KQELse38Leq/6p88Xmm
ZR87HXfWGaIPqrbpXWoAtNcezRkt3/4YrxeS4VKeL1QTJgMusgUhSZltYe2HTqY9
JcRbAliwylCyUnZPzVIsWr61Ch+e0sObN7KuDA9sQd8g3zOjkPEjAmiqaaL0io3O
kqorl8FVaaVrhwKPtxjC
=MvLU
-----END PGP SIGNATURE-----

--=-r4D1pH2Stzf3yr+y4jak--

