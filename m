From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/9] ARM: dts: omap5-uevm: fixup wrong regulator configuration
Date: Wed, 17 Jul 2013 11:45:29 -0500
Message-ID: <1374079538-19548-1-git-send-email-nm@ti.com>
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
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Due to wrong older revision of documentation used as reference, we
seem to have a bunch of LDOs wrongly configured on OMAP5 uEVM. This
series is based power tree on production board 750-2628-XXX platform.
Unfortunately, the wrong voltages may be detrimental to OMAP5 as they
supply hardware blocks at voltages that are out of specification.

Also available at:
based on v3.11-rc1 tag
http link: https://github.com/nmenon/linux-2.6-playground/commits/push/omap5-palmas-fixes
git link: git://github.com/nmenon/linux-2.6-playground.git
branch: push/omap5-palmas-fixes

Tested with https://patchwork.kernel.org/patch/2545061/
 + https://git.kernel.org/cgit/linux/kernel/git/ssantosh/linux.git/log/?h=for_3.11/out_of_tree/omap5_clk_data
Test result: http://pastebin.com/YqASYkXG

Relevant documentation:
- OMAP5 uEVM documentation: https://www.svtronics.com/omap/omap54xx?product_id=33
- OMAP5432 Data Manual: http://www.ti.com/product/OMAP5432
- TWL6037 / OTP information: Currently available only under NDA

Nishanth Menon (9):
  ARM: dts: omap5-uevm: document regulator signals used on the actual
    board
  ARM: dts: omap5-uevm: update SMPS9 settings
  ARM: dts: omap5-uevm: update and disable unused regulators LDO[28]
  ARM: dts: omap5-uevm: update LDO1 voltage to 1.5V and settings
  ARM: dts: omap5-uevm: update LDO3 voltage to 1.5V and settings
  ARM: dts: omap5-uevm: update LDO4 voltage to 1.5V and settings
  ARM: dts: omap5-uevm: update LDO6 voltage to 1.2V
  ARM: dts: omap5-uevm: update LDO7 voltage to 2V and settings
  ARM: dts: omap5-uevm: update SDCARD LDO9 and resource REGEN3

 arch/arm/boot/dts/omap5-uevm.dts |   78 ++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 29 deletions(-)

-- 
1.7.9.5

Regards,
Nishanth Menon
