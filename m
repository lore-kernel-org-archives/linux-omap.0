From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/6] ARM: OMAP3+: PRM: fix up prm_handling
Date: Fri, 22 Aug 2014 08:51:47 -0500
Message-ID: <1408715513-25851-1-git-send-email-nm@ti.com>
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
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following series are various fixes and improvements for
PRM for I/O Daisy chain support in OMAP4+ with device tree.

This is part 2/6 series which eventually enables framework for
suspend-to-ram and cpuidle for OMAP5 and DRA7

Each of series is based on v3.17-rc1 and this specific series is available:
weblink: https://github.com/nmenon/linux-2.6-playground/commits/push/v3.17/prm-fixes

git repo: https://github.com/nmenon/linux-2.6-playground.git push/v3.17/prm-fixes

An complete integrated branch is available here: https://github.com/nmenon/linux-2.6-playground/commits/testing/v3.17/cpu-idle-suspend-dra7-omap5-framework


Nishanth Menon (6):
  ARM: OMAP4+: prminst: provide function to find prm_dev instance
    offset
  ARM: OMAP4: PRM: use the generic prm_inst to allow logic to be
    abstracted
  ARM: OMAP4+: PRM: register interrupt information from DT
  ARM: OMAP4+: PRM: remove "wkup" event
  ARM: OMAP4+: PRM: Enable wakeup capability for OMAP5, DRA7
  ARM: OMAP3+: PRM: register interrupt information from DT

 arch/arm/mach-omap2/prm3xxx.c     |   18 ++++++++
 arch/arm/mach-omap2/prm44xx.c     |   90 ++++++++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/prminst44xx.c |   40 ++++++++++-------
 arch/arm/mach-omap2/prminst44xx.h |    3 ++
 4 files changed, 125 insertions(+), 26 deletions(-)

-- 
1.7.9.5
