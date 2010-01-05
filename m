From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 0/4] OMAP2xxx clock/CPUFreq: fix compilation errors;
	clean up
Date: Tue, 05 Jan 2010 10:35:08 -0700
Message-ID: <20100105173347.15485.42853.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32790 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab0AERgt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 12:36:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

This series fixes several compilation errors for OMAP2xxx chips when
CONFIG_CPU_FREQ is set.  These were reported and partially fixed
by Felipe Balbi <felipe.balbi@nokia.com>.

Considerable work is still needed to fully support dynamic frequency
changes on OMAP2xxx-series chips.  Readers interested in such a
project are encouraged to review the Maemo Diablo RX-34 and RX-44
kernel source at:

    http://repository.maemo.org/pool/diablo/free/k/kernel-source-diablo/

Boot-tested on N800 with n8x0_defconfig with CONFIG_CPU_FREQ; compile-tested
for 2430SDP.

This second version also incorporates some comments from Felipe.


- Paul

---

Felipe Balbi (1):
      OMAP2xxx clock: clk2xxx.c doesn't compile if CPUFREQ is enabled

Paul Walmsley (3):
      OMAP2xxx OPP: clean up comments in OPP data
      OMAP2 clock: dynamically allocate CPUFreq frequency table
      OMAP clock/CPUFreq: avoid leaking the CPUFreq frequency table


 arch/arm/mach-omap2/clock2xxx.c         |   57 ++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/opp2420_data.c      |   38 +++++++++++----------
 arch/arm/mach-omap2/opp2430_data.c      |   30 ++++++++--------
 arch/arm/plat-omap/clock.c              |   10 +++++
 arch/arm/plat-omap/cpu-omap.c           |    1 +
 arch/arm/plat-omap/include/plat/clock.h |    2 +
 6 files changed, 96 insertions(+), 42 deletions(-)


