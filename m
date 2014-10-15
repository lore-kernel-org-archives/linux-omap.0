From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/3] video: fbdev: omap2: omapfb: add missing MODULE_ALIAS()
Date: Wed, 15 Oct 2014 15:46:10 +0300
Message-ID: <543E6C92.7090404@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com> <1413311335-25083-2-git-send-email-balbi@ti.com> <20141014183426.GA19491@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ErP36q2fVkgcQqGDK2BsdcN3joj2BkhUT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49563 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbaJOMqk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Oct 2014 08:46:40 -0400
In-Reply-To: <20141014183426.GA19491@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>

--ErP36q2fVkgcQqGDK2BsdcN3joj2BkhUT
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 14/10/14 21:34, Felipe Balbi wrote:
> On Tue, Oct 14, 2014 at 01:28:54PM -0500, Felipe Balbi wrote:
>> without MODULE_ALIAS(), omapfb won't get loaded
>> automatically.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>=20
> little note here. This makes omapfb load automatically, but display
> still doesn't work with DSS as modules. Backlight is working and pixel
> clock is running just fine. Still, nothing on display.
>=20
> I thought I'd leave that for Tomi to deal with.

I presume this is about am437x-sk. I don't have the board, so there's
not too much I can do except send emails.

So the panel works fine if display drivers are built-in?

The compatible string seems to be wrong in the .dts file. It says
"osddisplays,osd057T0559-34ts" which is not the panel used. But that
shouldn't affect this.

What do you mean with "pixel clock is running"?

 Tomi



--ErP36q2fVkgcQqGDK2BsdcN3joj2BkhUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUPmySAAoJEPo9qoy8lh71BVEP/jG3FuSshFCAIpmlm2LLO525
ONT7cGyWYJum6BE6+VYwYDNiw+l0sokxFjtzPLSztXPVFtcQueACLikdQtWCu64j
CYk6nY4YPS0TzZi9LxwnFR+ZBz+OGiTbOEbl9teNZnEVaeAGkq5LRqB0+l46LQ8H
FCgVQOWBGxm9xGuI1a8xhaa+pihcdTuaZ1abf/RQ1uUE9BD0oP++UrzTeXhDMXiB
ayoJM0tUeF8HMVCS7tssiv00swQO4E30HYbu5WDJQsWnaSEZmi5229P7SJmllw/G
yt8PeHSQAOUh83EgDa3lBIfzO5ncM02eYqNkI5C31j7Ys5cGQsIBuJ4aDAjYcEKe
Rg8MywP8eIFuD9m2eQA8aPvvwqgn4TINNRpdh22uWVGPUQc9ZnHpkibn4qosvZwc
rrW1WJj6Cyj9uhvqMVAvdT9j9TbrXqjuUWPkRTS/cIv24ISqnajZpyZyo8o7Pt8H
njMAiTr4RPFo4crEBcUX9jIa4mSJ8kuwt/j7En8yOOSpijk3n9Lbyu9Y8GY4PwS0
fNpXEu4hl2vjYOJLZRGFOAhRRFMdUsUVdK79C/j5tCIXPUynqHl9mlaiBqrb9gEq
2RHUrF2+V4lr9vy+Tvn7Q1LdKpgKFqfBJAf3+TNbozUIO89+irw3w20s56DENfYK
oCGZC+WjdmZeVL3N86pX
=lnU3
-----END PGP SIGNATURE-----

--ErP36q2fVkgcQqGDK2BsdcN3joj2BkhUT--
