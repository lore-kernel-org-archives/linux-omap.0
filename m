From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv2 0/4] n_gsm serdev support and mfd driver for droid4 modem
Date: Sun,  9 Feb 2020 20:01:02 -0800
Message-ID: <20200210040107.10306-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>, Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here's updated version of n_gsm serdev support with related MFD
driver for the modem found on Motorola Mapphone phones and tablets
like droid4.

This series only adds basic character device support for the MFD
driver, other serdev consumer drivers for specific devices will be
posted separately.

The patches are against v5.6-rc1, please review and test,

Regards,

Tony


Changes since v1:

- Simplified usage and got rid of few pointless inline functions
- Added consumer MFD driver, devicetree binding, and dts changes

Tony Lindgren (4):
  tty: n_gsm: Add support for serdev drivers
  mfd: motmdm: Add Motorola TS 27.010 serdev modem driver for droid4
  dt-bindings: mfd: motmdm: Add binding for motorola-mdm
  ARM: dts: omap4-droid4: Enable basic modem support

 .../mfd/motorola,mapphone-mdm6600.yaml        |   37 +
 .../boot/dts/motorola-mapphone-common.dtsi    |    6 +
 drivers/mfd/Kconfig                           |    8 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/motorola-mdm.c                    | 1204 +++++++++++++++++
 drivers/tty/n_gsm.c                           |  372 +++++
 include/linux/serdev-gsm.h                    |  168 +++
 7 files changed, 1796 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,mapphone-mdm6600.yaml
 create mode 100644 drivers/mfd/motorola-mdm.c
 create mode 100644 include/linux/serdev-gsm.h

-- 
2.25.0
