From: Vaibhav Hiremath <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] arm/dts: AM33XX: Add reg and interrupt property for all
 nodes
Date: Mon, 27 Aug 2012 18:01:52 +0530
Message-ID: <1346070714-6122-1-git-send-email-hvaibhav@ti.com>
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
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series is trivial patch-series and should be considered as
preparation for the future where we supposed to get rid of
hwmod dependency.

1/2: Converts all hex numbers to lowercase, fixing inconsistency
2/2: Add reg and interrupt property  to all device/module nodes inside
     DTS files. 

Although currently hwmod overwrites resources, I have validated this
patch series by changing the omap_device layer to respect DT resources
and boot Tested on BeagleBone platform.
I will be submitting the changes for omap_device layer as well, still
needs to fix on certain things.

Vaibhav Hiremath (2):
  arm/dts: AM33XX: Convert all hex numbers to lower-case
  arm/dts: AM33XX: Specify reg and interrupt property for all nodes

 arch/arm/boot/dts/am335x-bone.dts |    2 +-
 arch/arm/boot/dts/am335x-evm.dts  |    2 +-
 arch/arm/boot/dts/am33xx.dtsi     |   62 +++++++++++++++++++++++++++++++------
 3 files changed, 54 insertions(+), 12 deletions(-)
