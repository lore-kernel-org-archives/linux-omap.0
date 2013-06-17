From: Ambresh K <ambresh@ti.com>
Subject: [PATCH V2 0/3] Fix to clk framework while handling orphan clks
Date: Mon, 17 Jun 2013 14:09:41 +0530
Message-ID: <1371458384-23936-1-git-send-email-ambresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Rajendra <rnayak@ti.com>, Ambresh K <ambresh@ti.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

From: Ambresh K <ambresh@ti.com>

On a possible HW bug or in-correct configuration of MUX register's in
bootloader; might return a value greater than available parent clocks
for a MUX clk.     
Sensing invalid parent index, clk_mux_get_parent returns -EINVALID. 
Due to function's "u8" return type it will get converted into signed value,
thus causing following pointer dereference on test platform.

M[    0.000000] dra7xx_clk_init: clk init (gpu_core_gclk_mux)^M
^M[    0.000000] Unable to handle kernel NULL pointer dereference at virtual
address 00000000^M
^M[    0.000000] pgd = c0004000^M
^M[    0.000000] [00000000] *pgd=00000000^M
^M[    0.000000] Internal error: Oops: 5 [#1] SMP ARM^M
^M[    0.000000] Modules linked in:^M
^M[    0.000000] CPU: 0    Not tainted  (3.8.4-gb746a7c-dirty #59)^M
^M[    0.000000] PC is at strcmp+0x8/0x34^M


Changes since v1:
- Fixed review comments.
- Fixed return type of .get_parent callback function.

Ambresh K (3):
  clk: fix clk_mux_get_parent return's signed value
  clk: skip re-parenting orphan clk
  ARM: OMAP2+: clk: Fix return type of callbacks

 arch/arm/mach-omap2/clkt_clksel.c |    2 +-
 arch/arm/mach-omap2/clkt_dpll.c   |    2 +-
 arch/arm/mach-omap2/clock.h       |    4 ++--
 drivers/clk/clk-mux.c             |    2 +-
 drivers/clk/clk.c                 |   16 +++++++++++++++-
 include/linux/clk-provider.h      |    6 +++---
 6 files changed, 23 insertions(+), 9 deletions(-)

-- 
1.7.4.1
