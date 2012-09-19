From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB
Date: Wed, 19 Sep 2012 15:02:05 +0530
Message-ID: <1348047128-25692-1-git-send-email-kishon@ti.com>
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
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch series adds dt data to get MUSB working in omap4 and omap3

Changes from v2:
* Changes the subject of all the patches to include "ARM: dts:"
* Added reg property and interrupt property for "usb_otg_hs". Previously these
  were obtained from ti,hwmods property.
* Rebased on
  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git devel-dt

Changes from v1:
Just removed the omap-usb2 dt data and sent that as a separate patch.

Kishon Vijay Abraham I (3):
  ARM: dts: Add twl6030-usb data
  ARM: dts: Add twl4030-usb data
  ARM: dts: omap: Add usb_otg and glue data

 arch/arm/boot/dts/omap3-beagle-xm.dts |    6 ++++++
 arch/arm/boot/dts/omap3-evm.dts       |    6 ++++++
 arch/arm/boot/dts/omap3-overo.dtsi    |    6 ++++++
 arch/arm/boot/dts/omap3.dtsi          |   11 +++++++++++
 arch/arm/boot/dts/omap4-panda.dts     |   10 ++++++++++
 arch/arm/boot/dts/omap4-sdp.dts       |   10 ++++++++++
 arch/arm/boot/dts/omap4.dtsi          |   12 ++++++++++++
 arch/arm/boot/dts/twl4030.dtsi        |   21 +++++++++++++++++++++
 arch/arm/boot/dts/twl6030.dtsi        |    5 +++++
 9 files changed, 87 insertions(+)

-- 
1.7.9.5
