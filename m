From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] cpufreq: Introduce TI CPUFreq/OPP Driver
Date: Wed, 31 Aug 2016 21:53:26 -0500
Message-ID: <20160901025328.376-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
This series is v2 of the series to introduce the ti-cpufreq driver
which parses SoC data and provides opp-supported-hw data to the
OPP core in order to enable the proper OPPs for the silicon in use.
v1 of this series can be found here [1].

Mostly minor fixes to the driver with the largest being converting to the
driver to a module_platform_driver. In addition to this, the binding was
updated to add TI specific compatible strings for the SoCs supported by the
driver that it matches now. More specific driver changes can be found in
the patches.

This patch depends on [2], which actually has already been merged even though
the binding was not finalized yet, so another series here [3] was sent to
update the already merged dt nodes.

Regards,
Dave

[1] https://lkml.org/lkml/2016/5/18/653
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430205.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/452981.html

Dave Gerlach (2):
  Documentation: dt: add bindings for ti-cpufreq
  cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 130 +++++++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/ti-cpufreq.c                       | 308 +++++++++++++++++++++
 4 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 drivers/cpufreq/ti-cpufreq.c

-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
