From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [RFC][PATCH 0/2] Device tree support for OMAP4 SCRM clocks
Date: Tue, 19 Mar 2013 16:26:58 +0200
Message-ID: <1363703220-4777-1-git-send-email-rogerq@ti.com>
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
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

Based on the discussion in [1], I've implemented device tree
provider for the AUXCLKs on OMAP4.

Please let me know if there are any issues.

This is important to get USB Host support working on Panda with
device tree boot on 3.10.

Roger Quadros (2):
  ARM: OMAP4: clock: Add device tree support for AUXCLKs
  ARM: dts: omap4-panda: Provide PHY clock information

 .../devicetree/bindings/clock/omap4-clock.txt      |   32 ++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |    2 +
 arch/arm/boot/dts/omap4.dtsi                       |    5 +++
 arch/arm/mach-omap2/board-generic.c                |    2 +-
 arch/arm/mach-omap2/cclock44xx_data.c              |   35 ++++++++++++++++++++
 arch/arm/mach-omap2/clock44xx.h                    |    1 +
 arch/arm/mach-omap2/common.h                       |    9 +++++
 arch/arm/mach-omap2/io.c                           |    6 +++
 8 files changed, 91 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/omap4-clock.txt

-- 
1.7.4.1
