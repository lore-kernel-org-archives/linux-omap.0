From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/4] arm: mach-omap2: clkdm/pwrdm: Save/restore context
Date: Wed, 16 May 2018 20:46:57 +0530
Message-ID: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
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
To: tony@atomide.com
Cc: t-kristo@ti.com, j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The series adds a save/restore functions for clockdomain
and powerdomain. The context is lost only with AM43XX SoCs
only in the rtc only mode with ddr in self-refresh.

The other OMAP family do not use the contexts as the PRCM
is in WKUP Domain.

Keerthy (2):
  omap2: clockdomain: Inroduce cpu_pm notifiers for context save/restore
  omap2: powerdomain: Inroduce cpu_pm notifiers for context     
    save/restore

Russ Dill (2):
  ARM: OMAP2: Add functions to save and restore clockdomain context
    en-masse.
  ARM: OMAP2: Add functions to save and restore powerdomain context

 arch/arm/mach-omap2/clockdomain.c | 73 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain.h |  8 ++++
 arch/arm/mach-omap2/cm33xx.c      | 53 ++++++++++++++++++++++++
 arch/arm/mach-omap2/cminst44xx.c  | 43 +++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.c | 87 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h |  7 ++++
 arch/arm/mach-omap2/prm33xx.c     | 31 ++++++++++++++
 arch/arm/mach-omap2/prm44xx.c     | 50 ++++++++++++++++++++++
 8 files changed, 352 insertions(+)

-- 
1.9.1
