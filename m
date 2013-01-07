From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] ARM: dts: AM33XX: lcdc support
Date: Mon, 7 Jan 2013 10:47:54 +0530
Message-ID: <cover.1357304150.git.afzal@ti.com>
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
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

This series add DT sources for AM335x SoC as well as AM335x based
boards.

As pinmux is an SoC specific detail rather than IP specific one,
addition of pin control has been done in a separate patch from
the one in which display timings are added. Also it may aid in
debugging in case of any issues.

This has been tested on AM335x based boards like AM335x EVM and
AM335x EVM-SK.

This series is based on v3.8-rc2.

This series has a dependency on,
1. Series v16 "of: add display helper" by,
	Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
2. Series v2 "video: da8xx-fb: runtime timing configuration" by,
	me (Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>)
3. Series "video: da8xx-fb: DT support" by,
	me (Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>)

To test on AM335x, in addition to the above, following changes,
1. Patch "da8xx: Allow use by am33xx based devices" by,
	Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
3. Series "HWMOD fixes for AM33xx PWM submodules and device tree nodes" by,
	Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
would be required

A tree with all above for testing is available
 @git://gitorious.org/x0148406-public/linux-kernel.git da8xx-fb-dt


Regards
Afzal

Afzal Mohammed (5):
  ARM: dts: AM33XX: Add lcdc node
  ARM: dts: AM33XX: Add am335x-evm lcdc panel timings
  ARM: dts: AM33XX: Add am335x-evm lcdc pincontrol info
  ARM: dts: AM33XX: Add am335x-evmsk lcdc panel timings
  ARM: dts: AM33XX: Add am335x-evmsk lcdc pincontrol info

 arch/arm/boot/dts/am335x-evm.dts   |   55 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/am335x-evmsk.dts |   55 +++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/am33xx.dtsi      |    8 ++++++
 3 files changed, 116 insertions(+), 2 deletions(-)

-- 
1.7.9.5
