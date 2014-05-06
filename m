From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] clk: Support for Palmas clk32kg and clk32kgaudio clocks
Date: Tue, 6 May 2014 16:24:43 +0300
Message-ID: <1399382685-14781-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1:
- binding documentation and driver has been separated based on Nishanth Menon's
  comment

v1 of the driver can be found:
https://lkml.org/lkml/2014/4/3/104

Palmas class of devices can provide 32K clock(s) to be used by other devices
on the board. Depending on the actual device the provided clocks can be:
CLK32K_KG and CLK32K_KGAUDIO
or only one:
CLK32K_KG (TPS659039 for example)

Use separate compatible flags for the two 32K clock.
A system which needs or have only one of the 32k clock from
Palmas will need to add node(s) for each clock as separate section
in the dts file.
The two compatible property is:
"ti,palmas-clk32kg" for clk32kg clock
"ti,palmas-clk32kgaudio" for clk32kgaudio clock

Apart from the register control of the clocks - which is done via
the clock API there is a posibility to enable the external sleep
control. In this way the clock can be enabled/disabled on demand by the
user of the clock.

Regards,
Peter
---
Peter Ujfalusi (2):
  dt/bindings: Binding documentation for Palmas clk32kg and clk32kgaudio
    clocks
  clk: Add driver for Palmas clk32kg and clk32kgaudio clocks

 .../bindings/clock/clk-palmas-clk32kg-clocks.txt   |  35 +++
 drivers/clk/Kconfig                                |   7 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-palmas.c                           | 307 +++++++++++++++++++++
 include/dt-bindings/mfd/palmas.h                   |  18 ++
 5 files changed, 368 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/clk-palmas-clk32kg-clocks.txt
 create mode 100644 drivers/clk/clk-palmas.c
 create mode 100644 include/dt-bindings/mfd/palmas.h

-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
