From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] cpufreq: OMAP updates for v3.4
Date: Wed, 07 Mar 2012 12:20:41 -0800
Message-ID: <87y5rci2na.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>, cpufreq@vger.kernel.org
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Dave,

Please pull the following OMAP CPUfreq driver changes for v3.4.

Thanks,

Kevin



The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/cpufreq

for you to fetch changes up to 42daffd2d6c665716d442d518022ecaad17ddf64:

  cpufreq: OMAP: specify range for voltage scaling (2012-03-02 13:55:57 -0800)

----------------------------------------------------------------
Afzal Mohammed (1):
      cpufreq: OMAP: specify range for voltage scaling

Kevin Hilman (1):
      cpufreq: OMAP: scale voltage along with frequency

Russell King (1):
      cpufreq: OMAP driver depends CPUfreq tables

 drivers/cpufreq/Kconfig.arm    |    5 +++
 drivers/cpufreq/Makefile       |    2 +-
 drivers/cpufreq/omap-cpufreq.c |   72 +++++++++++++++++++++++++++++++++++++---
 3 files changed, 73 insertions(+), 6 deletions(-)
