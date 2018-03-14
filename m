From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/6] ARM: OMAP5: add support for fref-xtal-clk
Date: Wed, 14 Mar 2018 15:53:09 +0200
Message-ID: <20180314135315.11215-1-peter.ujfalusi@ti.com>
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
To: tony@atomide.com, t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Changes since v1 (sent by Tero):
- Rebased on linux-next
- Split the dts and binding document patch
- Tested it on omap5-uevm that the HPPLL of twl6040 is working (xtal clock is
  suplied)

The v1 of this series was sent about two years ago:
http://linux-arm-kernel.infradead.narkive.com/hBBbM4D7/patch-0-5-arm-omap5-add-support-for-fref-xtal-clk

but for some reason it was not applied back then, but I have been rolling it on
top of linux-next ever since.

Regards,
Peter
---
Peter Ujfalusi (1):
  ARM: dts: omap5-board-common: Add phandle for mclk clock for twl6040

Tero Kristo (5):
  ARM: omap2+: control: add support for auxiliary control module
    instances
  dt-bindings: omap5: ctrl: Support for control module wkup pad config
  ARM: dts: omap5: add support for control module wkup pad config
  ARM: OMAP5: control: add support for control module wkup pad config
  ARM: dts: omap5: add fref_xtal_ck support

 .../devicetree/bindings/arm/omap/ctrl.txt          |  1 +
 arch/arm/boot/dts/omap5-board-common.dtsi          |  4 ++--
 arch/arm/boot/dts/omap5.dtsi                       | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap54xx-clocks.dtsi             | 10 ++++++++++
 arch/arm/mach-omap2/control.c                      | 20 ++++++++++++++++----
 include/linux/clk/ti.h                             |  1 +
 6 files changed, 52 insertions(+), 6 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
