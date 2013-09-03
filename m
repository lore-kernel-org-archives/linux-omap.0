From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC 00/22] OMAPDSS: DT support
Date: Tue, 03 Sep 2013 12:56:43 +0200
Message-ID: <2000227.2HHoRiWzTm@avalon>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com> <2305295.bk1TpuGLMv@avalon> <5224458F.9070401@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7789301.B9XXDaW6Jh"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:60354 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710Ab3ICK4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 06:56:49 -0400
In-Reply-To: <5224458F.9070401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>


--nextPart7789301.B9XXDaW6Jh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Monday 02 September 2013 11:00:15 Tomi Valkeinen wrote:
> On 22/08/13 00:07, Laurent Pinchart wrote:
> 
> Thanks for the comments!

You're welcome.

> >> The exception to the above are DSI and DBI. DSI and DBI are combined
> >> control and video busses, but the use of the busses for control purposes
> >> is not independent of the video stream. Also, the the busses are, in
> >> practice, one-to-one links. And last, DSI and DBI display entities are
> >> often also controllable via, say, i2c. For these reasons there is no
> >> real Linux bus for DSI and DBI and thus the DSI and DBI devices are
> >> either platform devices or i2c devices.
> > 
> > That's something I'm less convinced about, but I don't have a too strong
> > feeling. The best implementation should get to mainline, I won't nack this
> > architecture just for theoretical reasons.
> 
> Ok. I posted a response to your DBI bus patch about the issues I see.

I'll reply in that mail thread then.

> >> DSI Module ID
> >> =============
> >> 
> >> On OMAP4 we have two DSI modules. To configure the clock routing and pin
> >> muxing, we need to know the hardware module ID for the DSI device, i.e.
> >> is this Linux platform device DSI1 or DSI2. The same issue exists with
> >> other SoCs with multiple outputs of the same kind.
> >> 
> >> With non-DT case, we used the platform device's ID directly. With DT,
> >> that doesn't work. I don't currently have a good solution for this, so as
> >> a temporary solution the DSI driver contains a table, from which it can
> >> find the HW module ID by using the device's base address.
> > 
> > You could add two output ports to the DSS, one for each DSI, and link the
> > DSI modules to the DSS output ports in DT. That would represent the
> > hardware topology, and would allow the DSI driver to know its ID based on
> > the DSS output port it's connected to. It's still a bit hackish in the
> > sense that the DSI driver will use information provided by the DSS (the
> > output port number), but not more than the current method.
> 
> Hmm, yep. That's kind of the same as having an explicit 'module-id'
> property in the DSI node. I had implemented that solution at some point,
> but considered it too ugly. But I agree that deducing the module-id from
> the DSS output port is a bit cleaner, as it doesn't need any special
> properties. And it's maybe also better than the address table I have
> now, as the address table requires special code for each SoC.
> 
> I have to try the V4L2 ports to understand fully how to use them.

Feel free to ask questions :-)

> In the end, I hope to get rid of the module-id totally. It's really not
> a DSI-thing at all. The DSI hardware does not use the module-id for
> anything, it's more about how the DSI module is glued in the DSS/SoC.
> 
> >> I have some ideas how to deduce the DSS version by poking to certain DSS
> >> registers, but it is not yet tested so I don't know if it will work.
> > 
> > That might be a stupid question, but can't you just encode the version in
> > the compatible string of the DSS DT node (the one currently compatible
> > with "ti,omap[34]-dss") ?
> 
> That would require having separate DT files for each revision. For
> example, we have Beagle boards with different OMAP reversions.
> 
> It's fine to have the version encoded in the compatible string for major
> versions, but having all minor revisions encoded there could result in a
> mess.

Obviously if you can detect the version at runtime that would be best. Let's 
see if that can be done and then decide on what solution to implement.

