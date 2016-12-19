From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/9] ARM: omap: Add empty chosen node in SoCs top level DTSI
Date: Mon, 19 Dec 2016 11:44:32 -0300
Message-ID: <1482158681-4530-1-git-send-email-javier@osg.samsung.com>
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
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Pali Rohar <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello Tony,

As discussed in [0], there's a regression when booting a kernel with a DTB
that doesn't have a pre-existing chosen node. This is usually not an issue
for most boards since u-boot creates an empty chosen node if isn't present
in the DTB.

But it can be an issue for others bootloaders as Pali pointed out with the
N9/900/950 phones and the Nokia Loader (NoLo).

This patch series add chosen nodes in the top level DTSI for all OMAP SoCs.

[0]: http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1294379.html

Best regards,
Javier


Javier Martinez Canillas (9):
  ARM: dts: omap2: Add an empty chosen node to top level DTSI
  ARM: dts: omap3: Add an empty chosen node to top level DTSI
  ARM: dts: omap4: Add an empty chosen node to top level DTSI
  ARM: dts: omap5: Add an empty chosen node to top level DTSI
  ARM: dts: am33xx: Add an empty chosen node to top level DTSI
  ARM: dts: am4372: Add an empty chosen node to top level DTSI
  ARM: dts: dm814x: Add an empty chosen node to top level DTSI
  ARM: dts: dm816x: Add an empty chosen node to top level DTSI
  ARM: dts: dra7: Add an empty chosen node to top level DTSI

 arch/arm/boot/dts/am33xx.dtsi | 1 +
 arch/arm/boot/dts/am4372.dtsi | 1 +
 arch/arm/boot/dts/dm814x.dtsi | 1 +
 arch/arm/boot/dts/dm816x.dtsi | 1 +
 arch/arm/boot/dts/dra7.dtsi   | 1 +
 arch/arm/boot/dts/omap2.dtsi  | 1 +
 arch/arm/boot/dts/omap3.dtsi  | 1 +
 arch/arm/boot/dts/omap4.dtsi  | 1 +
 arch/arm/boot/dts/omap5.dtsi  | 1 +
 9 files changed, 9 insertions(+)

-- 
2.7.4
