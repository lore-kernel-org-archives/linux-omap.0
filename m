From: Sebastian Reichel <sre@kernel.org>
Subject: [RFC 0/7] Nokia N9xx bluetooth driver
Date: Sat, 13 Aug 2016 05:14:31 +0200
Message-ID: <1471058078-5579-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Ville Tervo <ville.tervo@iki.fi>, =?UTF-8?q?Filip=20Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series (based von 4.8-rc1) adds support for bluetooth on the Nokia
N9xx devices. It has been tested on the Nokia N950, where it works
correctly. On Nokia N900 it currently fails during negotiation
(probably related to slightly incorrect serial settings/timings).
The N900's bcm2048 correctly answeres to alive check even before
negotiation (on N950 it does not work before negotiation), but replies
with an Hardware error event to the negotiation packet.

Apart from N900 support there are still two "features" missing in the
driver:

1. To save energy the bluetooth module can be put into sleep mode via a
   GPIO. This gpio should be enabled before sending data via UART and
   disabled once the transmission is done. I currently just keep the
   GPIO always enabled.
2. It would be nice to have a bluetooth device exposed by the kernel
   automatically without having to setup the tty disector first for
   proper configurationless out of the box support. I could not find
   a nice way to do this from the kernel, though.

On N950 the driver works with omap-serial and omap8250-serial drivers.

You can also find this series in the following branch:
https://git.kernel.org/cgit/linux/kernel/git/sre/linux-n900.git/log/?h=nokia-bluetooth

-- Sebastian

NeilBrown (1):
  tty: add support for "tty slave" devices

Sebastian Reichel (6):
  tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init
  dt: bindings: Add nokia-bluetooth
  Bluetooth: hci_uart: Add support for word alignment
  Bluetooth: hci_nokia: Introduce new driver
  ARM: dts: OMAP3-N900: Add bluetooth
  ARM: dts: OMAP3-N950: Add bluetooth

 .../devicetree/bindings/net/nokia-bluetooth.txt    |  43 ++
 Documentation/devicetree/bindings/serial/8250.txt  |   4 +
 arch/arm/boot/dts/omap3-n900.dts                   |  22 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  34 +
 drivers/bluetooth/Kconfig                          |  10 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/hci_h4.c                         |  10 +
 drivers/bluetooth/hci_ldisc.c                      |   6 +
 drivers/bluetooth/hci_nokia.c                      | 734 +++++++++++++++++++++
 drivers/bluetooth/hci_nokia.h                      | 140 ++++
 drivers/bluetooth/hci_uart.h                       |   9 +-
 drivers/tty/serial/omap-serial.c                   |   3 +
 drivers/tty/tty_io.c                               |   6 +
 13 files changed, 1020 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
 create mode 100644 drivers/bluetooth/hci_nokia.c
 create mode 100644 drivers/bluetooth/hci_nokia.h

-- 
2.8.1
