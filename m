From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 0/5] mfd: tps65217: Improve the IRQ domain feature
Date: Tue, 15 Nov 2016 22:02:10 +0900
Message-ID: <20161115130215.3301-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

TPS65217 can be built as a module, this patch-set includes the error fix 
and rework the interrupt handler.
Additionally, TPS65217 INT pin is registered as a system wakeup source.

Milo Kim (5):
  mfd: tps65217: Fix page fault on unloading modules
  mfd: tps65217: Specify the IRQ name
  mfd: tps65217: Update register interrupt mask bits instead of writing
    operation
  mfd: tps65217: Make an interrupt handler simpler
  mfd: tps65217: Support an interrupt pin as the system wakeup

 drivers/mfd/tps65217.c       | 71 ++++++++++++++++++++------------------------
 include/linux/mfd/tps65217.h |  4 ++-
 2 files changed, 36 insertions(+), 39 deletions(-)

-- 
2.9.3
