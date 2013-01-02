From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 0/4] pm: Add power off control
Date: Wed, 2 Jan 2013 10:15:14 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAD58C2@DBDE01.ent.ti.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1355464997-19367-1-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
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
To: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>, "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 14, 2012 at 11:33:13, AnilKumar, Chimata wrote:
> Add PM power_off control to rtc driver and PMIC status is set to
> STATUS_OFF to shutdown PMIC if PWR_EN is toggled by RTC module.
> 
> System power off sequence:-
> * Set PMIC STATUS_OFF when PMIC_POWER_EN is pulled low
> * Enable PMIC_POWER_EN in rtc module
> * Set rtc ALARM2 time
> * Enable ALARM2 interrupt
> 
> These patches were tested on am335x-bone (BeagleBone). These patchs
> are based on linux-next.

Hi All,

Happy New Year

Gentle ping to this series

Thanks
AnilKumar
 
> Changes from v3:
> 	- TPS65217 mfd driver changes are accepted so dropped
> 	  from this series.
> 	- With recent changes in the kernel, reboot_mutex held BUG()
> 	  is not seen so removed while(1); from rtc_power_off.
> 	- Removed spinlock before while(1); which is not necessary.
> 
> Changes from v2:
> 	- Incorporated Kevin's comment on v2
> 	  * Enabled RTC in ompa2plus_defconfig
> 
> Changes from v1:
> 	- Incorporated Vaibhav's comments on v1
> 	  * Changed the time rollover logic with the help of
> 	    rtc-lib APIs
> 
> AnilKumar Ch (3):
>   ARM: dts: AM33XX: Set pmic-shutdown-controller for BeagleBone
>   ARM: dts: AM33XX: Enable system power off control in am335x-bone
>   ARM: OMAP2+: omap2plus_defconfig: Enable RTC support
> 
> Colin Foe-Parker (1):
>   rtc: OMAP: Add system pm_power_off to rtc driver
> 
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |    5 ++
>  arch/arm/boot/dts/am335x-bone.dts                  |    6 ++
>  arch/arm/configs/omap2plus_defconfig               |    1 +
>  drivers/rtc/rtc-omap.c                             |   74 +++++++++++++++++++-
>  4 files changed, 85 insertions(+), 1 deletion(-)
> 
> -- 
> 1.7.9.5
> 
> 
