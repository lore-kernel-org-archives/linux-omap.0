From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] ARM: OMAP2: Make suspend work again.
Date: Fri, 1 Apr 2016 17:53:04 -0500
Message-ID: <1459551187-5992-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,
series of patches for fixing up attempt to suspend on X15 

Test: http://pastebin.ubuntu.com/15582436/

Based on v4.6-rc1

Also needs https://patchwork.kernel.org/patch/8724791/ if kernel
modules are installed

Nishanth Menon (3):
  ARM: OMAP: DRA7: wakeupgen: Skip SAR save for wakeupgen
  ARM: OMAP: DRA7: Provide proper class to omap2_set_globals_tap
  ARM: OMAP: Catch callers of revision information prior to it being
    populated

 arch/arm/mach-omap1/id.c             | 1 +
 arch/arm/mach-omap2/id.c             | 1 +
 arch/arm/mach-omap2/io.c             | 3 ++-
 arch/arm/mach-omap2/omap-wakeupgen.c | 7 +++++++
 4 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.8.0
