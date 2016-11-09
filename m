From: Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v2 0/2] pinctrl: single: fixes for davinci
Date: Wed,  9 Nov 2016 15:53:59 +0100
Message-ID: <20161109145401.25327-1-ahaslam@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, haojian.zhuang@linaro.org, linus.walleij@linaro.org, khilman@baylibre.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>
List-Id: linux-omap@vger.kernel.org

After recent pinctl patches we see a warning when booting davinci
due to a bad memory allocation:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at mm/page_alloc.c:3511 __alloc_pages_nodemask+0x16c/0xb18
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-rc2-00023-g22d5127-dirty #1019
Hardware name: Generic DA850/OMAP-L138/AM18x
Backtrace: 
[<c000d670>] (dump_backtrace) from [<c000d794>] (show_stack+0x18/0x1c)
[<c000d77c>] (show_stack) from [<c021a0d0>] (dump_stack+0x20/0x28)
[<c021a0b0>] (dump_stack) from [<c001bb10>] (__warn+0xe8/0x100)
[<c001ba28>] (__warn) from [<c001bb50>] (warn_slowpath_null+0x28/0x30)
[<c001bb28>] (warn_slowpath_null) from [<c0097e7c>] (__alloc_pages_nodemask+0x16c/0xb18)
[<c0097d10>] (__alloc_pages_nodemask) from [<c00afef4>] (kmalloc_order+0x20/0x58)
[<c00afed4>] (kmalloc_order) from [<c00ce7ac>] (__kmalloc_track_caller+0x188/0x190)
[<c00ce624>] (__kmalloc_track_caller) from [<c02a762c>] (devm_kmalloc+0x24/0x70)
[<c02a7608>] (devm_kmalloc) from [<c0247d10>] (pcs_dt_node_to_map+0x1d0/0xa40)
[<c0245ec8>] (pinctrl_dt_to_map) from [<c0242fd0>] (pinctrl_get+0xe8/0x484)
[snip]

This series fixes this error.

Changes form v1 -> v2
* Add an error message, and correct also other places where the
issue is seen

* Add patch to parse for bits instead of pins

Axel Haslam (2):
  pinctrl: single: check for any error when getting rows
  pinctrl: single: search for the bits property when parsing bits

 drivers/pinctrl/pinctrl-single.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.10.1
