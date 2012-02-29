From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH 0/2] change lpj in arm smp common code
Date: Wed, 29 Feb 2012 15:18:13 +0800
Message-ID: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org
Cc: linux@arm.linux.org.uk, davej@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com, davidb@codeaurora.org, arnd@arndb.de, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, Richard Zhao <richard.zhao@linaro.org>
List-Id: linux-omap@vger.kernel.org

The two patches were originally in [PATCH V6 0/7] add a generic cpufreq driver.
I seperated them and hope they can go to upstream earlier.

Richard Zhao (2):
  ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp
  cpufreq: OMAP: remove loops_per_jiffy recalculate for smp

 arch/arm/kernel/smp.c          |   54 ++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/omap-cpufreq.c |   36 --------------------------
 2 files changed, 54 insertions(+), 36 deletions(-)

-- 
1.7.5.4


