From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] pinmux: Export pinmux_register_mappings for pinmux
 modules
Date: Fri, 03 Feb 2012 12:55:05 -0800
Message-ID: <20120203205505.4089.67339.stgit@kaulin.local>
References: <20120203205049.4089.74610.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59747 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629Ab2BCUzJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Feb 2012 15:55:09 -0500
In-Reply-To: <20120203205049.4089.74610.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Stephen Warren <swarren@nvidia.com>, Linus Walleij <linus.walleij@stericsson.com>, Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Grant Likely <grant.likely@secretlab.ca>, Thomas Abraham <thomas.abraham@linaro.org>, Rajendra Nayak <rajendra.nayak@linaro.org>, Dong Aisheng <dong.aisheng@linaro.org>, Shawn Guo <shawn.guo@freescale.com>, Dong Aisheng <dongas86@gmail.com>

With devidce tree based pinmux drivers we may not have
static pinmux mappings as they can be dynamically created
based on the device tree entries.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/pinmux.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 7c3193f..140d207 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -338,7 +338,7 @@ EXPORT_SYMBOL_GPL(pinmux_gpio_direction_output);
  * passed into this function will be owned by the pinmux core and cannot be
  * freed.
  */
-int __init pinmux_register_mappings(struct pinmux_map const *maps,
+int pinmux_register_mappings(struct pinmux_map const *maps,
 				    unsigned num_maps)
 {
 	void *tmp_maps;
@@ -402,6 +402,7 @@ int __init pinmux_register_mappings(struct pinmux_map const *maps,
 	pinmux_maps_num += num_maps;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pinmux_register_mappings);
 
 /**
  * acquire_pins() - acquire all the pins for a certain function on a pinmux

