From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
Date: Fri, 17 Jul 2015 17:20:30 +0530
Message-ID: <1437133833-32355-1-git-send-email-lokeshvutla@ti.com>
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
To: paul@pwsan.com, tony@atomide.com
Cc: t-kristo@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This series implements lock and unlock functions for RTC and hooks
the same to DRA7 and AMx3xx hwmod.
This is dependent on the patch https://patchwork.kernel.org/patch/6578281/,
which is queued recently by Paul.

Tested on DRA72-evm: http://pastebin.ubuntu.com/11892356/

Lokesh Vutla (3):
  ARM: hwmod: RTC: Add lock and unlock functions
  ARM: DRA7: RTC: Add lock and unlock functions
  ARM: AMx3xx: RTC: Add lock and unlock functions

 arch/arm/mach-omap2/omap_hwmod.h                   |  2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +
 arch/arm/mach-omap2/omap_hwmod_reset.c             | 56 ++++++++++++++++++++++
 4 files changed, 62 insertions(+)

-- 
2.1.4
