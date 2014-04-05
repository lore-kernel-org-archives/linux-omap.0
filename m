From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 0/5] tsc2005 DT binding
Date: Sun,  6 Apr 2014 00:26:56 +0200
Message-ID: <1396736821-14395-1-git-send-email-sre@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This adds device tree support for the tsc2005 touchscreen
controller, which is currently only used by the Nokia N900
board.

The patch does not update the reset pin handling for platform
data based probe to avoid merge conflicts. The n900 platform
code will be removed in the near future (3.16?) and the driver
can be simplified once that has happened.

Changes since v1 [0]:
 * rename "reset-gpio" to "reset-gpios", so that the code can easily
   switch to the gpiod interface (once the boardcode is gone).
 * rename ti,fuzz-* and ti,max-* to touchscreen-fuzz-* and
   touchscreen-size-* and specify them as common touchscreen binding.
 * implement input_parse_touchscreen_of_params(), which parses the
   common touchscreen binding.

[0] https://lkml.org/lkml/2013/12/5/607

-- Sebastian

Sebastian Reichel (5):
  Input: add common DT binding for touchscreens
  Input: tsc2005: use dev_err for error messages
  Input: tsc2005: convert driver to use devm_*
  Input: tsc2005: add DT support
  Documentation: dt: Document TSC2005 DT binding

 .../bindings/input/touchscreen/touchscreen.txt     |   9 ++
 .../bindings/input/touchscreen/tsc2005.txt         |  39 +++++++
 drivers/input/input.c                              |  34 ++++++
 drivers/input/touchscreen/tsc2005.c                | 130 ++++++++++++++-------
 include/linux/input.h                              |   8 ++
 5 files changed, 179 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt

-- 
1.9.1

