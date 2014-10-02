From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 0/2] Couple of changes to gpio-gate-clock
Date: Thu, 2 Oct 2014 10:53:30 +0300
Message-ID: <cover.1412234778.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, kernel-janitors@vger.kernel.org
Cc: dan.carpenter@oracle.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

The first was suggested by Dan Carpenter. The second is just cleaning
and not affecting the functionality.

Jyri Sarha (2):
  clk: gpio-gate: Stop using devres API
  clk: gpio-gate: Rename the struct from clk_gpio to clk_gpio_gate

 drivers/clk/clk-gpio-gate.c  |   34 ++++++++++++----------------------
 include/linux/clk-provider.h |    2 +-
 2 files changed, 13 insertions(+), 23 deletions(-)

-- 
1.7.9.5
