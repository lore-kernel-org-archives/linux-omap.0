From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Tue, 11 Jun 2013 13:30:46 +0200
Message-ID: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I believe the whole thing should go via the MFD tree. It touches also
input & iio subsystem. I collected ACKs where I got some in the meantime.

I added Lee Jones because I hear no sign of life from Samuel.

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://breakpoint.cc/bigeasy/linux tags/am335x_tsc-adc

for you to fetch changes up to fe12425dd7e93db2dfdfa4eb9289036100cb0338:

  iio/ti_am335x_adc: check if we found the value (2013-06-11 13:11:35 +0200)

----------------------------------------------------------------
A complete refurbished series inclunding:
- DT support for the MFD, TSC and ADC driver & platform device support,
  which has no users, has been killed.
- iio_map from last series is gone and replaced by proper nodes in the
  device tree.
- suspend fixes which means correct data structs are taken and no
  interrupt storm
- fifo split which should problem with TSC & ADC beeing used at the same
  time
- The ADC channels are now checked before blindly applied. That means the
  touch part reads X, Y and Z coordinates and does not mix them up. Same
  goes for the IIO ADC driver.
- The IIO ADC driver now creates files named in_voltageX_raw where X
  represents the ADC line instead of a number starting at 0. A read from
  this file can return -EBUSY in case touch is busy and the ADC didn't
  collect a value.

----------------------------------------------------------------
Pantelis Antoniou (2):
      iio/ti_tscadc: provide datasheet_name and scan_type
      mfd/ti_tscadc: deal with partial activation

Patil, Rachna (7):
      input/ti_am33x_tsc: Step enable bits made configurable
      input/ti_am33x_tsc: Order of TSC wires, made configurable
      input/ti_am33x_tsc: remove unwanted fifo flush
      input/ti_am33x_tsc: Add DT support
      iio/ti_am335x_adc: Add DT support
      mfd/ti_am335x_tscadc: Add DT support
      arm/am33xx: add TSC/ADC mfd device support

Sebastian Andrzej Siewior (13):
      mfd/ti_am335x_tscadc: remove regmap
      mfd & input & iio/ti_am335x_adc: use one structure for ti_tscadc_dev
      input/ti_am33x_tsc: remove platform_data support
      iio/ti_am335x_adc: remove platform_data support
      mfd/ti_am335x_tscadc: remove platform_data support
      input & mfd: ti_am335x_tsc remove remaining platform data pieces
      mfd & input/ti_am335x_tsc: rename device from tsc to TI-am335x-tsc
      mfd & iio/ti_am335x_adc: rename device from tiadc to TI-am335x-adc
      input/ti_am335x_adc: use only FIFO0 and clean up a little
      input/ti_am335x_tsc: ACK the HW_PEN irq in ISR
      input/ti_am335x_tsc: return IRQ_NONE if there was no IRQ for us
      iio/ti_am335x_adc: Allow to specify input line
      iio/ti_am335x_adc: check if we found the value

 .../bindings/input/touchscreen/ti-tsc-adc.txt      |   44 +++
 arch/arm/boot/dts/am335x-evm.dts                   |   14 +
 arch/arm/boot/dts/am33xx.dtsi                      |   18 ++
 drivers/iio/adc/ti_am335x_adc.c                    |  132 ++++++---
 drivers/input/touchscreen/ti_am335x_tsc.c          |  288 ++++++++++++++------
 drivers/mfd/ti_am335x_tscadc.c                     |  133 ++++++---
 include/linux/input/ti_am335x_tsc.h                |   23 --
 include/linux/mfd/ti_am335x_tscadc.h               |   43 +--
 include/linux/platform_data/ti_am335x_adc.h        |   14 -
 9 files changed, 494 insertions(+), 215 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
 delete mode 100644 include/linux/input/ti_am335x_tsc.h
 delete mode 100644 include/linux/platform_data/ti_am335x_adc.h

Sebastian
