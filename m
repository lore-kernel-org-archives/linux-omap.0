From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Thu, 12 Dec 2013 00:44:38 +0100
Message-ID: <2364383.8GWpsWSoJu@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <20131205170514.GY26766@atomide.com> <52A5BB65.5050109@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2077909.0JknbHqnmb"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46399 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3LKXog (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Dec 2013 18:44:36 -0500
In-Reply-To: <52A5BB65.5050109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>


--nextPart2077909.0JknbHqnmb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Monday 09 December 2013 14:45:25 Tomi Valkeinen wrote:
> On 2013-12-05 19:05, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [131204 04:31]:
> > 
> > Description missing.. But other than that can you please check that
> > the latest patch I posted in thread "[PATCH] ARM: OMAP2+: Fix populating
> > the hwmod data from device" works with this?
> > 
> > The test to do is to remove the related reg, interrupt and dma entries
> > from omap_hwmod_*_data.c, and make sure the related hwmod data is
> > initialized from DT properly.
> 
> I made a quick test with panda, by applying your patch and reverting
> b38911f3472be89551bfca740adf0009562b9873. That only effectively tests
> the DISPC IRQ, but that worked fine.
> 
> > I don't know if it makes sense to have them as children of dss_core, they
> > really all seem to be completely independent devices?
> 
> The DSS subdevices depend on the dss_core. dss_core has to be powered up
> for any of the subdevices to work. This is done automatically by the
> runtime PM when the subdevices are children of the dss_core.

I'd like to get a clearer picture of the hardware here. The OMAP3 ISP is 
organized in a seemingly similar way, with the hardware subdivided in high-
level more-or-less independent modules. However, from a system point of view, 
the ISP submodules are not standalone: they're part of the same power domain 
as the ISP core, with subclocks management and interrupts being handled by the 
ISP core. For those reasons we've modeled the ISP as a single platform device.

Are the DSS submodules really independent, or are they organized similarly ? 
For instance do they each have a clock handled by the OMAP core clock IP, or 
are the clocks gated by the DSS core ? Do they have interrupts routed to the 
GIC, or does the DSS core driver demux the interrupts ?

If the submodules are not independent, would it make sense to have a single DT 
node that would be matched with the DSS core driver ? You could list 
information about the submodules in subnodes, and possibly create platform 
devices internally in the DSS core, but a single platform device would be 
instantiated from DT, and the DSS core wouldn't need a "simple-bus" compatible 
string. My gut feeling is that this would be a better representation of the 
hardware, but I might not known enough about the DSS and be completely wrong.

> > BTW, for v3.15, I'm hoping to do patches where we deprecate ti,hwmods
> > property and do the lookup based on the compatible property instead ;)
> > So from that point of view we need to get the device mapping right in
> > the .dtsi files, and don't want to start mixing up separate devices into
> > single .dtsi entry.
> 
> Hmm, was that just a general comment, or something that affects the DSS
> DT data I have in my patch? As far as I understand, the DSS nodes
> reflect the current hwmods correctly.
> 
> With the exception that DPI and SDI do not have a matching hwmod, as
> they are really part of dss_core/dispc. They are separate nodes as they
> are "video outputs" the same way as the other subnodes.
> 
> I could perhaps remove the DPI and SDI nodes, and have them as direct
> video ports from DISPC, but... That's easier said than done.

DPI and SDI indeed seem like ports to me, node devices. Have you given the 
implementation a thought ? How difficult would it be ?

-- 
Regards,

Laurent Pinchart

--nextPart2077909.0JknbHqnmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqPjxAAoJEIkPb2GL7hl17nsH/1UR30G65GqfGuQ6gGawwoUS
Re9wTArO10Z9aTXeKxNUg4GeINsyn1DDvWk5Ok7PDfwVZcxmjBaQxAzpsXEwkDUj
KULcG2qRxGxicx+o7UfVwcCycBNC8INUJaVD6N5kxAd4ZPJW5Evmwb+wqmH/Y9S6
xDros7EUUgWAesBgo6aCvykUmjPWlny75Re8M8iTuKgHMqRTqNjhyzCkoS0zc7Bu
4SkLJZdPwRkwCgmpsrjjxx1axL8zFlIJXJvokmAwnxyBSiIO2PRadMpx5b6WDibN
QA9RlfhLnCH0+MDypni9ds8DCHaaMp8UOUL4oeZbwlAlCSeR5G6u2ePPTWbRhVU=
=hC2p
-----END PGP SIGNATURE-----

--nextPart2077909.0JknbHqnmb--

