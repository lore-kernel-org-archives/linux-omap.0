From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: [PATCH v2 0/4] ARM: dts: AM3XXX: Use preprocessor for device trees
Date: Mon,  3 Jun 2013 16:12:21 +0200
Message-ID: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
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
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello,

Following my series for OMAP2+, this series makes use of the C preprocessor
when compiling AM3xxx DT files, and accomplishes some improvements to improve
overall readability.

The .dtb files were diff-tested before and after applying the series to
guarantee identity for all targets.

To enable pullup/down on the pad, the bit should be cleared on AM33xx, where
it should be set on OMAP3. This was wrong in my first version.

This series is based on Benoit's 'for_3.11/dts' branch.

Regards,

Florian

>From v2:
- Rebased on Benoit's 'for_3.11/dts'
- Fixed inversed bit to enable pullups ('1' on OMAP, but '0' on AM33xx)

Florian Vaussard (4):
  ARM: dts: AM3XXX: Use #include for all device trees
  ARM: dts: AM33XX: Use existing constants for GPIOs
  ARM: dts: AM33XX: Specific pinctrl header
  ARM: dts: AM33XX: Use pinctrl constants

 arch/arm/boot/dts/am335x-bone.dts       |   28 ++++++------
 arch/arm/boot/dts/am335x-evm.dts        |   76 +++++++++++++++---------------
 arch/arm/boot/dts/am335x-evmsk.dts      |   46 +++++++++---------
 arch/arm/boot/dts/am33xx.dtsi           |    5 ++-
 arch/arm/boot/dts/am3517-evm.dts        |    2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts |    2 +-
 include/dt-bindings/pinctrl/am33xx.h    |   37 +++++++++++++++
 7 files changed, 118 insertions(+), 78 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am33xx.h

-- 
1.7.5.4
