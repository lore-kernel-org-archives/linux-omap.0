From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v8 0/8] drivers: touchscreen: tsc2007 and ads7846/tsc2046 improvements (use common touchscreen bindings, pre-calibration, spi fix and provide iio raw values)
Date: Tue, 22 Nov 2016 15:02:27 +0100
Message-ID: <cover.1479823354.git.hns@goldelico.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Changes V8:
* fix compilation for CONFIG_IIO=m (reported by Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
* add some more Reviewed-by: and Acked-by:
* mutiple improvements suggested by Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
** drop patch "send pendown and penup only once" (input core does take care of it now)
** remove not necessary EXPORT_SYMBOL
** remove explicit file names from comment header
** move tsc2007_iio_configure() to the end of the probe process and simplify the error path again
** remove unnecessary input_unregister_device() 
** improvement for compilation with CONFIG_IIO=m and CONFIG_TSC2007=y

2016-11-11 20:02:11: Changes V7:
* rearranged the include files (asked for by Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
* forward reference struct iio_dev * instead of condition in tsc2007.h (asked for by Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
* add some Acked-by:

2016-10-27 10:44:29: Changes V6:
* iio patch (no changes elsewhere)
	- tsc2007_iio: fix a missing return 0 for non-iio case (found by kbuid test robot)
	- tsc2007_core: group error return paths so that tsc2007_iio_unconfigure is called at only one place
	- tsc2007_iio: fix copyright (this file is 100% original work)

2016-10-25 21:26:46: Changes V5:
* ads7846: remove an empty line (suggested by Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>)
* ads7846: remove MODULE_ALIAS for SPI (suggested by Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>)
* tsc2007: fix a bug from swapping patch 3/n and patch 4/n (found by kbuild test robot)
* refactored tsc2007 into tsc2007_core and tsc2007_iio (asked for by Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)

2016-10-17 16:00:02: Changes V4:
* fix a merge/squash issue resulting in a non-bisectable patch set (suggested by kbuid test robot)
* remove some unnecessary #include (suggested by Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
* make the iio extension depend on CONFIG_IIO rather than selecting it (suggested by Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>)
* swapped patch 3/n and patch 4/n to remove internal dependency

2016-09-23 14:41:23: Changes V3:
* fix an issue with swapping
* remove hard clipping to min/max rectangle - some systems expect to handle negative coordinates
* make use of commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted / swapped axes")

2015-11-13 21:36:07: Changes V2:
* add a patch to make drivers still recognise the old "ti,swap-xy" property (suggested by Rob Herring)

2015-11-06 16:14:53: V1: This patch series improves the drivers for the tsc2007 and
ads7846/tsc2046 touchscreen controllers which are e.g. used by the GTA04
OpenPandora and Pyra devices.

New common bindings have been defined by
commit b98abe52fa8e ("Input: add common DT binding for touchscreens"):

	Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

which also defines a helper function to parse the DT. These new parameters
allow to specify the fuzz factors (jitter suppression), inversion of x or y axis and
swapping of x and y to achieve inversion and rotation so that the touch
coordinate axes match the natural orientation of the display panel.

Another improvement is to better use the min/max ADC values and
scale to the screen size as defined by the DT. This allows to coarsely
calibrate the touch to match the LCD to which it is glued on so that the
touch can quite precisely be operated before any user-space fine-calibration
can be (and needs to be) started.

For the adc7846 we fix an issue with the spi module table.

Finally we add an iio interface for the AUX and temperature ADC channels of
the tsc2007 and also provide the touch screen raw values. This allows to read
an optional ambient light sensor installed on the gta04 board and improves
calibration and hardware monitoring.


H. Nikolaus Schaller (8):
  drivers:input:tsc2007: add new common binding names, pre-calibration,
    flipping and rotation
  drivers:input:tsc2007: check for presence and power down tsc2007
    during probe
  drivers:input:tsc2007: add iio interface to read external ADC input
    and temperature
  DT:omap3+tsc2007: use new common touchscreen bindings
  drivers:input:ads7846(+tsc2046): add new common binding names,
    pre-calibration and flipping
  dt-bindings: input: move ads7846 bindings to touchscreen subdirectory
  drivers:input:ads7846(+tsc2046): fix spi module table
  DT:omap3+ads7846: use new common touchscreen bindings

 .../bindings/input/{ => touchscreen}/ads7846.txt   |   9 +-
 .../bindings/input/touchscreen/tsc2007.txt         |  20 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  25 ++-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  17 +-
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |   3 +-
 drivers/input/touchscreen/Makefile                 |   7 +
 drivers/input/touchscreen/ads7846.c                |  71 ++++++--
 drivers/input/touchscreen/tsc2007.h                | 116 ++++++++++++
 .../touchscreen/{tsc2007.c => tsc2007_core.c}      | 201 ++++++++++++---------
 drivers/input/touchscreen/tsc2007_iio.c            | 150 +++++++++++++++
 include/linux/i2c/tsc2007.h                        |   8 +
 12 files changed, 515 insertions(+), 114 deletions(-)
 rename Documentation/devicetree/bindings/input/{ => touchscreen}/ads7846.txt (90%)
 create mode 100644 drivers/input/touchscreen/tsc2007.h
 rename drivers/input/touchscreen/{tsc2007.c => tsc2007_core.c} (74%)
 create mode 100644 drivers/input/touchscreen/tsc2007_iio.c

-- 
2.7.3
