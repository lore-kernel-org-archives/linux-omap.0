From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain,
 powerdomain & PRM support for AM33XX device
Date: Fri, 30 Mar 2012 21:33:51 +0530
Message-ID: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, rnayak@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

After some healthy discussion, now we have come to the conclusion and
decided to handle AM33XX PRM/CM part separately; as AM33XX-PRCM module is
different than OMAP3 and OMAP4 architecture.

The difference becomes very interesting/weird when it comes to
the consistency for register offsets in PRM address space and
bit-field offsets inside PRM registers,
So along with Powerdomain data and PRM api's required for AM33XX
device, this patch series adds,

 - XXX_RSTST register offset to "struct omap_hwmod_omap4_prcm"
 - PWRSTCTRL & PWRSTST register offsets to "struct powerdomain"
 - Logicretstate and mem_on/ret/pwrst/retst mask to "struct
   powerdomain"

Testing: This patch series has been boot tested on AM37xEVM and AM335x
         based BeagleBone community board.

Thanks to Paul here...for helping and concluding on this,
shortly I will submit similar patch for CM, clockdomain and clock-tree
support for AM33xx.

This patch-series is created on top of "linux-omap/cleanup" branch, and
also gets applied to "linux-omap/master" branch.
The patches are also available at -
https://github.com/hvaibhav/am335x-linux/tree/am335x-prm-cm

Changes from previous versions:
===============================
>From V3:
	- No code change, only added Voltagedomain patch (from V2 series)
	  to this series.

>From V1 & V2:
    	- Rolled back to my original approach, where AM33xx
	  device was handled separately (RFC version).
	- As per Paul's comments, added Register offsets & bit-fields
	  masks.

Vaibhav Hiremath (4):
  ARM: OMAP3+: am33xx: Add voltage domain data
  ARM: OMAP3/4: omap_hwmod: Add rstst_off field to struct
    omap_hwmod_omap4_prcm
  ARM: OMAP2+: powerdomain: Add offset & mask fields to struct
    powerdomain
  ARM: OMAP3+: am33xx: Add powerdomain & PRM support

 arch/arm/mach-omap2/Makefile                  |    6 +
 arch/arm/mach-omap2/io.c                      |    2 +
 arch/arm/mach-omap2/omap_hwmod.c              |   32 ++-
 arch/arm/mach-omap2/powerdomain.h             |   23 ++-
 arch/arm/mach-omap2/powerdomain33xx.c         |  230 ++++++++++++++++
 arch/arm/mach-omap2/powerdomains33xx_data.c   |  185 +++++++++++++
 arch/arm/mach-omap2/prm-regbits-33xx.h        |  357 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prm33xx.c                 |  134 +++++++++
 arch/arm/mach-omap2/prm33xx.h                 |  129 +++++++++
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   43 +++
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
 12 files changed, 1139 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/prm33xx.c
 create mode 100644 arch/arm/mach-omap2/prm33xx.h
 create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c
