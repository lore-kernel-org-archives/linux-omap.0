From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/i2c: tda998x: Register ASoC hdmi-codec and add
 audio DT binding
Date: Mon, 8 Aug 2016 15:15:42 +0300
Message-ID: <fef3d781-3a97-e1ab-6faf-6fac910dee2d@ti.com>
References: <cover.1470129989.git.jsarha@ti.com>
 <ce10548e1c28270d80ee99a525e117d0d25f5656.1470129989.git.jsarha@ti.com>
 <20160804140712.GO5783@n2100.arm.linux.org.uk>
 <3a3dcfa4-cec8-53f8-eddb-9a0e04c10ac9@ti.com>
 <20160805164845.GP5783@n2100.arm.linux.org.uk>
 <20160805165959.GA10383@sirena.org.uk>
 <20160805170450.GQ5783@n2100.arm.linux.org.uk>
 <20160805175908.GC10383@sirena.org.uk>
 <20160805221944.GR5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160805221944.GR5783-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/06/16 01:19, Russell King - ARM Linux wrote:
>> > It'll pick up that as the DT device to hang things off which I'd expect
>> > to be the desired outcome given that this is a very similar situation to
>> > the MFD situation.  I've not been following the full thread so there is
>> > probably context I'm missing here...
> Okay, and that sounds to me like a very reasonable thing to want to
> happen - so that the audio side can be clearly identified as being
> coupled with the video side.
> 
> So, I'm not seeing a problem with my suggestion... I'm actually more
> reasons why it's a good thing to want.


Ok, so getting back to this comment:

>> +	priv->audio_pdev = platform_device_register_data(
>> > +		dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
>> > +		&codec_data, sizeof(codec_data));
> I'd much prefer that this was a child of the I2C device, which will
> show the relationship between this virtual platform device and the
> device which it's associated with.  That can be done via
> platform_device_register_full().

The platform_device_register_data() sets the parent of the registered
platform device according to the first parameter, the tda998x i2c-client
in this case. Is there some reason why I should use
platform_device_register_full() and should I set parent to something
else than the tda998x i2c device?

BR,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
