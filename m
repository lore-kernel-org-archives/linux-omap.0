From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Fri, 13 Dec 2013 04:24:57 +0100
Message-ID: <14299863.f0rzOyPfdL@avalon>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <2364383.8GWpsWSoJu@avalon> <52A9760A.3000801@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6422729.9FbnKenMxp"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54659 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab3LMDYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Dec 2013 22:24:48 -0500
In-Reply-To: <52A9760A.3000801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>


--nextPart6422729.9FbnKenMxp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Thursday 12 December 2013 10:38:34 Tomi Valkeinen wrote:
> On 2013-12-12 01:44, Laurent Pinchart wrote:
> >> The DSS subdevices depend on the dss_core. dss_core has to be powered up
> >> for any of the subdevices to work. This is done automatically by the
> >> runtime PM when the subdevices are children of the dss_core.
> > 
> > I'd like to get a clearer picture of the hardware here. The OMAP3 ISP is
> > organized in a seemingly similar way, with the hardware subdivided in
> > high-level more-or-less independent modules. However, from a system point
> > of view, the ISP submodules are not standalone: they're part of the same
> > power domain as the ISP core, with subclocks management and interrupts
> > being handled by the ISP core. For those reasons we've modeled the ISP as
> > a single platform device.
> > 
> > Are the DSS submodules really independent, or are they organized similarly
> > ? For instance do they each have a clock handled by the OMAP core clock
> > IP, or are the clocks gated by the DSS core ? Do they have interrupts
> > routed to the GIC, or does the DSS core driver demux the interrupts ?
> 
> The DSS is "interesting". The TRM for various OMAP versions are the best
> source of information, there's integration section in the very beginning
> of the DSS chapter.
> 
> We have the main dss_core (just DSS in the TRM, but for clarity we use
> dss_core) module, which is kind of a wrapper/glue for all the
> submodules. dss_core contains things like controlling muxes for signals
> between submodules, or clocks coming from outside. And there's the DSS
> power domain, containing all the DSS modules.
> 
> Then we have DISPC, which reads the pixel data, manipulates it, and
> outputs raw RGB data to encoder submodules.
> 
> Then we have DSI, HDMI, RFBI, VENC encoder submodules. They all have
> separate address spaces, some have dedicated PLLs, PHYs, and interrupts.

The separate address spaces are not by themselves a clear indication that the 
submodules should be considered as separate devices, as the hardware might 
just group registers related to submodules together.

The dedicated interrupts (for DSI and HDMI) and PRCM clocks (for VENC if I'm 
not mistaken, and HDMI on the OMAP4) are a clearer sign. 

> Then DPI, which I think is mostly just level shifters. It's really just
> a port, as you say.
> 
> SDI is a bit unclear to me. The registers for it are in the dss_core.
> There's only a few registers, but it does have a PHY and a PLL. But I
> guess it's also more of a port than a separate module.

After a quick look at the documentation I would say so. I would be tempted to 
consider RFBI as part of the DSS core, but that's less clear.

> As for the clocks, I'm not sure what the actual point is that you want
> to clarify. DSS gets one "main" func clock from PRCM, which is used by
> DISPC and in some cases other submodules. But then we have dedicated DSI
> and HDMI PLLs, which, at least in DSI's case, can be used to fully
> satisfy DSI's clock needs. The PLLs can also be used for DISPC, so the
> PRCM clock is not needed in all cases.
> 
> The interrupts, then. In OMAP4, DISPC, DSI1, DSI2 and HDMI each have
> their own interrupt line. In OMAP3, DISPC and DSI shared the same
> interrupt line. But in both OMAP4 and OMAP3 DISPC and DSI interrupt
> status/enable is handled via the respective IP.
> 
> The DSS submodules also are not really designed together. For example,
> the HDMI IP is from one vendor, not TI. And the HDMI IP is different in
> OMAP4 and OMAP5. Most of the DSS IPs are, I believe, from TI. But it's
> not like all the IPs were designed to work together, that's why we have
> wrappers/glue blocks (e.g. around HDMI).
> 
> So, are they independent? I don't know =). I think they lean on the
> independent side.

I agree with that, except for DPI, SDI and possibly RFBI.

