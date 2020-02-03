From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: OF: ERROR: Bad of_node_put() on /ocp/interconnect
Date: Mon, 3 Feb 2020 19:46:34 +0530
Message-ID: <CA+G9fYvi8g=5MG4HzN0QPH+_LEX1xXo-m2xmbHRqdMJzaqBCFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, lkft-triage@lists.linaro.org
List-Id: linux-omap@vger.kernel.org

The following error/warning noticed on beagleboard x15 running linux
next 5.5.0-next-20200203.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: cee5a42837d4a6c4189f06f7bf355b97a24c3c93
  git describe: next-20200203
  make_kernelversion: 5.5.0
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/am57xx-evm/lkft/linux-next/694/config


[    0.000000] OF: ERROR: Bad of_node_put() on
/ocp/interconnect@4a000000/segment@0/target-module@8000/cm_core@0/l4per-cm@1700/l4per-clkctrl@28
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
  5.5.0-next-20200203 #1
[    0.000000] Hardware name: Generic DRA74X (Flattened Device Tree)
[    0.000000] Backtrace:
[    0.000000] [<c040fac4>] (dump_backtrace) from [<c040fdf8>]
(show_stack+0x20/0x24)
[    0.000000]  r7:c23f2e68 r6:00000000 r5:600000d3 r4:c23f2e68
[    0.000000] [<c040fdd8>] (show_stack) from [<c14144d0>]
(dump_stack+0xe8/0x114)
[    0.000000] [<c14143e8>] (dump_stack) from [<c112b7cc>]
(of_node_release+0xb4/0xcc)
[    0.000000]  r10:efca9a44 r9:00000001 r8:00000000 r7:00000000
r6:c23d2350 r5:efca9a44
[    0.000000]  r4:efca9a70 r3:be2d277f
[    0.000000] [<c112b718>] (of_node_release) from [<c1419c28>]
(kobject_put+0x11c/0x23c)
[    0.000000]  r5:c2422cb8 r4:efca9a70
[    0.000000] [<c1419b0c>] (kobject_put) from [<c112aa98>]
(of_node_put+0x24/0x28)
[    0.000000]  r7:e98f7980 r6:c2201ef4 r5:00000000 r4:e98f7940
[    0.000000] [<c112aa74>] (of_node_put) from [<c20474a0>]
(of_clk_init+0x1a4/0x248)
[    0.000000] [<c20472fc>] (of_clk_init) from [<c20140dc>]
(omap_clk_init+0x4c/0x68)
[    0.000000]  r10:efc8b8c0 r9:c2433054 r8:00000000 r7:c2208700
r6:00000066 r5:c20dab64
[    0.000000]  r4:c2434500
[    0.000000] [<c2014090>] (omap_clk_init) from [<c2014afc>]
(omap4_sync32k_timer_init+0x18/0x3c)
[    0.000000]  r5:c20dab64 r4:c2433000
[    0.000000] [<c2014ae4>] (omap4_sync32k_timer_init) from
[<c2014de8>] (omap5_realtime_timer_init+0x1c/0x258)
[    0.000000] [<c2014dcc>] (omap5_realtime_timer_init) from
[<c2005954>] (time_init+0x30/0x44)
[    0.000000]  r9:c2433054 r8:00000000 r7:c2208700 r6:00000066
r5:c20dab64 r4:c2433000
[    0.000000] [<c2005924>] (time_init) from [<c20012dc>]
(start_kernel+0x590/0x720)
[    0.000000] [<c2000d4c>] (start_kernel) from [<00000000>] (0x0)
[    0.000000]  r10:30c5387d r9:412fc0f2 r8:8ffdc000 r7:00000000
r6:30c0387d r5:00000000
[    0.000000]  r4:c2000330

full test log,
https://lkft.validation.linaro.org/scheduler/job/1158386#L3677

-- 
Linaro LKFT
https://lkft.linaro.org
