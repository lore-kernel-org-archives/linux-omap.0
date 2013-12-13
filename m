From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Fri, 13 Dec 2013 04:45:32 +0100
Message-ID: <1703598.NbqXAMAFOI@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1824203.Ui6fpnZVmO@avalon> <52A979D8.3040604@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3070249.ECfcTHC076"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54762 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab3LMDpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 22:45:18 -0500
In-Reply-To: <52A979D8.3040604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>


--nextPart3070249.ECfcTHC076
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Thursday 12 December 2013 10:54:48 Tomi Valkeinen wrote:
> On 2013-12-12 02:39, Laurent Pinchart wrote:
> > On Wednesday 04 December 2013 14:28:27 Tomi Valkeinen wrote:
> >> Hi,
> >> 
> >> Here's a new version for DT support to OMAP Display Subsystem. See
> >> http://article.gmane.org/gmane.linux.ports.arm.omap/102689 for the intro
> >> of the previous version, which contains thoughts about the related
> >> problems.
> >> 
> >> The major change in this version is the use of V4L2 and CDF style
> >> port/endpoint style in the DT data.
> > 
> > That's great, and I fully support that. This also calls for refactoring
> > the V4L2 DT bindings and support code to share them with display devices.
> > A bikeshedding question is where to put the common code.
> 
> Thanks very much for review!
> 
> I know drivers/video is in practice "fbdev", but drivers/video (the
> words) sound like the best place for things related to video.

That's an option as well, but I'm not sure I like the idea of mixing fbdev and 
generic video in a single directory. We could use a subdirectory of 
drivers/video.

> We should establish a committee to ponder this important question.
> 
> Btw, I don't know if you noticed (or did I mention it somewhere): I use
> a bit shortened form of the V4L2 bindings. If there's just one endpoint,
> I omit the port node. I think that's always unambiguous (compared to
> also omitting the endpoint node, and having the properties in the main
> node, as was mentioned in some other thread).

Yes, I've seen that. I need to analyze this in detail, that's planned for when 
I'll work on sharing the DT parsing code.

> I also don't supply the same data for both endpoints, when the data is about
> the link. E.g. I think the V4L2 binding doc suggests to supply things like
> bus-width for both endpoints. I only supply the data for the endpoint that
> uses that data. With some encoders/panels the same data could be needed on
> both ends, but not in these patches.

How do you handle the situation where the two drivers (for each end of the 
link) need to know the bus width for instance ?

> >> However, note that even if the DT data contains proper port & endpoint
> >> data, the drivers only use the first endpoint. This is to simplify the
> >> patches, as adding full support for the ports and endpoints to the
> >> drivers will be a big task.
> > 
> > That's perfectly fine, there's no need to implement unused features just
> > for the sake of it, as long as the bindings are forward-compatible in
> > that respect.
> > 
> >> This approach still works with more or less all the boards, as the only
> >> cases where the simpler model is an issue are the boards with multiple
> >> display devices connected to a single output.
> >> 
> >> Laurent, I'd appreciate if you could have a look at the .dts changes, to
> >> see if there's anything that's clearly not CDF compatible.
> > 
> > I've quickly reviewed the patch set, concentrating on the .dts changes.
> > Overall it looks good to me, but I suspect that we will need quite some
> > time to finalize standard bindings as there's lots of small details that
> > need to be taken care of.
> 
> Yes. I want to get this forward as it's becoming too much pain to manage
> things without DSS DT support, when the rest of the OMAP platform code is
> using DT.
> 
> The most important thing in the DSS DT bindings for now is that they should
> contain enough information so that any future DT bindings changes can be
> handled with a boot-time conversion code.

I'm afraid I can't give you any guarantee here. The bindings will be unstable 
for some time, and we'll have to deal with that somehow.

> Actually, even the endpoint/port stuff is extra, as that could be deduced
> even from the "video-source" method I used in earlier DT versions.
> 
> > The major point that bothers we, as explained in my reply to one of the
> > patches, is that I feel like the multi-device model (virtual DSS core +
> > DSS modules) might not accurately represent the hardware. Departing from
> > it probably sounds scary but might not be such a large change.
> 
> There are actually two separate things here. One is the multi-device model,
> having separate device for each DSS submodule. The other is having the
> 'omapdss' "virtual" platform device.
> 
> Note that the "dss_core" device is a real HW block, and depicted as the
> "dss" node in DT data, whereas "omapdss" device is not present in the DT
> data, and is created dynamically at boot time.

That's a distinction I've missed.

> The omapdss device is a legacy thing, but nowadays it is mainly used to pass
> platform data. Removing omapdss device is not easy, but the only questions
> around that is how to implement the required platform-data functionalities,
> and it doesn't affect the DT data.

The omapdss platform data structure contains the following fields

- get_context_loss_count: What is that used for ?

- num_devices, devices, default_device: What are those used for ?

- default_display_name: This should be easy to move to DT.

- dsi_enable_pads, dsi_disable_pads: Those don't seem to be used in mainline. 
What's their purpose, and how are they implemented on platforms that make use 
of them ? Is the pinmux API an option ?

- set_min_bus_tput: We have the same problem for the OMAP3 ISP, so a generic 
solution is needed here.

- version: Given that we detect the DSS revision based on the SoC revision, 
I'm tempted to either explicitly encode the DSS revision in the compatible 
string, or let the DSS driver query the SoC revision somehow. The later is 
considered as a layering violation, but let's face it, I can't see the DSS 
being used on a non-OMAP platform.

-- 
Regards,

Laurent Pinchart

--nextPart3070249.ECfcTHC076
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqoLcAAoJEIkPb2GL7hl1+asH/2ek7QsZ4swYaXXLjPuZZvUq
7tdkGhfT/tj4MEmel4PmaIy7mcErPMsP++LSrd99GGG1c084d9fArA4xQqtLxWS0
g1lZIysW13sKFlLEoyAwNqimTZXac6RyYkO+6HC+Jd0WQWxXxMWurd0VZ/XVH+X4
Bib3qfJNnv4JemhdMMZORXzZIVU/Hwzaqep4Pe2AYNlgxVNp9+YtjP4eZs1vIrXC
EiQEG/rTT3OM/RzAI8fu58eLS8BZ5DBaxXrN4nEDddILN+/ctwgRQzbHZPeNYCUv
9QeefovEK6POsLiXzxctPWAuvQwaakrXx8snYsRfV6AAkovphz7tBIAULfTXSiw=
=GXKO
-----END PGP SIGNATURE-----

--nextPart3070249.ECfcTHC076--

