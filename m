From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH v4 2/9] OMAP3: PM: Adding smartreflex driver support.
Date: Fri, 29 Oct 2010 10:30:41 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D398AEE@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB030D310D1D@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB035ECA9D57@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB030D398ADB@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB035ECA9E8B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33458 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab0J2FAt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 01:00:49 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035ECA9E8B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>


> >>> >>> -----Original Message-----
> >>> >>> From: linux-omap-owner@vger.kernel.org
> >>> >>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Thara
> Gopinath
> >>> >>> Sent: Wednesday, October 27, 2010 9:41 PM
> >>> >>> To: linux-omap@vger.kernel.org
> >>> >>> Cc: paul@pwsan.com; khilman@deeprootsystems.com; Cousson,
> >>> >>> Benoit; Sripathy, Vishwanath; Sawant, Anand; Gopinath, Thara
> >>> >>> Subject: [PATCH v4 2/9] OMAP3: PM: Adding smartreflex driver
> support.
> >>> >>>
> >>> >>> SmartReflex modules do adaptive voltage control for real-time
> >>> >>> voltage adjustments. With Smartreflex the power supply voltage
> >>> >>> can be adapted to the silicon performance(manufacturing process,
> >>> >>> temperature induced performance, age induced performance etc).
> >>> >>>
> >>> >>> There are differnet classes of smartreflex implementation.
> >>> >>> 	Class-0: Manufacturing Test Calibration
> >>> >>> 	Class-1: Boot-Time Software Calibration
> >>> >>> 	Class-2: Continuous Software Calibration
> >>> >>> 	Class-3: Continuous Hardware Calibration
> >>> >>> 	Class-4: Fully Integrated Power Management
> >>> >>>
> >>> >>> OMAP3 has two smartreflex modules one associated with VDD MPU and
> the
> >>> >>> other associated with VDD CORE.
> >>> >>> This patch adds support for  smartreflex driver. The driver
> >>> >>> is designed
> >>> >>> for Class-1 , Class-2 and Class-3 support and is  a platform
> driver.
> >>> >>> Smartreflex driver can be enabled through a Kconfig option
> >>> >>> "SmartReflex support" under "System type"->"TI OMAP
> >>> >>> implementations" menu.
> >>> >>>
> >>> >>> Smartreflex autocompensation feature can be enabled runtime
> through
> >>> >>> a debug fs option.
> >>> >>> To enable smartreflex autocompensation feature
> >>> >>> 	echo 1 > /debug/voltage/vdd_<X>/smartreflex/autocomp
> >>> >>> To disable smartreflex autocompensation feature
> >>> >>> 	echo 0 > /debug/voltage/vdd_<X>/smartreflex/autocomp
> >>> >>>
> >>> >>> where X can be mpu, core , iva etc.
> >>> >>>
> >>> >>> This patch contains code originally in linux omap pm branch.
> >>> >>> Major contributors to this driver are
> >>> >>> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
> >>> >>> Nishant Menon, Kevin Hilman.
> >>> >>>
> >>> >>> Signed-off-by: Thara Gopinath <thara@ti.com>
> >>> >>> ---
> >>> >>>  arch/arm/mach-omap2/Makefile                  |    1 +
> >>> >>>  arch/arm/mach-omap2/smartreflex.c             |  975
> >>> >>> +++++++++++++++++++++++++
> >>> >>>  arch/arm/plat-omap/Kconfig                    |   36 +
> >>> >>>  arch/arm/plat-omap/include/plat/smartreflex.h |  271 +++++++
> >>> >>>  4 files changed, 1283 insertions(+), 0 deletions(-)
> >>> >>>  create mode 100644 arch/arm/mach-omap2/smartreflex.c
> >>> >>>  create mode 100644 arch/arm/plat-omap/include/plat/smartreflex.h
> >>> >>>
> >>> >>
> >>> >><<snip>>
> >>> >>
> >>> >>> +static int __init omap_sr_probe(struct platform_device *pdev)
> >>> >>> +{
> >>> >>> +	struct omap_sr *sr_info = kzalloc(sizeof(struct
> >>> >>> omap_sr), GFP_KERNEL);
> >>> >>> +	struct omap_device *odev = to_omap_device(pdev);
> >>> >>
> >>> >>Patch3 should be ordered before patch2 in your series. Otherwise,
> >>> >>this would fail during a git-bisect.
> >>>
> >>> Again why ?? All patches individually compile and boot.
> >>
> >>omap_device_build() for this device is being done in the next patch.
> >>Hence I gave this input. But I believe that this does not harm because
> >>the probe would not get called. Correct me if I am wrong.
> 
> Exactly probe will not get called. So I do not think the patch ordering
> needs to change.

Okay. But for the other patch, I think it is required to reorder the patch 
series because the oh data is accessed in omap_device_build() and omap_hwmod_each_by_class(), but oh data is not filled by then.

> 
> Regards
> Thara
