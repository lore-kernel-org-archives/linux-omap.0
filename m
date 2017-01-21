From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v9 0/8] drivers: touchscreen: tsc2007 and ads7846/tsc2046 improvements (use common touchscreen bindings, pre-calibration, spi fix and provide iio raw values)
Date: Sat, 21 Jan 2017 14:17:39 +0100
Message-ID: <B04BF50A-A54E-4CA2-BB0E-7B547D40403A@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <BB8421B2-6626-4A95-BCD0-25C4CAF30F61@goldelico.com> <17d2c23b-6cbb-d365-71cb-fd4d7af7c958@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <17d2c23b-6cbb-d365-71cb-fd4d7af7c958-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?windows-1252?Q?Mika_Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>, Mauro
List-Id: linux-omap@vger.kernel.org


> Am 21.01.2017 um 14:08 schrieb Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>=20
> On 16/01/17 06:34, H. Nikolaus Schaller wrote:
>> ping
> Always good to say who you are pinging ;)

default =3D Maintainer

Only he/she can finally accept a patch series so I assume he has
to take action if there are no more things to debate.

>  Saves the rest of us wondering
> if we have missing something we should have reviewed.
>=20
> Guessing it's Dmitry in this case!

Yes, you are right. Since there have not been any more comments for a
while, I formally ask to add this to some tree so that it appears in
linux-next for further tests.

BR and thanks,
Nikolaus

