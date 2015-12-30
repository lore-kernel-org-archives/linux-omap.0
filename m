From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 1/3] devicetree/bindings: add reset-gpios and
 vcc-supply for panel-dpi
Date: Wed, 30 Dec 2015 11:29:22 +0100
Message-ID: <CAMuHMdUJPUeyhtM3=S4dOgevpnyd0TgkJy7QchPewO4KOxsWvA@mail.gmail.com>
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1450610002-10531-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<20151229205458.GA31241@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151229205458.GA31241@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 29, 2015 at 9:54 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sun, Dec 20, 2015 at 12:13:20PM +0100, Uwe Kleine-K=C3=B6nig wrote=
:
>> Some displays have a reset input and/or need a regulator to function
>> properly. Allow to specify them for panel-dpi devices.
>>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org=
>
>> ---
>>  Documentation/devicetree/bindings/display/panel/panel-dpi.txt | 2 +=
+
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-d=
pi.txt b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
>> index 216c894d4f99..b52ac52757df 100644
>> --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
>> +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
>> @@ -7,6 +7,8 @@ Required properties:
>>  Optional properties:
>>  - label: a symbolic name for the panel
>>  - enable-gpios: panel enable gpio
>> +- reset-gpios: GPIO to control the RESET pin
>
> The problem with this in a generic binding is what if the panel has
> ordering requirements like enable gpio has to be inactive when reset
> is deasserted?
>
>> +- vcc-supply: phandle of regulator that will be used to enable powe=
r to the display
>
> What if there are 2 supplies?

So it should be "vcc-supplies". Most properties containing phandles use=
 plural
naming, even if Linux supports a single phandle only (e.g. "power-domai=
ns").
You also may want to add an optional "vcc-supply-names" property to
differentiate.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
