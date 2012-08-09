From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 04/11] MFD: twl4030-audio: Add DT support
Date: Thu, 09 Aug 2012 13:18:50 +0300
Message-ID: <50238E8A.5030902@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com> <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com> <20120808131356.GS16861@opensource.wolfsonmicro.com> <50226CF4.1010202@ti.com> <20120808135253.GC16861@opensource.wolfsonmicro.com> <502274DA.9020204@ti.com> <20120808141849.GA24328@opensource.wolfsonmicro.com> <50227837.10400@ti.com> <20120808144933.GC24328@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20120808144933.GC24328@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/08/2012 05:49 PM, Mark Brown wrote:
> That makes sense if the GPIO is actively driven, open drain should be
> better here, but it's still a generic thing which it'd be nice to
> extract.

Yes, the idea in it's core is generic, but right now I can not think of=
 a
generic implementation which would work.
In case of twl4030 this is how it looks like:

1. if extmute is requested
 1.1. if GPIO number is not valid
   Use the internal MUTE functionality (HS_POPN_SET register, EXTMUTE b=
it)
 1.2. if GPIO number is valid
   set the GPIO to 1
2. Execute the sequence for the power up/down
3. if extmute is requested
 3.1. if GPIO number is not valid
   Use the internal MUTE functionality (HS_POPN_SET register, EXTMUTE b=
it)
 3.2. if GPIO number is valid
   set the GPIO to 0

=46or other devices it could be simpler:
1. Set GPIO for mute
2. Toggle a bit in the codec
3. Clear the GPIO to unmute

another device would need a sequence in step 2 instead of a single bit =
change.

To cover all of this in a generic way is not that straight forward IMHO=
=2E

> Still, the main thing here was the fact that we should be able to dro=
p
> the flag for the feature in the first place.

Which flag you are referring?
I can (and have dropped) the hs_extmute_disable_level flag, but separat=
e
hs_extmute, hs_extmute_gpio is needed for this device.

hs_extmute tells that the board implemented some sort of HS extmute fun=
ctionality.
hs_extmute_gpio tells if the board is _not_ using the built in function=
ality,
but it is using external GPIO line to enable/disable the mute.

Sure I could do this:
hs_extmute: if only this is set we shall use the chip built in function=
ality
hs_extmute_gpio: if this is set we use the extmute feature but with ext=
ernal
                 GPIO.

But both need to be documented and supported.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
