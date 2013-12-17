From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv2 23/27] OMAPDSS: connector-dvi: Add DT support
Date: Tue, 17 Dec 2013 16:15:09 +0100
Message-ID: <1651476.iaILztiDEi@avalon>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <20131217070551.GR24559@pengutronix.de> <52AFFA2E.5050702@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1731693.kbOFvpTmyz"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:59063 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab3LQPOv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 10:14:51 -0500
In-Reply-To: <52AFFA2E.5050702@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>


--nextPart1731693.kbOFvpTmyz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Tuesday 17 December 2013 09:15:58 Tomi Valkeinen wrote:
> On 2013-12-17 09:05, Sascha Hauer wrote:
> > On Mon, Dec 16, 2013 at 04:56:30PM +0200, Tomi Valkeinen wrote:
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >> ---
> >> 
> >>  drivers/video/omap2/displays-new/connector-dvi.c | 43 ++++++++++++++++++
> >>  1 file changed, 43 insertions(+)
> >> 
> >> diff --git a/drivers/video/omap2/displays-new/connector-dvi.c
> >> b/drivers/video/omap2/displays-new/connector-dvi.c index
> >> b6c50904038e..d1204b1c5182 100644
> >> 
> >> +static const struct of_device_id dvic_of_match[] = {
> >> +	{ .compatible = "dvi-connector", },
> > 
> > Either the driver is too specific or the binding is too generic, but
> > having such a generic name for an omap specific driver seems wrong. Same
> > for panel-dpi, svideo-connector, composite-video-connector and
> > hdmi-connector,
>
> Hmm. Good point. I was thinking that the driver is only used on OMAP, but of
> course that's not true, the driver is there for all platforms if the kernel
> just happens to be compiled with the driver.
> 
> And it's not just about those drivers you mention. The same issue is there
> for, say, "ti,tpd12s015". I have an omapdss specific driver for that, but if
> some other platform uses the same chip, they'll have a driver for it also...
> 
> Sigh. I wonder how this should be handled... The only solution that comes to
> my mind is to have all the compatible strings as "ti,...". But that's not
> correct, as they are not TI components, but some are generic ones and some
> from another vendor.
> 
> And even "ti,..." is not good, as there are other TI SoCs with other display
> drivers. So I'd need to prepend the compatible strings with "omapdss,...",
> making the hardware components driver specific.
> 
> The long term plan is to make the drivers generic (or implement the same
> driver for common display framework). But for now I need to have future
> proof DT bindings with omapdss specific drivers...

I'll refrain from mentioning that the problem has been identified more than a 
year ago. Oh, wait, I've metioned it, sorry :-D

We really want to make drivers generic enough to be shared by multiple display 
controllers. I would vote for making the DT bindings generic now already, 
which would be enough to buy some time to fix the problem properly. If we 
start prepending driver-specific prefixes such as "omapdss," to compatible 
string we'll just make the mess even larger and reduce the incentive to fix 
it. It would be the worst decision we could make.

-- 
Regards,

Laurent Pinchart

--nextPart1731693.kbOFvpTmyz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSsGp9AAoJEIkPb2GL7hl1SDcIAJdKUYEX1g7EKvaI4BD05rsl
pttWKQc3mhjSwFKpmwp67kc3AiHeNZNJ6mkQuUGuxwYD2R7ci8cCUq1EwomDGWAH
EayjugLuJHvrooV+OPEI4ueCpCGEtNCOwbMWh7NM9ee18Xp7zvDNKAHoZSrUYZ4V
puJnPqWThy1g63WLabzhgICbBTHgn3zaEx8/woKdQW/XtafTxKiEnluwPgFfkGJ8
PTExnNMtjoZCnG0pykDh/mpF21SADdIGn/wgPYEq05kZ/Z3nOm96FP2uXB5w18Rn
WL7uNnEIOl8gVLs+w2Oq2YpUrh2laakWYvgxJQfvecHKToqocVl4MsbjPQN3i1U=
=FbPT
-----END PGP SIGNATURE-----

--nextPart1731693.kbOFvpTmyz--