> > Version information might also need to be split/duplicated in several of
> > the DSS DT nodes. A quick grep through the driver source code shows that
> > the version is used by the submodules to infer SoC glue information. For
> > instance dsi_get_channel() uses the version to find the DSI module
> > channel ID. That information could possibly be retrieved from the links
> > between the DSS DT nodes.
> 
> Hmm, yes. Well. The DISPC has multiple output channels: LCD, LCD2, LCD3,
> TV (depending on the SoC). These outputs go to encoders, and the routing
> can be configured. If we consider only DSI encoders on OMAP4, the LCD2
> output can be configured to go to DSI1 or DSI2 modules. LCD1 output can
> be configured to go to DSI1 (but not to DSI2).
> 
> Because the routing has restrictions like mentioned above, it's somewhat
> difficult to allocate the DISPC output channels during runtime in a
> totally dynamic manner. Say, if we happened to allocate LCD2 for DSI1,
> and later we'd want to use DSI2, there would be no DISPC output to use.
> 
> That's why we currently have them hardcoded in the driver, and it works
> ok in all the use cases we have now. However, some board could need to
> setup the channels in some other way for some particular use case.
> 
> So, I'm not totally comfortable with hardcoding the DISPC output - DSS
> encoder connections in the DT data. While it'd work for most cases, it
> doesn't work for all.

Encoding them in the device tree, in the driver(s), or computing them at 
runtime in the kernel are all suboptimal solutions. If the connections are 
configurable we want to expose that to userspace and let userspace configure 
the device. That's not possible yet due to API limitations, so we need to 
handle the situation on the kernel side. I'm thus fine with hardcoding this in 
the driver for now, DT should not encode more than possible connections, it 
shouldn't cary the default configuration.

> Then again, if the connections in the DT data would be considered more
> like a default set of connections, and they could be changed later from
> the kernel/userspace, then it'd be fine.
> 
> >> Some of the DSS modules are actually a combination of multiple smaller
> >> modules. For example, the DSI module contains DSI protocol, DSI PHY and
> >> DSI PLL modules, each in their own address space. These could perhaps be
> >> presented as separate DT nodes and Linux devices, but I am not sure if
> >> that is a good approach or not.
> > 
> > What are the chances that one of those block will be upgraded and/or
> > replaced independently of the others in the future (I know it's a tricky
> > question) ? It might not be worth it going to a too fine-grained approach
> > at the moment, but we need to make sure that the DT bindings will allow
> > an easy path forward if needed.
> 
> For DSI, I believe the chances are quite small. But for HDMI, we already
> have this case for OMAP4 and OMAP5, and we're currently working on
> splitting the HDMI core, PHY and PLL properly. I think it makes sense to
> do the same for DSI also at the same time, especially as the PLL for DSI
> and HDMI is the same (afaik).

Yes, then it's a good idea.

> >> If we shouldn't add the bindings as unstable, when should the bindings be
> >> added? Wait until CDF is in the mainline, and use that?
> > 
> > What about using the CDF bindings, without waiting for CDF to be in
> > mainline ? I believe the bindings should be upstreamed as unstable to
> > start with anyway.
>
> Yes, I think that makes sense. And that's what I've been aiming at. I'm
> just missing the ports-stuff.
> 
> Then again, I see opinions that the old bindings should be supported (e.g.
> the mails with Tony in this same thread). If so, using CDF bindings without
> CDF being in the mainline is a bit risky, as the bindings could well change.

But it's less risky than using custom bindings, isn't it ? :-)

-- 
Regards,

Laurent Pinchart

--nextPart7789301.B9XXDaW6Jh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABAgAGBQJSJcBwAAoJEIkPb2GL7hl16aEIALHvfh3JvvFzvdWZbzGJQbiz
JS352q1h+smnWdEXp9+sg/qVNIEPXDojiBY9l9knIMtqB8SY7YaBsuJ15UffOA7n
uUVh9NC+1jp1a89DYmyHP+kWtR+PjyBYwwQioOgDUsvLOwwnvNz5/nhX5Hh6IdSu
1TuD3WYfqzhH8ZhWw7PymoVKhXoukg6uGBdE0OXGM087unVU/TBb/hP2a7iNoUyk
JRuXPJkNjW0niKSitSaS7n1eWI9gbfAnHyOwutJwhk2F11nOXlkmN2q/whU678kb
6CfDymGgRv2X9RcFwAaZZRmu4+WLn1xkVutxaCCIINNk9vtyxtr5OoWd/yRVUeM=
=lw0j
-----END PGP SIGNATURE-----

--nextPart7789301.B9XXDaW6Jh--

