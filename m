From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/5] pm: Add power off control
Date: Tue, 20 Nov 2012 15:18:42 +0530
Message-ID: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
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

Add PM power_off control to rtc driver and PMIC status is set to
STATUS_OFF to shutdown PMIC if PWR_EN is toggled by RTC module.

System power off sequence:-
* Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
* Enable PMIC_POWER_EN in rtc module
* Set rtc ALARM2 time
* Enable ALARM2 interrupt

These patches were tested on am335x-bone (BeagleBone). First patch
is based on linux-next, second patch is based on mfd/master and
rest of the patches are based on linux-omap master.

Changes from v2:
	- Incorporated Kevin's comment on v2
	  * Enabled RTC in ompa2plus_defconfig

Changes from v1:
	- Incorporated Vaibhav's comments on v1
	  * Changed the time rollover logic with the help of
	    rtc-lib APIs

AnilKumar Ch (3):
  ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
  ARM: dts: AM33XX: Enable system power off control in am335x-bone
  ARM: OMAP2+: omap2plus_defconfig: Enable RTC support

Colin Foe-Parker (2):
  rtc: OMAP: Add system pm_power_off to rtc driver
  mfd: tps65217: Set PMIC to shutdown on PWR_EN toggle

 .../devicetree/bindings/regulator/tps65217.txt     |    4 +
 Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
 arch/arm/boot/dts/am335x-bone.dts                  |    6 ++
 arch/arm/configs/omap2plus_defconfig               |    1 +
 drivers/mfd/tps65217.c                             |   12 +++
 drivers/rtc/rtc-omap.c                             |   81 +++++++++++++++++++-
 6 files changed, 108 insertions(+), 1 deletion(-)

-- 
1.7.9.5
