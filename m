From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Thu, 12 Dec 2013 15:15:23 +0100
Message-ID: <1793565.XC2oCqQxA8@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <20131212100527.GA860@earth.universe> <52A9C470.2030102@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1474008.kAl6g8zjds"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50696 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab3LLOPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 09:15:15 -0500
In-Reply-To: <52A9C470.2030102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sre@ring0.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>


--nextPart1474008.kAl6g8zjds
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Thursday 12 December 2013 16:13:04 Tomi Valkeinen wrote:
> On 2013-12-12 12:05, Sebastian Reichel wrote:
> > On Thu, Dec 12, 2013 at 09:41:49AM +0200, Tomi Valkeinen wrote:
> >>> A label property is still an option.
> >> 
> >> Hmm, what do you mean? Label as in:
> >> 
> >> foo : node {
> >> };
> >> 
> >> Isn't that 'foo' label only visible in DT itself, as a shortcut?
> > 
> > Some driver use a "label" property like this:
> > 
> > foo : node {
> > 
> >     label = "lcd";
> >     
> >     ...
> > 
> > };
> > 
> > See for example
> > 
> > Documentation/devicetree/bindings/leds/common.txt
> > Documentation/devicetree/bindings/mtd/partition.txt
> 
> Ah, I see. That kind of label was actually the first thing I did when
> starting to work on DSS DT. But I removed it, as it didn't describe the
> hardware and I didn't see others using anything similar.
> 
> But I guess one could argue it does describe hardware, not in electrical
> level but in conceptual level.
> 
> The question is, do we need labeling for displays? For backward
> compatibility omapdss would need it, but in general? I'm quite content
> with having just display0, display1 etc. Using the alias node, those can
> be fixed and display0 is always the same display.

As you mentioned in your previous e-mail, if the labels are used by omapfb 
only, I won't strongly push to keep them. I wonder, however, when using 
DRM/KMS, where do the connector labels that are displayed by xrandr for 
instance come from ?

-- 
Regards,

Laurent Pinchart

--nextPart1474008.kAl6g8zjds
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqcUAAAoJEIkPb2GL7hl18EoH/0X2GUNOUOMqkGg9wUoOAXsx
7SX9D3RRfPTHh18PwieEldhb2Mczz4XIjBAqq2D24yv2lkQBSljWX9197WlxKhfs
BrvAqBDMdooe4eL/RlroCugHOfMbO14UB+q17/o71ltjniXEyFWIqbf3N3kr5Ggv
rnjBiB1gBc4fgpLsCPZSLIcUH+uPkQfTOqhUqsFph5OS4GhJc+6uGE0ljX4uGpzM
/DQtNDrw32nYLhe0hDhxWozUG8eQ/uffUnTGjpEtRkYGcCqhwlmGRXBl7cFrETFy
vduZahGg1/Ha3xkR0IvBN88+1450k6HX+hhHCkODkHIJfYz/Z1A2Gs2RE5QPZ1U=
=8Hui
-----END PGP SIGNATURE-----

--nextPart1474008.kAl6g8zjds--

