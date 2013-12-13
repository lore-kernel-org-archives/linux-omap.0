From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 10/26] OMAPDSS: add of helpers
Date: Fri, 13 Dec 2013 03:37:53 +0100
Message-ID: <2305697.KHRE4DRTeL@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <4533892.HJaRcDt4Q8@avalon> <52A96A4E.1010006@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21338831.8Wv3DjDfhb"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54433 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab3LMCho (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 21:37:44 -0500
In-Reply-To: <52A96A4E.1010006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>


--nextPart21338831.8Wv3DjDfhb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Thursday 12 December 2013 09:48:30 Tomi Valkeinen wrote:
> On 2013-12-12 01:19, Laurent Pinchart wrote:
> > On Wednesday 04 December 2013 14:28:37 Tomi Valkeinen wrote:
> >> Add helpers to get ports and endpoints from DT data.
> >> 
> >> While all the functions in dss-of.c might be useful for panel drivers if
> >> they need to parse full port/endpoint data, at the moment we only need a
> >> few of them outside dss-of.c, so only those functions are exported.
> > 
> > I totally understand that it was easier to add this code to the OMAP DSS
> > driver, but I believe we should refactor the existing drivers/media/v4l2-
> > core/v4l2-of.c and move it to a non V4L2-specific location (what about
> > drivers/media ?) sooner rather than later. That's on my to-do list for
> > Saturday.
> 
> I agree. I just didn't want to go that way yet =).
> 
> Have you thought of the API? You had one version in your CDF series, but
> I think that was a bit too limited (I don't remember right now how), so
> I wrote my own versions.
> 
> What I tried to do here is to add simple ways for the drivers to iterate
> the ports and endpoints with omapdss_of_get_next_port and
> omapdss_of_get_next_endpoint.
> 
> But I'm not sure what the use pattern would be. If in most of the cases
> the driver always goes through all the ports and all the endpoints, we
> could as well have a helper function that goes through all the endpoints
> in all the ports, and returns both the port and endpoint for each iteration.

My plan is to keep it simple. I'll take the V4L2 code and add helpers needed 
by this patch series and by my Renesas KMS drivers. I'll then see whether 
refactoring makes sense, and will post the result. We will then add new 
helpers whenever needed on a case by case basis.

-- 
Regards,

Laurent Pinchart

--nextPart21338831.8Wv3DjDfhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqnMGAAoJEIkPb2GL7hl1rmYH/2LBqxvFumkqbBeufseADYAd
g9L5BdpzNvlfL0l950NO+45isqoPv4jP4XoNI/Qxw666niCkoN+RrxFI+uUS5/YM
0n4xjyAwTis9BwO2Qno8pOQgeceB/PBfMeeEYQF8yA3ZKaP2c1AC9zxQHBmiWxTk
D6E+kCp8BFZfue6Y2irF2wzVJhUgswG2P8+6WmidFGxgKKvXUzztdijaz5oNFuSv
0vcNrUeddh5yVfB61VvL5/BbmeUkp8rhdQbbFNBKmtH7mOkqAoHd92By5Xql4sNA
s1xI9fUBtibe3t20oJHOdunvcF4EeZexHijq0Au5Xg0bgvEdKiNyENMrdnP+F2U=
=+U19
-----END PGP SIGNATURE-----

--nextPart21338831.8Wv3DjDfhb--

