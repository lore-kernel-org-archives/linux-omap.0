From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Thu, 12 Dec 2013 14:22:58 +0100
Message-ID: <1845981.KyH0yMBnPe@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <52A968BD.20304@ti.com> <20131212100527.GA860@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6031562.SWKSuiVqNS"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50391 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab3LLNWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 08:22:50 -0500
In-Reply-To: <20131212100527.GA860@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>


--nextPart6031562.SWKSuiVqNS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 12 December 2013 11:05:28 Sebastian Reichel wrote:
> On Thu, Dec 12, 2013 at 09:41:49AM +0200, Tomi Valkeinen wrote:
> > > A label property is still an option.
> > 
> > Hmm, what do you mean? Label as in:
> > 
> > foo : node {
> > };
> > 
> > Isn't that 'foo' label only visible in DT itself, as a shortcut?
> 
> Some driver use a "label" property like this:
> 
> foo : node {
>     label = "lcd";
> 
>     ...
> };

Yes, that's what I meant.

> See for example
> 
> Documentation/devicetree/bindings/leds/common.txt
> Documentation/devicetree/bindings/mtd/partition.txt

-- 
Regards,

Laurent Pinchart

--nextPart6031562.SWKSuiVqNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqbi3AAoJEIkPb2GL7hl1gSQIAKAv07hkv9LDKGqns3K+2rIK
dRQq9eWEobQbHbw56lL5W4x1dak9mKXXFuRcA779fnH8Ys1loH5cw15QjBcpLBtx
FB8OS5rOGNgRD6efDUcbIC6RVw8G3Z+6fr0Qjo588SHZIypufLsnass0OZgBJBxk
nkZaQV6Ju8Jb1gH0HvfX2kqSYwMdVg44VeRoziga82I6qaVj0H86dWrlsXHriugF
Yu9a4wtmwhDpYYLLfUL+NVLNqjiZtZCsC4MdSOnB+QNXAjpMVhc+JXYD3QRGeibc
dAniXF7+bosBP0xXoXHaWWNYbYM+ppxbBXtGktp01k87VKfwi8scNmlmXOEnDcA=
=cD+F
-----END PGP SIGNATURE-----

--nextPart6031562.SWKSuiVqNS--

