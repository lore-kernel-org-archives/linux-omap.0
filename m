From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] AM654: Add pinmux support
Date: Thu, 8 Nov 2018 16:56:45 +0530
Message-ID: <20181108112647.7205-1-vigneshr@ti.com>
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
To: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, Vignesh R <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add pinmux definitions and pinctrl regions for AM654 SoCs

Tero Kristo (2):
  dt-bindings: pinctrl: k3-am6: Introduce pinmux definitions
  arm64: dts: ti: k3-am65: Add pinctrl regions

 MAINTAINERS                                |  1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 16 +++++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi |  8 ++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi        |  1 +
 include/dt-bindings/pinctrl/k3-am6.h       | 49 ++++++++++++++++++++++
 5 files changed, 75 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/k3-am6.h

-- 
2.19.1
