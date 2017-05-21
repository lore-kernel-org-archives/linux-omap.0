From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 0/3] misc: new serdev based drivers for w2sg00x4 GPS module and w2cbw003 wifi/bluetooth
Date: Sun, 21 May 2017 12:44:01 +0200
Message-ID: <cover.1495363443.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, "H. Nikolaus Schaller" <hns@goldelico.com>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Since our proposed API was not acceptable and the new serdev API has arrived in 4.11 kernels,
we finally took the challenge to update the w2sg and w2cbw drivers to use the serdev API.

The approach is to write a "man in the middle" driver which is on one side a serdev client
which directly controls the UART where the device is connected to and on the other side
presents a new tty port so that user-space software can talk to the chips as if they would
directly talk to the UART of the SoC (e.g. ttyO1). This is similar to connecting to a remote
serial device e.g. through USB (ttyACM) or Bluetooth UART profiles.

For example gpsd or hciattach expect a /dev/tty they can control (flow control, baud rate
etc.).

Here is the result of our first hack which is working as a demo on GTA04 devices (and the
w2cbw driver can also be used to control a GTA04 variant with WL1837).

Since it is just a demo hack, the code is not yet cleaned up, nor does it completely pass
check-patch, nor follows 100% the coding styles. And certainly has some bugs.

The most significant issue is that calling tty_port_register_device() inside of the
serdev probe() function makes the serdev probe() function to be entered a second
time. This does not lead to big problems since we currently have minor = 0
and this makes the second call assume the device is not available.

But we have no idea why this happens and how it can be prevented.

Another observation is that the man-in-the-middle approach means copying
and double buffering the data. This seems to add some delay, especially if
we run the w2cbw003 bluetooth interface with its max. speed of 3 Mbit/s.

So this is still work in progress and more a demo than quite some work away
ffrom upstreaming. Therefore, we are asking for comments if the general
direction is ok and a polished driver would be acceptable. And if there are
solutions for the duplicate probe() and double-buffering delays.


H. Nikolaus Schaller (3):
  DTS: gta04: add serdev nodes for w2sg00x4, w2cbw etc.
  misc: Add w2sg0004 (gps receiver) power control driver
  misc: Add w2cbw003 (wifi/bluetooth) power control driver

 .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  20 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  18 +
 drivers/misc/Kconfig                               |  23 +
 drivers/misc/Makefile                              |   2 +
 drivers/misc/w2cbw003-bluetooth.c                  | 390 +++++++++++++
 drivers/misc/w2sg0004.c                            | 646 +++++++++++++++++++++
 include/linux/w2sg0004.h                           |  27 +
 8 files changed, 1127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
 create mode 100644 drivers/misc/w2cbw003-bluetooth.c
 create mode 100644 drivers/misc/w2sg0004.c
 create mode 100644 include/linux/w2sg0004.h

-- 
2.12.2
