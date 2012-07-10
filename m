From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/3] Add device tree support for AM33XX regulators
Date: Tue, 10 Jul 2012 16:39:41 +0530
Message-ID: <1341918584-28004-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add device tree support for regulators present on AM33XX family
of devices like AM335X-EVM and AM335X-Bone. TPS65217 regulator
is present on AM335X-Bone and TPS65910 on AM335X-EVM.

First patch adds the device tree support to tps65217 regulator
so that it will take the parameters from tps65217.dtsi file and
convert to tps65217 regulator parameters.

Second patch adds tps65910 device tree data by adding separate
DT tps65910.dtsi file, which contains the generic tps65910 PMIC
DT data.

Third patch adds tps65217 device tree data by adding separate
tps65910.dtsi file, which contains the generic tps65910 PMIC
DT data.

This patch series was tested by adding the I2C slave address to
corresponding .dts files.

Changes form V1:
        - Add regulator-compatible data to dt files.
        - Separated device tree data addition to am335x-evm/bone dts
          from the regulator patches

AnilKumar Ch (3):
  regulator: tps65217: Add device tree support
  ARM: OMAP2+: AM33XX: Add tps65910 device tree data
  ARM: OMAP2+: AM33XX: Add tps65217 device tree data

 .../devicetree/bindings/regulator/tps65217.txt     |   91 +++++++++++++++
 arch/arm/boot/dts/tps65217.dtsi                    |   84 +++++++++++++
 arch/arm/boot/dts/tps65910.dtsi                    |  123 ++++++++++++++++++++
 drivers/mfd/tps65217.c                             |   67 ++++++++++-
 drivers/regulator/tps65217-regulator.c             |    1 +
 include/linux/mfd/tps65217.h                       |    3 +-
 6 files changed, 366 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/tps65217.txt
 create mode 100644 arch/arm/boot/dts/tps65217.dtsi
 create mode 100644 arch/arm/boot/dts/tps65910.dtsi

-- 
1.7.9.5
