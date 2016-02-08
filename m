From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/3] arm: dts: DRA7: Add IVA and DSPEVE thermal domain data
Date: Mon, 8 Feb 2016 14:46:27 +0530
Message-ID: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
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
To: tony@atomide.com, edubezval@gmail.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, ijc+devicetree@hellion.org.uk, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

OMAP5 has 3 thermal zones cpu, core and multimedia.
On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
and iva. Currently cpu, core and multimedia are being added via dt
and the other 2 are getting added via kernel. Add the missing thermal
domains in dt so as give the correct trip numbers, type and temperatures.

Tested on DRA7-EVM.
 
Keerthy (3):
  arm: dts: DRA7: Add DSPEVE thermal data
  arm: dts: DRA7: Add IVA thermal data
  arm: dts: DRA7: Add missing IVA and DSPEVE thermal domain data

 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                |  2 ++
 3 files changed, 56 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi

-- 
1.9.1
