From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] Motorola Droid 4 Audio Support
Date: Sat, 8 Jul 2017 22:33:53 -0700
Message-ID: <20170709053353.GP3730@atomide.com>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170708052753.GM3730@atomide.com>
 <20170708113405.cgigekmytv7yzzk4@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170708113405.cgigekmytv7yzzk4@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170708 04:34]:
> Hi,
> 
> On Fri, Jul 07, 2017 at 10:27:53PM -0700, Tony Lindgren wrote:
> > * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170707 09:43]:
> > > I got working sound on Droid 4 with mainline \o/. The codec is
> > > currently missing support for detecting if something has been
> > > plugged into the 3.5mm connector, since that seems to require
> > > some closed source firmware and needs further investigation. I
> > > think this can be added later.
> > 
> > Hey that's great! I'll give it a try this weekend.. Does that mean
> > that 3G voice calls work too now or is something more needed there?
> 
> I added some text about that in the 3rd patch. Basically the codec driver
> is ready (maybe a few quirks will be needed, though), but the soundcard
> driver is not. It currently assumes CPU <-> Voice Codec, but
> actually its a network of CPU, Voice Codec, Modem(s?) and Bluetooth.

OK

> > For the CPCAP PMIC macro interrupts I think it's best to set up
> > a separate driver as it seems separate from the core CPCAP
> > functionality. So I think we can just move the unused "cpcap-m2"
> > IRQ banks out of motorola-cpcap.c and put them into a separate child
> > driver that loads it's firmware on init and provides interrupts for
> > the 3.5mm connector.
> 
> I also think the macro block fw handling should not be handled in
> the driver for the audio codec. IIRC it is also used to provide a
> blink feature for the status LEDs. OTOH some of the registers of the
> audio-codec are also used for 3.5mm detection. I also did not yet look
> into the details of this one.

Also the battery driver has three mystery interrupts coming from the
macro. At least the cycle count is missing so maybe that too comes
from the macro.

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
