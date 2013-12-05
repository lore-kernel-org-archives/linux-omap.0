From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 0/2] tsc2005 DT binding
Date: Fri,  6 Dec 2013 00:09:37 +0100
Message-ID: <1386284979-9680-1-git-send-email-sre@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This adds device tree support for the tsc2005 touchscreen
controller, which is currently only used by the Nokia N900
board.

The patch does not update the reset pin handling for platform
data based probe to avoid merge conflicts (Tony will remove
the Nokia N900 boardcode in 3.14). The platform data based
probe can be removed once the N900 boardcode is gone.

-- Sebastian

Sebastian Reichel (2):
  Input: tsc2005: add DT support
  Documentation: dt: Document TSC2005 DT binding

 .../bindings/input/touchscreen/tsc2005.txt         | 49 +++++++++++
 drivers/input/touchscreen/tsc2005.c                | 95 ++++++++++++++++++----
 2 files changed, 127 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2005.txt

-- 
1.8.4.3

