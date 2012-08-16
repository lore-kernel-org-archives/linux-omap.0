From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] Add device tree data for AM33XX devices
Date: Thu, 16 Aug 2012 17:50:06 +0530
Message-ID: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
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
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add pinctrl and d_can device tree data to AM33XX family of devices.
First two patches add support for pinctrl DT data and rest adds
dcan DT data.

Reason behind combining these patches is to apply cleanly on
linux-omap devel-dt tree because these are sequential patches.

These patches were tested on AM335x-Bone and AM335x-EVM apply
on linux-omap:devel-dt tree with this patch
http://lkml.org/lkml/2012/8/15/106

AnilKumar Ch (4):
  arm/dts: AM33XX: Add basic pinctrl device tree data
  arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone
  arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on AM335x-EVM
  arm/dts: AM33XX: Add D_CAN device tree data

 arch/arm/boot/dts/am335x-bone.dts |   14 ++++++++++++++
 arch/arm/boot/dts/am335x-evm.dts  |   16 ++++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |   27 +++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

-- 
1.7.9.5
