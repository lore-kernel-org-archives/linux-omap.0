From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/5] OMAPDSS: Export functions to enable dynamic linking
Date: Mon, 13 Feb 2012 15:48:26 +0200
Message-ID: <1329140906.2817.6.camel@deskari>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
	 <1329004530-28029-5-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Nh7NrVZoa23Rjbdl/Q+V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36723 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750920Ab2BMNsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Feb 2012 08:48:30 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so3901303lag.19
        for <linux-omap@vger.kernel.org>; Mon, 13 Feb 2012 05:48:29 -0800 (PST)
In-Reply-To: <1329004530-28029-5-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org


--=-Nh7NrVZoa23Rjbdl/Q+V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 2012-02-11 at 17:55 -0600, Ricardo Neri wrote:
> The functions dss_init_hdmi_ip_ops and dss_has_feature are used by
> the ASoC HDMI codec. Both the ASoC codec and DSS may be built
> as separate kernel modules. Hence, these two functions need to be
> available for dynamic linking.

Neither of those functions should be exported, they are omapdss
internal. And you had to hack around to make those usable by adding
drivers/video/omap2/dss into the include path.

Anything that is exported from omapdss should be added to
include/video/omapdss.h. Users of omapdss should never include anything
from drivers/video/omap2/dss.

But as I said, neither of those functions should be exported, they are
clearly omapdss internal functions. For dss_has_feature we probably need
a new function to convey the information about the hdmi features that
the audio side needs. Or perhaps it can be in the ip_data.

For dss_init_hdmi_ip_ops I don't see why the audio part should see it.
Initializing the ops should clearly be done by omapdss automatically.

 Tomi


--=-Nh7NrVZoa23Rjbdl/Q+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPORSlAAoJEPo9qoy8lh71eyIP/0jYj37ceMVp66/UsfhRQ+EW
Krt0VRdfllYd2KcA1hxhaOs7Ahmo2jy1USUngTK/pn261/bFLWQ2PsanWxWTtiMh
wQAkiC90bbVmX4fz1lPQEJUgyh4N1ziZADA36U1Eild40UaOMxKLg/7uXpCQkB9f
kLO/Nq6/C7MUO7IJaAB5o4oj6jiEFCNt1AhqGfQA8EuhySqG3TQEZCi1O6gSGh1v
O3ltYd3AhOpeC7cQZxe5ipZ/ouU4zjmZt/ZhH51VOswPuwKRTs9BVvM/arANkzRh
zxFyDhT3cBc4ogk5giHu/yRxFQW2IDoBhmv2kLICbpVUJ77nV1+JoZULpOPcaIXg
PhMMv/UImpIlP5jkMVUo9/6OYwJ+yAYzojv2QVccERancNKWdugcy+GDGIfBSMTA
KwjIQuNNDc8x7Y1CXJSWdN26bzt7+sAvIVJks7/JSlE36NhkHW7346RdB5LVaaTZ
qAFjd6yv45mnffyprDtcVXGIm2xE8VEYXQa8A2LhTxT6EJg5C6Bwl6KCtE2WCFVY
NmgIhZeTQH5giazHACP3fje+i06kivgisRSFKRIObOmooJO3KcC06TA6O9I/t9GK
zc8GhU/99JDY51ahTUxD6WRQLI6zl1YGs/6syEqbv/fuFt5Jtcjg/M+iLKkVIbW9
16/55h06RVm/pDhjFTF7
=1h1R
-----END PGP SIGNATURE-----

--=-Nh7NrVZoa23Rjbdl/Q+V--

