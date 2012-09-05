From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] pinctrl: pinctrl-single: new type: pinctrl-single,bits
Date: Wed,  5 Sep 2012 12:01:56 +0300
Message-ID: <1346835718-21325-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

When configuring pinmux with pinctrl-single there could be a case when one
register is used to configure mux for more than one pin.
In this case the use of pinctrl-single,pins is a bit problematic since we can
only update the whole register (restricted by the mask).
In such a situations the pinctrl-single,bits could provide a safe way to handle
the mux.

pinctrl-single,bits takes three parameters: <reg offset, value, sub-mask>
The sub mask is used to mask part of the register to make sure we do not change
bits outside of the scope of this pin.

The first patch in this series is to fix the previous pinctrl-since,pins
implementation because it was not using the mask on the value which could result
changed bits outside of the mask.

Regards,
Peter
---
Peter Ujfalusi (2):
  pinctrl: pinctrl-single: Make sure we do not change bits outside of
    mask
  pinctrl: pinctrl-single: Add pinctrl-single,bits type of mux

 .../devicetree/bindings/pinctrl/pinctrl-single.txt |  9 +++++
 drivers/pinctrl/pinctrl-single.c                   | 42 ++++++++++++++++------
 2 files changed, 41 insertions(+), 10 deletions(-)

-- 
1.7.12
