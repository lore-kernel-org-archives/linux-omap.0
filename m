From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 5/8] ARM: OMAP4: hwmod_data: Remove modulemode from IPU/DSP
 hwmods
Date: Mon, 21 Aug 2017 18:48:15 -0500
Message-ID: <20170821234818.4755-6-s-anna@ti.com>
References: <20170821234818.4755-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821234818.4755-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The .modulemode field is removed from both the IPU and DSP processor
hwmods. This fixes a potential kernel crash during the shutdown sequence
of any of these remoteproc devices, either during a normal teardown or
during a recovery.

The DSP and IPU processor subsystems are represented by multiple hwmods,
one for each of the MMUs present within the subsystem and one for the
processor cores. The processor subsystem is clocked from a single clock
source with separate reset lines for each of the processors and the
MMUs. This clock and reset information is represented in separate hwmods
to allow the management of these entities in different drivers operating
on the corresponding platform devices. This doesn't fit quite well into
the current omap_hwmod layer due to these inter-dependencies.

A remoteproc startup sequence involves enabling and programming of the
MMUs, loading of the firmware into RAM mapped by the MMUs, and releasing
the processors from reset. A shutdown sequence follows a reverse pattern
with the processors put into reset first followed by the unmapping and
disabling of the MMUs. Both the processors and the MMUs are present
within a single clock domain and requires the domain be clocked and
enabled until the last entity. The kernel crash can happen during the
unmapping phase of the MMUs, as the hwmod layer disables the module
during the omap_device_idle processing of the processor hwmod. This
issue is fixed by not defining a modulemode for the IPU/DSP processors,
which results in keeping the module in an activated state. The module
is disabled properly during the omap_device_idle processing of the MMU
hwmod while disabling the MMU.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3e2d792fd9df..d183ffdf37e6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -550,7 +550,6 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_TESLA_TESLA_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1561,7 +1560,6 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
-- 
2.13.1
