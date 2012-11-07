From: Joshua Emele <jemele@gmail.com>
Subject: [PATCH 0/4] cpufreq: OMAP: if available, scale the iva coprocessor
Date: Tue,  6 Nov 2012 17:47:37 -0800
Message-ID: <1352252861-18384-1-git-send-email-jemele@gmail.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joshua Emele <jemele@gmail.com>
List-Id: linux-omap@vger.kernel.org

The iva coprocessor, available on some omap platforms, shares a voltage domain
with the mpu. If cpufreq is active and the mpu processor is scaled down, the iva
coprocessor should also be scaled. The goal is to make sure we do not ramp down
the voltage on the domain and affect clocking on the iva coprocessor leading to
a dsp crash.

I only have access to an omap3evm-ish device, so I do not know what the iva
clock name is for omap24xx and omap44xx. This detail can be added later if the
general approach is approved.

I have tested a version of this patch against the linux-3.3 kernel, so this my
attempt at a forward port against the current mainline. I have based my patch
series against linux-omap-pm/pm-next.

Joshua Emele (4):
  cpufreq: OMAP: if an iva clock name is specified, load iva resources
  cpufreq: OMAP: for omap3 devices, specify the iva clock name
  cpufreq: OMAP: ensure the iva coprocessor is at the same opp as the
    mpu
  cpufreq: OMAP: scale the iva coprocessor if available

 drivers/cpufreq/omap-cpufreq.c |  113 +++++++++++++++++++++++++++++++++------
 1 files changed, 95 insertions(+), 18 deletions(-)

-- 
1.7.6.5

