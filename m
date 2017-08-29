From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Fixes for omap hwmod for dropping legacy data
Date: Tue, 29 Aug 2017 10:03:30 -0700
Message-ID: <20170829170335.11536-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are few fixes for hwmod issues I noticed while dropping legacy
data for dma, irq and IO resources. The two last patches drop dead
code that's now unnecessary with all of mach-omap2 booting in
device tree only mode.

Regards,

Tony


Tony Lindgren (5):
  ARM: OMAP2+: Fix access to reserved smartreflex registers for dra7
  ARM: OMAP2+: Fix MMC address space mismatch for am33xx and am43xx
  ARM: OMAP2+: Fix overwriting of clkctrl and modulemode values
  ARM: OMAP2+: Drop unused omap_init_hdq
  ARM: OMAP2+: Drop unused omap_hwmod_mux_info

 arch/arm/mach-omap2/hdq1w.c                        |  22 -----
 arch/arm/mach-omap2/omap_hwmod.c                   |  49 ++++++++--
 arch/arm/mach-omap2/omap_hwmod.h                   |  21 +---
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |  30 ------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   6 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 106 ---------------------
 6 files changed, 47 insertions(+), 187 deletions(-)

-- 
2.14.1
