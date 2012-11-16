From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/4] pm: Add power off control
Date: Fri, 16 Nov 2012 17:38:22 +0530
Message-ID: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
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
To: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add PM power_off control to rtc driver, along with this PMIC status
is set to STATUS_OFF to shutdown PMIC if PWR_EN is toggled by RTC
module.

System power off sequence:-
* Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
* Enable PMIC_POWER_EN in rtc module
* Set rtc ALARM2 time
* Enable ALARM2 interrupt

These patches were tested on AM335x-Bone.

Changes from v1:
	- Incorporated Vaibhav's comments on v1
	  * Changed the time rollover logic with the help of
	    rtc-lib APIs

AnilKumar Ch (2):
  ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
  ARM: dts: AM33XX: Enable system power off control in am335x-bone

Colin Foe-Parker (2):
  mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
  rtc: OMAP: Add system pm_power_off to rtc driver

 .../devicetree/bindings/regulator/tps65217.txt     |    4 +
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
 arch/arm/boot/dts/am335x-bone.dts                  |    6 ++
 drivers/mfd/tps65217.c                             |   12 +++
 drivers/rtc/rtc-omap.c                             |   81 +++++++++++++++++++-
 5 files changed, 107 insertions(+), 1 deletion(-)

-- 
1.7.9.5
