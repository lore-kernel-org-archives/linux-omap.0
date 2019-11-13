From: Caleb Robey <c-robey@ti.com>
Subject: [uL PATCH 0/2] Enable BeagleBone AI
Date: Wed, 13 Nov 2019 16:13:42 -0600
Message-ID: <20191113221345.4795-1-c-robey@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-patch-review@list.ti.com
Cc: Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Caleb Robey <c-robey@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "Andrew F . Davis" <afd@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The following patches
1) Add device tree file for BeagleBone AI
2) Minor change to dra7.dtsi

Caleb Robey (2):
  ARM: dts: am5729: beaglebone-ai: adding device tree
  ARM: dts: am5729: beaglebone-ai: dra7 reqs in dts

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/am5729-beagleboneai.dts | 733 ++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi               |   2 +-
 3 files changed, 735 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts

-- 
2.17.1
