From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v4 2/9] OMAP3: PM: Adding smartreflex driver support.
Date: Thu, 28 Oct 2010 20:57:33 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035ECA9D57@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB030D310D1D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50237 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab0J1P1j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Oct 2010 11:27:39 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D310D1D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Varadarajan, Charulatha
>>Sent: Thursday, October 28, 2010 11:09 AM
>>To: Gopinath, Thara; linux-omap@vger.kernel.org
>>Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand; Gopinath, Thara
>>Subject: RE: [PATCH v4 2/9] OMAP3: PM: Adding smartreflex driver support.
>>
>>
>>Thara,
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Thara Gopinath
>>> Sent: Wednesday, October 27, 2010 9:41 PM
>>> To: linux-omap@vger.kernel.org
>>> Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson,
>>> Benoit; Sripathy, Vishwanath; Sawant, Anand; Gopinath, Thara
>>> Subject: [PATCH v4 2/9] OMAP3: PM: Adding smartreflex driver support.
>>>
>>> SmartReflex modules do adaptive voltage control for real-time
>>> voltage adjustments. With Smartreflex the power supply voltage
>>> can be adapted to the silicon performance(manufacturing process,
>>> temperature induced performance, age induced performance etc).
>>>
>>> There are differnet classes of smartreflex implementation.
>>> 	Class-0: Manufacturing Test Calibration
>>> 	Class-1: Boot-Time Software Calibration
>>> 	Class-2: Continuous Software Calibration
>>> 	Class-3: Continuous Hardware Calibration
>>> 	Class-4: Fully Integrated Power Management
>>>
>>> OMAP3 has two smartreflex modules one associated with VDD MPU and the
>>> other associated with VDD CORE.
>>> This patch adds support for  smartreflex driver. The driver
>>> is designed
>>> for Class-1 , Class-2 and Class-3 support and is  a platform driver.
>>> Smartreflex driver can be enabled through a Kconfig option
>>> "SmartReflex support" under "System type"->"TI OMAP
>>> implementations" menu.
>>>
>>> Smartreflex autocompensation feature can be enabled runtime through
>>> a debug fs option.
>>> To enable smartreflex autocompensation feature
>>> 	echo 1 > /debug/voltage/vdd_<X>/smartreflex/autocomp
>>> To disable smartreflex autocompensation feature
>>> 	echo 0 > /debug/voltage/vdd_<X>/smartreflex/autocomp
>>>
>>> where X can be mpu, core , iva etc.
>>>
>>> This patch contains code originally in linux omap pm branch.
>>> Major contributors to this driver are
>>> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
>>> Nishant Menon, Kevin Hilman.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/Makefile                  |    1 +
>>>  arch/arm/mach-omap2/smartreflex.c             |  975
>>> +++++++++++++++++++++++++
>>>  arch/arm/plat-omap/Kconfig                    |   36 +
>>>  arch/arm/plat-omap/include/plat/smartreflex.h |  271 +++++++
>>>  4 files changed, 1283 insertions(+), 0 deletions(-)
>>>  create mode 100644 arch/arm/mach-omap2/smartreflex.c
>>>  create mode 100644 arch/arm/plat-omap/include/plat/smartreflex.h
>>>
>>
>><<snip>>
>>
>>> +static int __init omap_sr_probe(struct platform_device *pdev)
>>> +{
>>> +	struct omap_sr *sr_info = kzalloc(sizeof(struct
>>> omap_sr), GFP_KERNEL);
>>> +	struct omap_device *odev = to_omap_device(pdev);
>>
>>Patch3 should be ordered before patch2 in your series. Otherwise,
>>this would fail during a git-bisect.

Again why ?? All patches individually compile and boot.
>>
>>> +	struct omap_sr_data *pdata = pdev->dev.platform_data;
>>> +	struct resource *mem, *irq;
>>> +	struct dentry *vdd_dbg_dir, *dbg_dir;
>>> +	int ret = 0;
>>> +
>>> +	if (!sr_info) {
>>> +		dev_err(&pdev->dev, "%s: unable to allocate sr_info\n",
>>> +			__func__);
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	if (!pdata) {
>>> +		dev_err(&pdev->dev, "%s: platform data
>>> missing\n", __func__);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	if (!mem) {
>>> +		dev_err(&pdev->dev, "%s: no mem resource\n", __func__);
>>> +		ret = -ENODEV;
>>> +		goto err_free_devinfo;
>>> +	}
>>> +
>>> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>>> +
>>> +	pm_runtime_enable(&pdev->dev);
>>> +
>>> +	sr_info->pdev = pdev;
>>> +	sr_info->srid = pdev->id;
>>> +	sr_info->voltdm = pdata->voltdm;
>>> +	sr_info->autocomp_active = false;
>>> +	sr_info->ip_type = odev->hwmods[0]->class->rev;
>>
>>I am not sure if it is okay to get hwmods-info in the driver.
>>To avoid too many indirections, it can be obtained before
>>omap_device_build() of the device and passed to the driver.
mmm. yep we could do it also. Maybe Kevin/Benoit needs to confirm the
correct way of doing this.

Regards
Thara
>>
>>> +	sr_info->base = ioremap(mem->start, resource_size(mem));
>>> +	if (!sr_info->base) {
>>> +		dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
>>> +		ret = -ENOMEM;
>>> +		goto err_release_region;
>>> +	}
>>
>><<snip>>
>>
>>-V Charulatha