>=20
> Jonathan
>>=20
>>> Am 28.12.2016 um 15:53 schrieb H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
>>>=20
>>> Changes V9:
>>> * added explicit CONFIG for TSC2007_IIO and simplified Makefile =
(suggested by Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>)
>>> * make the tsc2007 iio patch the last one in this sequence
>>>=20
>>> 2016-11-22 15:02:42: Changes V8:
>>> * fix compilation for CONFIG_IIO=3Dm (reported by Jonathan Cameron =
<jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
>>> * add some more Reviewed-by: and Acked-by:
>>> * mutiple improvements suggested by Dmitry Torokhov =
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>> ** drop patch "send pendown and penup only once" (input core does =
take care of it now)
>>> ** remove not necessary EXPORT_SYMBOL
>>> ** remove explicit file names from comment header
>>> ** move tsc2007_iio_configure() to the end of the probe process and =
simplify the error path again
>>> ** remove unnecessary input_unregister_device()=20
>>> ** improvement for compilation with CONFIG_IIO=3Dm and =
CONFIG_TSC2007=3Dy
>>>=20
>>> 2016-11-11 20:02:11: Changes V7:
>>> * rearranged the include files (asked for by Jonathan Cameron =
<jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
>>> * forward reference struct iio_dev * instead of condition in =
tsc2007.h (asked for by Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
>>> * add some Acked-by:
>>>=20
>>> 2016-10-27 10:44:29: Changes V6:
>>> * iio patch (no changes elsewhere)
>>> 	- tsc2007_iio: fix a missing return 0 for non-iio case (found by =
kbuid test robot)
>>> 	- tsc2007_core: group error return paths so that =
tsc2007_iio_unconfigure is called at only one place
>>> 	- tsc2007_iio: fix copyright (this file is 100% original work)
>>>=20
>>> 2016-10-25 21:26:46: Changes V5:
>>> * ads7846: remove an empty line (suggested by Andrew F. Davis =
<afd-l0cyMroinI0@public.gmane.org>)
>>> * ads7846: remove MODULE_ALIAS for SPI (suggested by Andrew F. Davis =
<afd-l0cyMroinI0@public.gmane.org>)
>>> * tsc2007: fix a bug from swapping patch 3/n and patch 4/n (found by =
kbuild test robot)
>>> * refactored tsc2007 into tsc2007_core and tsc2007_iio (asked for by =
Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
>>>=20
>>> 2016-10-17 16:00:02: Changes V4:
>>> * fix a merge/squash issue resulting in a non-bisectable patch set =
(suggested by kbuid test robot)
>>> * remove some unnecessary #include (suggested by Jonathan Cameron =
<jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
>>> * make the iio extension depend on CONFIG_IIO rather than selecting =
it (suggested by Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
>>> * swapped patch 3/n and patch 4/n to remove internal dependency
>>>=20
>>> 2016-09-23 14:41:23: Changes V3:
>>> * fix an issue with swapping
>>> * remove hard clipping to min/max rectangle - some systems expect to =
handle negative coordinates
>>> * make use of commit ed7c9870c9bc ("Input: of_touchscreen - add =
support for inverted / swapped axes")
>>>=20
>>> 2015-11-13 21:36:07: Changes V2:
>>> * add a patch to make drivers still recognise the old "ti,swap-xy" =
property (suggested by Rob Herring)
>>>=20
>>> 2015-11-06 16:14:53: V1: This patch series improves the drivers for =
the tsc2007 and
>>> ads7846/tsc2046 touchscreen controllers which are e.g. used by the =
GTA04
>>> OpenPandora and Pyra devices.
>>>=20
>>> New common bindings have been defined by
>>> commit b98abe52fa8e ("Input: add common DT binding for =
touchscreens"):
>>>=20
>>> 	=
Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>>>=20
>>> which also defines a helper function to parse the DT. These new =
parameters
>>> allow to specify the fuzz factors (jitter suppression), inversion of =
x or y axis and
>>> swapping of x and y to achieve inversion and rotation so that the =
touch
>>> coordinate axes match the natural orientation of the display panel.
>>>=20
>>> Another improvement is to better use the min/max ADC values and
>>> scale to the screen size as defined by the DT. This allows to =
coarsely
>>> calibrate the touch to match the LCD to which it is glued on so that =
the
>>> touch can quite precisely be operated before any user-space =
fine-calibration
>>> can be (and needs to be) started.
>>>=20
>>> For the adc7846 we fix an issue with the spi module table.
>>>=20
>>> Finally we add an iio interface for the AUX and temperature ADC =
channels of
>>> the tsc2007 and also provide the touch screen raw values. This =
allows to read
>>> an optional ambient light sensor installed on the gta04 board and =
improves
>>> calibration and hardware monitoring.
>>>=20
>>>=20
>>> H. Nikolaus Schaller (8):
>>> drivers:input:tsc2007: add new common binding names, =
pre-calibration,
>>>   flipping and rotation
>>> drivers:input:tsc2007: check for presence and power down tsc2007
>>>   during probe
>>> DT:omap3+tsc2007: use new common touchscreen bindings
>>> drivers:input:ads7846(+tsc2046): add new common binding names,
>>>   pre-calibration and flipping
>>> dt-bindings: input: move ads7846 bindings to touchscreen =
subdirectory
>>> drivers:input:ads7846(+tsc2046): fix spi module table
>>> DT:omap3+ads7846: use new common touchscreen bindings
>>> drivers:input:tsc2007: add iio interface to read external ADC input
>>>   and temperature
>>>=20
>>> .../bindings/input/{ =3D> touchscreen}/ads7846.txt   |   9 +-
>>> .../bindings/input/touchscreen/tsc2007.txt         |  20 +-
>>> arch/arm/boot/dts/omap3-gta04.dtsi                 |  25 ++-
>>> arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
>>> arch/arm/boot/dts/omap3-pandora-common.dtsi        |  17 +-
>>> .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |   3 +-
>>> drivers/input/touchscreen/Kconfig                  |  10 +
>>> drivers/input/touchscreen/Makefile                 |   2 +
>>> drivers/input/touchscreen/ads7846.c                |  71 ++++++--
>>> drivers/input/touchscreen/tsc2007.h                | 116 =
++++++++++++
>>> .../touchscreen/{tsc2007.c =3D> tsc2007_core.c}      | 201 =
++++++++++++---------
>>> drivers/input/touchscreen/tsc2007_iio.c            | 150 =
+++++++++++++++
>>> include/linux/i2c/tsc2007.h                        |   8 +
>>> 13 files changed, 520 insertions(+), 114 deletions(-)
>>> rename Documentation/devicetree/bindings/input/{ =3D> =
touchscreen}/ads7846.txt (90%)
>>> create mode 100644 drivers/input/touchscreen/tsc2007.h
>>> rename drivers/input/touchscreen/{tsc2007.c =3D> tsc2007_core.c} =
(74%)
>>> create mode 100644 drivers/input/touchscreen/tsc2007_iio.c
>>>=20
>>> --=20
>>> 2.7.3
>>>=20
>>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
