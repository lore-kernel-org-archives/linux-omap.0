From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH RFC v5 4/8] drm/i2c: tda998x: Add support of a DT graph
 of ports
Date: Fri, 26 Feb 2016 00:43:11 +0000
Message-ID: <20160226004311.GM5783@n2100.arm.linux.org.uk>
References: <cover.1455720381.git.jsarha@ti.com>
 <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
 <20160218143530.GB9654@rob-hp-laptop>
 <56CF04DA.8080905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56CF04DA.8080905-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 25, 2016 at 03:42:50PM +0200, Jyri Sarha wrote:
> On 02/18/16 16:35, Rob Herring wrote:
> >This should be implied from the port unit address. In other words,
> >port@0 is defined to be the rgb port. Now, if this is one of several
> >modes for the video port, then that is a different story.
> >
> 
> Do you suggest that also the audio i2s and s/p-dif port-types should be
> coded in the port unit addresses? Something like: port@0 is always rgb,
> port@1 is i2s, and port@2 is spdif?

For the audio inputs, the port address corresponds to the input pin.
TDA998x devices can have multiple streams routed to the pins, and can
select between them.

For example, there may be four I2S data pins and one I2S clock pin.
When using stereo, you can select which of the four I2S data pins
carries the audio data.

When using SPDIF, there may be two SPDIF inputs, and you can select
which SPDIF input is used.

So, "reg" may not be an address in terms of a CPU visible address, but
it's an address as far as selecting the appropriate input - and it
fits in with the requirements of ePAPR, which are that if you have
a unit-address (which is required to distinguish different port nodes)
then you must have a matching "reg" property.

I don't particularly like the video node using the RGB routing register
value either for the reg property, but I've kept quiet because I have
nothing to offer there: again, this comes down to ePAPR requirements
and the need to specify multiple "port { }" nodes.  You can't have two
"port { }" nodes without using a unit-address, and we'd need to chose
a unit-address for it which doesn't conflict with the audio ports...
so there's a kind of logic to using the RGB routing value, which will
never conflict.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
