From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/3] ARM: OMAP2+: AM43x: Enable in OMAP2PLUS and add ID for
 ES1.1
Date: Thu, 6 Feb 2014 13:56:26 +0530
Message-ID: <1391675189-10608-1-git-send-email-lokeshvutla@ti.com>
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
Cc: nm@ti.com, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, nsekhar@ti.com, lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch series enables AM43XX SOC in omap2plus_deconfig along with
updating clocksource and adding support for ES1.1.
With this series using omap2plus_defconfig alone boots on AM43XX.

Tested on: AM4372 EPOS EVM

Afzal Mohammed (1):
  ARM: OMAP2+: AM43x: enable in default config

Lokesh Vutla (1):
  ARM: OMAP2+: AM43x: Add ID for ES1.1

Rajendra Nayak (1):
  ARM: OMAP2+: AM43x: Use gptimer as clocksource

 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/board-generic.c  |    2 +-
 arch/arm/mach-omap2/id.c             |   14 ++++++++++++--
 arch/arm/mach-omap2/soc.h            |    3 ++-
 arch/arm/mach-omap2/timer.c          |    3 ++-
 5 files changed, 18 insertions(+), 5 deletions(-)

-- 
1.7.9.5
