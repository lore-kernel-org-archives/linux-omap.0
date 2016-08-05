From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/i2c: tda998x: Register ASoC hdmi-codec and add
 audio DT binding
Date: Fri, 5 Aug 2016 18:04:50 +0100
Message-ID: <20160805170450.GQ5783@n2100.arm.linux.org.uk>
References: <cover.1470129989.git.jsarha@ti.com>
 <ce10548e1c28270d80ee99a525e117d0d25f5656.1470129989.git.jsarha@ti.com>
 <20160804140712.GO5783@n2100.arm.linux.org.uk>
 <3a3dcfa4-cec8-53f8-eddb-9a0e04c10ac9@ti.com>
 <20160805164845.GP5783@n2100.arm.linux.org.uk>
 <20160805165959.GA10383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160805165959.GA10383-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 05, 2016 at 05:59:59PM +0100, Mark Brown wrote:
> On Fri, Aug 05, 2016 at 05:48:45PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Aug 05, 2016 at 12:02:39PM +0300, Jyri Sarha wrote:
> 
> > > That may be a problem. The ASoC card device tree binding current looks
> > > for the ASoC DAI's parent's of-node if it can not find the node for the
> > > DAI-device itself.
> 
> > I don't follow.  The "parent" of this audio_pdev device above is
> > the "platform" device - /sys/devices/platform.  If ASoC is
> > referencing the parent of the above platform device for some
> > reason, it's probably not going to get anything useful from such
> > an attempt.
> 
> > Any other ASoC codec driver where the codec platform device was
> > declared with a NULL parent pointer also ends up as a child of
> > that same location.
> 
> > I'd _really_ be surprised if ASoC is even doing what you describe,
> > because such an action is totally illogical (as can be seen from
> > my description above.)
> 
> We do have some stuff in there in order to handle MFDs - they'll
> instantiate a Linux-internal virtual platform device as a child of the
> DT device that represents the device as a whole.  We're definitely not
> expecting to find anything for parentless platform devices though, it's
> only done if the ASoC level device has no of_node and the parent does.

And if we make the hdmi-codec device a child of the I2C device which
does have an of-node, what will happen?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
