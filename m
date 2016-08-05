From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/i2c: tda998x: Register ASoC hdmi-codec and add
 audio DT binding
Date: Fri, 5 Aug 2016 17:48:45 +0100
Message-ID: <20160805164845.GP5783@n2100.arm.linux.org.uk>
References: <cover.1470129989.git.jsarha@ti.com>
 <ce10548e1c28270d80ee99a525e117d0d25f5656.1470129989.git.jsarha@ti.com>
 <20160804140712.GO5783@n2100.arm.linux.org.uk>
 <3a3dcfa4-cec8-53f8-eddb-9a0e04c10ac9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3a3dcfa4-cec8-53f8-eddb-9a0e04c10ac9-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 05, 2016 at 12:02:39PM +0300, Jyri Sarha wrote:
> On 08/04/16 17:07, Russell King - ARM Linux wrote:
> > On Tue, Aug 02, 2016 at 03:05:08PM +0300, Jyri Sarha wrote:
> >> +	priv->audio_pdev = platform_device_register_data(
> >> +		dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
> >> +		&codec_data, sizeof(codec_data));
> > 
> > I'd much prefer that this was a child of the I2C device, which will
> > show the relationship between this virtual platform device and the
> > device which it's associated with.  That can be done via
> > platform_device_register_full().
> > 
> 
> That may be a problem. The ASoC card device tree binding current looks
> for the ASoC DAI's parent's of-node if it can not find the node for the
> DAI-device itself.

I don't follow.  The "parent" of this audio_pdev device above is
the "platform" device - /sys/devices/platform.  If ASoC is
referencing the parent of the above platform device for some
reason, it's probably not going to get anything useful from such
an attempt.

Any other ASoC codec driver where the codec platform device was
declared with a NULL parent pointer also ends up as a child of
that same location.

I'd _really_ be surprised if ASoC is even doing what you describe,
because such an action is totally illogical (as can be seen from
my description above.)

Moving it under the I2C device means it stays as a platform device,
but the relationship between the platform device and its I2C parent
is properly represented in the tree of devices, and also ensures
that, should PM hooks be added, that the platform device gets
properly ordered wrt the I2C device.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
