From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/13] Drop more legacy platform data for omaps
Date: Wed, 11 Dec 2019 11:11:53 -0800
Message-ID: <20191211191206.12190-1-tony@atomide.com>
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
Cc: Keerthy <j-keerthy@ti.com>, Sebastian Reichel <sre@kernel.org>, Benoit Parrot <bparrot@ti.com>, Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

Here are more patches to drop legacy platform data for v5.6,
please test.

To make testing easier, I've pushed out all the related patches
I've posted over past few days into omap-for-5.6/ti-sysc-testing
branch at [0][1].

Regards,

Tony

[0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-5.6/ti-sysc-testing
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-5.6/ti-sysc-testing


Tony Lindgren (13):
  ARM: OMAP2+: Drop legacy platform data for am4 ocp2scp
  ARM: OMAP2+: Drop legacy platform data for omap4 ocp2scp
  ARM: OMAP2+: Drop legacy platform data for omap5 ocp2scp
  ARM: OMAP2+: Drop legacy platform data for dra7 ocp2scp
  ARM: OMAP2+: Drop legacy platform data for am4 vpfe
  ARM: OMAP2+: Drop legacy platform data for omap4 hsi
  ARM: OMAP2+: Drop legacy platform data for omap4 smartreflex
  ARM: OMAP2+: Drop legacy platform data for dra7 smartreflex
  ARM: OMAP2+: Drop legacy platform data for omap4 kbd
  ARM: OMAP2+: Drop legacy platform data for omap5 kbd
  ARM: OMAP2+: Drop legacy platform data for omap4 slimbus
  ARM: OMAP2+: Drop legacy platform data for dra7 rtcss
  ARM: OMAP2+: Drop legacy platform data for omap4 fdif

 arch/arm/boot/dts/am437x-l4.dtsi           |   4 -
 arch/arm/boot/dts/dra7-l4.dtsi             |   5 -
 arch/arm/boot/dts/omap4-l4.dtsi            |   8 -
 arch/arm/boot/dts/omap4.dtsi               |   1 -
 arch/arm/boot/dts/omap5-l4.dtsi            |   3 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 115 ------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 423 ---------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 117 ------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 194 ----------
 9 files changed, 870 deletions(-)

-- 
2.24.1
