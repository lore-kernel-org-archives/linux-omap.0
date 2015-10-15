From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 0/3] ARM: OMAP2+: Optimize soc_is calls
Date: Thu, 15 Oct 2015 10:40:05 +0530
Message-ID: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
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
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The series implements optimizing soc_is calls for DRA7 and AM43XX
family of SoCs. Originally the soc_is calls for DRA7 involved parsing
device tree nodes and some repetitive string comparisons. Optimizing
to store the result and use the result in the subsequent calls.

The series is boot tested on am437x-gp-evm, am335x-beaglebone, dra7-evm,
dra72-evm, omap3 beagle-xm. 

Compile Testing:

** Compile tested individual: OMAP2, OMAP3, OMAP4, OMAP5, DRA7XX, AM437x,
   AM33XX defconfig.
** Ran Randconfig and found no errors under arch/arm/mach-omap2
   overnight testing.
   Source: https://github.com/felipebalbi/omap-seeds

The series is on top of:

https://patchwork.kernel.org/patch/7390351/


Keerthy (3):
  ARM: OMAP2: DRA7: Modify optimize string comparisons in soc_is calls
  ARM: dts: AM43x-epos-evm: Add AM438x compatible string for epos
  ARM: OMAP2: AM43XX: Modify optimize string comparisons in soc_is calls

 .../devicetree/bindings/arm/omap/omap.txt          |  5 +++-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
 arch/arm/mach-omap2/id.c                           | 28 ++++++++++++++++++++++
 arch/arm/mach-omap2/soc.h                          | 25 +++++++++++++++----
 4 files changed, 53 insertions(+), 7 deletions(-)

-- 
1.9.1
