From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/7] ARM: OMAP4+: powerdomain fixes
Date: Fri, 22 Aug 2014 08:49:26 -0500
Message-ID: <1408715373-25791-1-git-send-email-nm@ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

The following series are various fixes and improvements for
powerdomain support in OMAP4+.

This is part 1/6 series which eventually enables framework for
suspend-to-ram and cpuidle for OMAP5 and DRA7

Each of series is based on v3.17-rc1 and this specific series is available:
weblink: https://github.com/nmenon/linux-2.6-playground/commits/push/v3.17/powerdomain-fixes

git repo: https://github.com/nmenon/linux-2.6-playground.git push/v3.17/powerdomain-fixes

An complete integrated branch is available here: https://github.com/nmenon/linux-2.6-playground/commits/testing/v3.17/cpu-idle-suspend-dra7-omap5-framework

Nishanth Menon (7):
  ARM: OMAP: DRA7: powerdomain data: fix powerdomain powerstate
  ARM: OMAP5: powerdomain data: fix powerdomain powerstate
  ARM: OMAP2+: powerdomain: pwrdm_for_each_clkdm iterate only valid
    clkdms
  ARM: OMAP2+: powerdomain: introduce logic for finding valid power
    domain
  ARM: OMAP4+: PM: Make logic state programmable
  ARM: OMAP4+: PM: use only valid low power state for suspend
  ARM: OMAP4+: PM: Use only valid low power state for CPU hotplug

 arch/arm/mach-omap2/omap-mpuss-lowpower.c   |    4 ++
 arch/arm/mach-omap2/pm44xx.c                |    9 +++-
 arch/arm/mach-omap2/powerdomain.c           |   76 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/powerdomain.h           |    4 ++
 arch/arm/mach-omap2/powerdomains54xx_data.c |   12 ++---
 arch/arm/mach-omap2/powerdomains7xx_data.c  |   14 ++---
 6 files changed, 103 insertions(+), 16 deletions(-)

-- 
1.7.9.5
