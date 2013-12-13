From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Fri, 13 Dec 2013 15:37:28 +0100
Message-ID: <3426377.keoaFgiZkl@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1703598.NbqXAMAFOI@avalon> <52AADBE0.3030203@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2456591.1QG0KlSJky"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:58160 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab3LMOhP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Dec 2013 09:37:15 -0500
In-Reply-To: <52AADBE0.3030203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>


--nextPart2456591.1QG0KlSJky
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Friday 13 December 2013 12:05:20 Tomi Valkeinen wrote:
> On 2013-12-13 05:45, Laurent Pinchart wrote:
> >> I know drivers/video is in practice "fbdev", but drivers/video (the
> >> words) sound like the best place for things related to video.
> > 
> > That's an option as well, but I'm not sure I like the idea of mixing fbdev
> > and generic video in a single directory. We could use a subdirectory of
> > drivers/video.
> 
> Right, that's what I meant.
> 
> >> I also don't supply the same data for both endpoints, when the data is
> >> about the link. E.g. I think the V4L2 binding doc suggests to supply
> >> things like bus-width for both endpoints. I only supply the data for the
> >> endpoint that uses that data. With some encoders/panels the same data
> >> could be needed on both ends, but not in these patches.
> > 
> > How do you handle the situation where the two drivers (for each end of the
> > link) need to know the bus width for instance ?
> 
> Then I fill the bus-width for both ends, as shown in the V4L2 bindings.
> That's what I mean with "I only supply the data for the endpoint that
> uses that data". If both ends use the data, I supply it for both.

That sounds good to me.

> >> The most important thing in the DSS DT bindings for now is that they
> >> should contain enough information so that any future DT bindings changes
> >> can be handled with a boot-time conversion code.
> > 
> > I'm afraid I can't give you any guarantee here. The bindings will be
> > unstable for some time, and we'll have to deal with that somehow.
> 
> I'm not asking for a guarantee. Just "yes, feels fine" =).
> 
> > The omapdss platform data structure contains the following fields
> > 
> > - get_context_loss_count: What is that used for ?
> 
> To find out if a HW block has been turned off and it has lost its
> registers contents. It's an optimization, without it we need to restore
> registers each time when runtime_resume() hook is called.
> 
> However, that's on its way out. I've already made new PM code for dispc
> which doesn't use that. But I can't merge it before omapdrm has been
> fixed to properly set things up when enabling a display.

OK.

> > - num_devices, devices, default_device: What are those used for ?
> 
> Nothing anymore. They can be removed.
> 
> > - default_display_name: This should be easy to move to DT.
> 
> How? I handled it so that I assign the aliases for displays, and
> display0 is always the default display. "default display name" is not
> really a hw property =).
>
> I think this should not be used for DT, and just use the display0 as
> default (if we use aliases). If we don't use aliases, and instead use
> the label properties as discussed in other thread, then there has to be
> some other mechanism to tell which display should be used.

Another option would be to add a phandle that references the default display. 
I don't have a strong preference at the moment.

> > - dsi_enable_pads, dsi_disable_pads: Those don't seem to be used in
> > mainline. What's their purpose, and how are they implemented on platforms
> > that make use of them ? Is the pinmux API an option ?
> 
> They are used in mainline, grep again =).

The only implementations I can find in arch/arm/mach-omap2/display.c are

static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
{
        return 0;
}

static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
{
}

> They set pinmuxing for DSI. Pinmux API is an option, but I think it would
> require a new driver. The DSI pins for DSI1 and DSI2 are configured in a
> single register, where the fields go in seemingly random order with varying
> widths. pinmux-single cannot be used.

Or, as Archit mentioned, we could pass the SYSCONF registers as resources. 
That might not be very clean though.

> > - set_min_bus_tput: We have the same problem for the OMAP3 ISP, so a
> > generic solution is needed here.
> > 
> > - version: Given that we detect the DSS revision based on the SoC
> > revision, I'm tempted to either explicitly encode the DSS revision in the
> > compatible string, or let the DSS driver query the SoC revision somehow.
> > The later is considered as a layering violation, but let's face it, I
> > can't see the DSS being used on a non-OMAP platform.
> 
> I also would just use the compatible string, but we need to separate between
> different OMAP ES versions. Doing that would mean we'd need different .dtsi
> and .dts files for the different OMAP ES versions. It would be a mess.
> 
> I have a TODO item to study this. There are only a few things that are
> problematic (changed between ES versions without changing DSS HW revision).
> If I can find a way around those, the compatible string should be enough.
> 
> One example is the width of a blanking interval. Newer OMAP3 revisions have
> a slightly wider field. I didn't try, but maybe I can write 1-bits to the
> register, then read it, and if only part of those 1 bits "stick", I know
> it's an old revision.
> 
> Anyway, I think this platform data thing is not strictly related. None of
> these items affect the DT data (except the pinmuxing, but I think it's fine
> to add that later). So while the above issues need to be fixed at some
> point, I think they don't affect this series (well, the default display is
> there which may affect).

-- 
Regards,

Laurent Pinchart

--nextPart2456591.1QG0KlSJky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqxuoAAoJEIkPb2GL7hl10HIH/0dsltANu+QTWe7XFhMuOsss
JsTdIdcnqpcWUiTmuh8j49k79eogNM5ixrhDJ/SUPTlfoqtSMyZFZ8tvtzpq7Thh
4kuU9lyzSArLU+xYHWnJhD8qSFu0BS/Yxt1Q/kogCuOcaTrQ2FmbL2+Sj19d6faj
Hvd024Y5yb0eqfoc2s9Y1ZQIjKJm29GLqsrTCTFGhbhV9p23uhLl7qSP/f6tPqsI
hUDVHh1gN3mk43sGXNne7XGp/rnpL6zQVQEVVJW69pxjc/1rf3DmivhLR8W43x7Z
2c/IUxE0fRUzeQP2/3/Kn9NkKqnBhXQ8JjVIGSgDVITUr65+zkqOVVriwtLn9XU=
=yB+4
-----END PGP SIGNATURE-----

--nextPart2456591.1QG0KlSJky--

