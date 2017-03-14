From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Clean up omap hwmod code for dynamic allocation
Date: Tue, 14 Mar 2017 14:06:35 -0700
Message-ID: <20170314210639.2065-1-tony@atomide.com>
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
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi all,

In preparation for eventually configuring omap hwmod data from device tree
we need to make few changes in preparation for allocating data dynamically.

Regards,

Tony

Tony Lindgren (4):
  ARM: OMAP2+: Remove mostly unused hwmod linkspace
  ARM: OMAP2+: Use list_for_each_entry for hwmod slave_ports
  ARM: OMAP2+: Remove unnecessary hwmod clockact
  ARM: OMAP2+: Make hwmod clkdm_name const

 arch/arm/mach-omap2/omap_hwmod.c                   | 199 ++-------------------
 arch/arm/mach-omap2/omap_hwmod.h                   |  16 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   4 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   1 -
 7 files changed, 15 insertions(+), 210 deletions(-)

-- 
2.11.1
