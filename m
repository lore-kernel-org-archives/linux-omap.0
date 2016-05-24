From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] ARM: OMAP: DRA7: Update to latest TRM and cleanup
Date: Tue, 24 May 2016 08:35:37 -0500
Message-ID: <1464096940-27145-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Here are the final(hopefully) pending patches for DRA7 based on recent
TRM updates. Updates include removing retention support on L3init and
L4per as per latest SoC updates.

Test Log: X15 (no modules): http://pastebin.ubuntu.com/16655027/

Latest TRM (rev F): http://www.ti.com/lit/pdf/spruhz6 (public on May 18)

Nishanth Menon (3):
  ARM: OMAP: DRA7: powerdomain data: Set L3init and L4per to ON
  ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_logic_ret
  ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_mem_ret

 arch/arm/mach-omap2/powerdomains7xx_data.c | 76 +-----------------------------
 1 file changed, 2 insertions(+), 74 deletions(-)

-- 
2.8.0
