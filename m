From: Joe Perches <joe@perches.com>
Subject: [PATCH 0/3] cpufreq: logging consistency changes
Date: Tue,  5 Apr 2016 13:28:22 -0700
Message-ID: <cover.1459887986.git.joe@perches.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Trivial consistency changes.

Joe Perches (3):
  intel_pstate: Use pr_fmt
  cpufreq: Convert printk(KERN_<LEVEL> to pr_<level>
  cpufreq: Use consistent prefixing via pr_fmt

 drivers/cpufreq/acpi-cpufreq.c            | 16 +++---
 drivers/cpufreq/cpufreq-nforce2.c         | 28 +++++------
 drivers/cpufreq/e_powersaver.c            | 62 ++++++++++-------------
 drivers/cpufreq/elanfreq.c                |  4 +-
 drivers/cpufreq/ia64-acpi-cpufreq.c       | 10 ++--
 drivers/cpufreq/intel_pstate.c            | 18 ++++---
 drivers/cpufreq/longhaul.c                | 84 +++++++++++++------------------
 drivers/cpufreq/loongson2_cpufreq.c       |  7 ++-
 drivers/cpufreq/maple-cpufreq.c           | 11 ++--
 drivers/cpufreq/omap-cpufreq.c            |  7 ++-
 drivers/cpufreq/p4-clockmod.c             | 19 ++-----
 drivers/cpufreq/pmac32-cpufreq.c          | 14 +++---
 drivers/cpufreq/pmac64-cpufreq.c          | 47 +++++++++--------
 drivers/cpufreq/powernow-k6.c             | 16 +++---
 drivers/cpufreq/powernow-k7.c             | 70 +++++++++++---------------
 drivers/cpufreq/pxa2xx-cpufreq.c          | 18 +++----
 drivers/cpufreq/s3c2412-cpufreq.c         | 15 +++---
 drivers/cpufreq/s3c2440-cpufreq.c         |  6 ++-
 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c |  4 +-
 drivers/cpufreq/s3c24xx-cpufreq.c         | 59 +++++++++++-----------
 drivers/cpufreq/s5pv210-cpufreq.c         | 10 ++--
 drivers/cpufreq/sc520_freq.c              | 10 ++--
 drivers/cpufreq/speedstep-centrino.c      |  6 +--
 drivers/cpufreq/speedstep-ich.c           |  8 +--
 drivers/cpufreq/speedstep-lib.c           | 11 ++--
 drivers/cpufreq/speedstep-smi.c           |  7 +--
 26 files changed, 269 insertions(+), 298 deletions(-)

-- 
2.8.0.rc4.16.g56331f8

