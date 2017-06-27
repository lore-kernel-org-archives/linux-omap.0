From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/3] ARM: dts: omap: workarounds for Ethernet PHY strap on
 DRA71 and DRA72 EVMs
Date: Tue, 27 Jun 2017 20:36:09 +0530
Message-ID: <cover.1498573382.git.nsekhar@ti.com>
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
Cc: Device Tree Mailing List <devicetree@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Here are some patches to overcome incorrect Ethernet PHY strap settings
on DRA72x EVM Rev C and DRA71 EVM. Both of these boards use TI's DP83867
PHY.

The incorrect PHY strap settings cause a voilation of PHY specification
and need to be worked around in software as documented in the commit
messages. But there is no known issue that these patches fix.

I did verify that there are no regressions with NFS boot on these boards
after the patches are applied on v4.12-rc4.

The series itself has been rebased on your omap-for-v4.13/dt branch since
it has some conflicts with patches you have queued.

Sekhar Nori (3):
  ARM: dts: dra71-evm: workaround incorrect DP83867 RX_CTRL pin strap
  ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin
    strap
  ARM: omap2plus_defconfig: enable DP83867 phy driver

 arch/arm/boot/dts/dra71-evm.dts      | 2 ++
 arch/arm/boot/dts/dra72-evm-revc.dts | 2 ++
 arch/arm/configs/omap2plus_defconfig | 1 +
 3 files changed, 5 insertions(+)

-- 
2.9.0
