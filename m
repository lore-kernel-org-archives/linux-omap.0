From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/3] OMAP hwspinlock DT updates
Date: Mon, 13 Jan 2014 18:26:44 -0600
Message-ID: <1389659207-39445-1-git-send-email-s-anna@ti.com>
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
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series updates the existing OMAP hwspinlock DT nodes to have a
#hwlock-cells property as suggested by Mark Rutland [1], and adds the
hwspinlock nodes for two other newer SoCs - DRA7xx and AM43xx.

Posting the series separately from the driver DT adapation changes [2]
to avoid maintainer confusion.

[1] http://marc.info/?l=linux-omap&m=138433541420926&w=2
[2] http://marc.info/?l=linux-omap&m=138965904015225&w=2 

Suman Anna (3):
  ARM: dts: OMAP: Add #hwlock-cells property to hwspinlock nodes
  ARM: dts: DRA7: Add hwspinlock node
  ARM: dts: AM4372: Add hwspinlock node

 arch/arm/boot/dts/am33xx.dtsi | 1 +
 arch/arm/boot/dts/am4372.dtsi | 7 +++++++
 arch/arm/boot/dts/dra7.dtsi   | 7 +++++++
 arch/arm/boot/dts/omap4.dtsi  | 1 +
 arch/arm/boot/dts/omap5.dtsi  | 1 +
 5 files changed, 17 insertions(+)

-- 
1.8.4.3
