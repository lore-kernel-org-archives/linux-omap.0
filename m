From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Tue, 25 Feb 2014 20:56:34 +0000
Message-ID: <20140225205634.GZ27282@n2100.arm.linux.org.uk>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch> <20140225123921.GY27282@n2100.arm.linux.org.uk> <20140225134139.GA23898@earth.universe> <2364124.7r818M0xAj@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50634 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752660AbaBYU4u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Feb 2014 15:56:50 -0500
Content-Disposition: inline
In-Reply-To: <2364124.7r818M0xAj@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ash Charles <ash@gumstix.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Feb 25, 2014 at 05:51:21PM +0100, Laurent Pinchart wrote:
> I don't think all physical connectors require a DT binding per-se, but they 
> need to be represented in DT as they're part of the hardware. We could push 
> connector-related information to the nodes of all chips that have interfaces 
> wired directly to connectors, but that would result in more complex DT 
> bindings and core. I believe modeling connectors using separate DT nodes is be 
> best, and would allow easier support for more complex connectors that carry 
> multiple streams/signals in parallel (video, audio, DDC, ...).

There is some sanity to representing physical connectors in DT, but it's
not for the reason you mention above.  If you consider that it's possible
on PCs to find out what connectors are on the motherboard and where they
are located, this is very useful information to be stored and presented.

However, the idea that you combine streams at connectors is not a
universal truth, and is certainly false for HDMI.  HDMI combines video
and audio at the encoder stage, not at the connector stage, and many
HDMI encoders will provide everything required for driving the connector.

However, my major objection here is not really that: my major objection
is using something as generic as "hdmi-connector" as a compatible string.
The reason is that we have to remember that DT is not just "a Linux thing".
It's /supposed/ to be an OS independent representation of the hardware.

If we invent something generic called a "hdmi-connector" then we had
better first do a thorough search to make sure we're not trampling on
anything which is standardized or becoming a standard - if there is,
we should work with them - and if that's not possible, then we need to
distingush ourselves from them.

What we can't do is go around inventing generic stuff without having our
eyes wide open.

So, here's a good question to probe how far this has been thought through
already: what has been done to discuss the creation of this generic
"hdmi-connector" thing with the various parties who are interested in
HDMI outputs under DRM using device tree?

If that hasn't happened, that's quite a failing - it means that we're
on the road to having two _implementation specific_ DT representations
for the same hardware - one for fbdev and one for DRM.  That really
isn't on.

Yes, it then opens a pandora's box of problems about how we determine
whether DRM or fbdev should bind to the DT nodes, but that should be
an entirely separate issue (and, ideally of course, both should use
the same sub-drivers for the components.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