> dss_core is always needed for the submodules to work, but for example DSI
> could be used without DISPC, using system DMA to transfer data from memory
> to DSI. Not a very useful thing to do, but still, there are dedicated DMA
> channels for that.

Right. The real question is whether the DSI or HDMI IPs can be used in a 
system without the DSS core. If not, it might make sense to just merge the 
drivers into a single module (of course with a clear interface between the 
different parts to avoid spaghetti code).

> > If the submodules are not independent, would it make sense to have a
> > single DT node that would be matched with the DSS core driver ? You could
> > list information about the submodules in subnodes, and possibly create
> > platform devices internally in the DSS core, but a single platform device
> > would be instantiated from DT, and the DSS core wouldn't need a
> > "simple-bus" compatible string. My gut feeling is that this would be a
> > better representation of the hardware, but I might not known enough about
> > the DSS and be completely wrong.
>
> I have been wondering about this for a long time. The DSS modules have
> dependencies, and splitting them into separate devices/drivers brings
> the issue of probe order. We side-step that by having the virtual
> omapdss driver

Given that the DSS core has a set of registers not dedicated to any of the 
submodules I believe it should be represented by a device. The omapdss driver 
thus doesn't look virtual to me, it supports a real piece of hardware.

> add the drivers for DSS modules in proper order.
>
> But then, I feel that they are quite independent and probably should be
> separate devices.

Even if they're separate devices they could be instantiated by DSS core based 
on DT nodes. I'm not sure whether that's the best idea, but it might be worth 
thinking about it.

> And we've had omap hwmods, which I believe force us to have separate devices
> (although afaik hwmods are going away).
> 
> >>> BTW, for v3.15, I'm hoping to do patches where we deprecate ti,hwmods
> >>> property and do the lookup based on the compatible property instead ;)
> >>> So from that point of view we need to get the device mapping right in
> >>> the .dtsi files, and don't want to start mixing up separate devices into
> >>> single .dtsi entry.
> >> 
> >> Hmm, was that just a general comment, or something that affects the DSS
> >> DT data I have in my patch? As far as I understand, the DSS nodes
> >> reflect the current hwmods correctly.
> >> 
> >> With the exception that DPI and SDI do not have a matching hwmod, as
> >> they are really part of dss_core/dispc. They are separate nodes as they
> >> are "video outputs" the same way as the other subnodes.
> >> 
> >> I could perhaps remove the DPI and SDI nodes, and have them as direct
> >> video ports from DISPC, but... That's easier said than done.
> > 
> > DPI and SDI indeed seem like ports to me, node devices. Have you given the
> > implementation a thought ? How difficult would it be ?
> 
> I have not though too much about the implementation. I'll spend some time on
> that to see how it goes.
> 
> There's also the question where do the ports belong to. DISPC outputs the
> pixels.
> 
> For DPI, I don't see dss_core really doing anything.
> 
> For SDI, the dss_core contains the control for the SDI PLL and PHY. But
> SDI PLL and PHY are not parts of dss_core, just the control is done via
> dss_core.

If the PLL and PHY are solely controlled through registers part of the DSS 
core register space, they would seem like part of the DSS core to me.

-- 
Regards,

Laurent Pinchart

--nextPart6422729.9FbnKenMxp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSqn4OAAoJEIkPb2GL7hl1UIIH/1C4h99bS52sdEyIgv7H9gtt
m9Lv61mc2Cd+1jN24oraUyAwExNF9R7bbPgXtIDTPY+iEu2ST7FTi/peUqiAVZeV
88KUnGwCYH5Sz/ra+hgavJBg/Z91Br+LzhVcIIgP8EJzE4NgaSfzD5XSlFuxWdIS
86O/jHtZrY1iQWMp//mHMz/Q50CTVYbbsBxOt8LB7dAt9KPb4eXSjIFa25NjAmzW
YylV71d0mP2CunwPT3xAr4Gpt6gIK/DLmbLAQPJ49mb/oVprPLsSE0jbHIoHlitx
jdBBLmyRXmRg8TzPGczpYe5L1v4EdQji61oroMLhrTVZnM0ACzIfe/dV2ocCuao=
=OE6A
-----END PGP SIGNATURE-----

--nextPart6422729.9FbnKenMxp--

