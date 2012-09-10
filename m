From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] ARM: dts: AM33xx: Correct gpio labels to match docs
Date: Mon, 10 Sep 2012 15:45:10 -0400
Message-ID: <1347306312-31533-1-git-send-email-mporter@ti.com>
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
To: Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Changes since v1:
	- Series now applies on top of Anil's AM33XX DTS series
 
This series applies on top of the for_3.7/dts/ branch and Anil's
"[v7,2/3] arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone"
patch that is part of the overall series adding led and pinctrl DTS data
for AM33xx.

It is intended to correct the current labeling of gpios in the DTS before
too many more drivers are submitted for AM33xx that have gpios not matching
the docs.

Matt Porter (2):
  ARM: dts: AM33XX: fix gpio node numbering to match hardware
  ARM: dts: AM33XX: adjust leds to use the corrected gpio label

 arch/arm/boot/dts/am335x-bone.dts |    8 ++++----
 arch/arm/boot/dts/am33xx.dtsi     |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.7.9.5
