From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [RFC PATCH 0/2] ARM: update cpuinfo to print CPU model name
Date: Tue, 29 Jan 2013 17:54:23 +0200
Message-ID: <1359474865-15408-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi,

The following patches update cpuinfo to print CPU
model name for ARM. First patch exactly makes needed
changes for ARM architecture.
Second patch adds this ability to OMAP4 SoCs.

This adds a common approach to show SoC name.

Looks like there were few attempts to do similar
changes to cpuinfo without any luck.

So - comments are welcome

Ruslan Bilovol (2):
  ARM: kernel: update cpuinfo to print CPU model name
  ARM: OMAP4: setup CPU model name during ID initialisation

 arch/arm/include/asm/setup.h |    1 +
 arch/arm/kernel/setup.c      |   10 ++++++++++
 arch/arm/mach-omap2/id.c     |   18 ++++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
1.7.9.5
