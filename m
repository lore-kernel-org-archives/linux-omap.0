From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] OMAP2+: clkctrl fixes/enhancements for OMAP SoCs for 4.16
 merge
Date: Tue, 5 Dec 2017 15:02:43 +0200
Message-ID: <26d92d81-5922-1755-e59c-964e09a7f3c2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

This pull contains the series posted here [1], it has only been rebased 
on top of 4.15-rc1. Can be applied separately from the clkctrl driver 
series. The part missing after this is the DTS series, which I will post 
later this week (I don't think I have time to post them today, but they 
are available also under branch 4.15-rc1-clkctrl-dts in my public repo.)

-Tero

[1] http://www.spinics.net/lists/linux-omap/msg139902.html

===

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

   https://github.com/t-kristo/linux-pm.git 4.15-rc1-clkctrl-mach-omap2

for you to fetch changes up to 71d50393ab0186b40860d31468a1b701c97339f6:

   ARM: DM816x: hwmod_data: fix clockdomain name for sata hwmod 
(2017-12-04 11:35:21 +0200)

----------------------------------------------------------------
Tero Kristo (7):
       ARM: OMAP2+: CM: add support for getting phys address for a 
clkctrl register
       ARM: OMAP4: CMINST: add support for translating clkctrl addresses
       ARM: OMAP2+: hwmod: fix clkctrl address translation logic
       ARM: OMAP2+: clockdomain: remove the obsolete clkdm_xlate_address API
       ARM: AM33xx: CM: add support for getting physical address for a 
register
       ARM: OMAP2+: hwmod: calculate physical register address on am33xx
       ARM: DM816x: hwmod_data: fix clockdomain name for sata hwmod

  arch/arm/mach-omap2/clockdomain.c          |  8 ----
  arch/arm/mach-omap2/clockdomain.h          |  2 -
  arch/arm/mach-omap2/cm.h                   |  3 ++
  arch/arm/mach-omap2/cm33xx.c               |  6 +++
  arch/arm/mach-omap2/cm_common.c            | 10 ++++
  arch/arm/mach-omap2/cminst44xx.c           | 10 ++--
  arch/arm/mach-omap2/omap_hwmod.c           | 73 
+++++++++++++++---------------
  arch/arm/mach-omap2/omap_hwmod_81xx_data.c |  2 +-
  8 files changed, 59 insertions(+), 55 deletions(-)
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
