From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: [PATCH 0/3] Pinctrl-fy OMAP I2C driver
Date: Wed, 19 Sep 2012 19:07:18 +0300
Message-ID: <1348070841-23354-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Shubhrajyoti D <shubhrajyoti@ti.com>, Tony Lindgren <tony@atomide.com>, Pantelis Antoniou <panto@antoniou-consulting.com>
List-Id: linux-omap@vger.kernel.org

Pinctrl-fy the OMAP I2C driver.

Due to the requirement of early usage of I2C for
regulators and such, earlier initialization of pinctrl
is required.

This patch series is against

git://gitorious.org/linus-tree/linus-tree.git for_3.7/i2c/big_cleanups

Note that the I2C DT bindings are against the linux-omap-dt tree
and that without https://patchwork.kernel.org/patch/1468531
queued for 3.7 scary messages will be printed on !DT platforms

Pantelis Antoniou (3):
  pinctrl: pinctrl-single must be initialized early.
  OMAP i2c: pinctrl-ify i2c-omap.c
  i2c: OMAP fix driver initialization message

 drivers/i2c/busses/i2c-omap.c    | 13 ++++++++++---
 drivers/pinctrl/pinctrl-single.c | 12 +++++++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
1.7.12
