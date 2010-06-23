From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 05/12] OMAP: create omap_devices for MPU, DSP, L3
Date: Wed, 23 Jun 2010 20:33:55 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366AC83@dbde02.ent.ti.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
	<1276733833-18510-6-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032366AB60@dbde02.ent.ti.com>
 <878w6524ae.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39598 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753036Ab0FWPED convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 11:04:03 -0400
In-Reply-To: <878w6524ae.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, June 23, 2010 8:19 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; Menon, Nishanth; Cousson, Benoit
>>Subject: Re: [PATCH 05/12] OMAP: create omap_devices for MPU, DSP, L3
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>>>>-----Original Message-----
>>>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>>>Sent: Thursday, June 17, 2010 5:47 AM
>>>>>To: linux-omap@vger.kernel.org
>>>>>Cc: Menon, Nishanth; Gopinath, Thara; Cousson, Benoit
>>>>>Subject: [PATCH 05/12] OMAP: create omap_devices for MPU, DSP, L3
>>>>>
>>>>>Create simple omap_devices for the main processors and busses.
>>>>>
>>>>>This is required to support the forth-coming device-based OPP
>>>>>approach, where OPPs are managed and tracked at the omap_device and
>>>>>hwmod level.
>>>>>
>>>>>Because these omap_devices are based on platform_devices, they cannot
>>>>>be created until the driver core has been initialized.  Therefore, move
>>>>>the init of these into a device_initcall().  Also, OMAP PM init cannot
>>>>>be done until after this step as it depends on the OPP layer.
>>>>>
>>>>>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>[...]
>>
>>>>>+
>>>>>+static int __init omap2_late_common_init(void)
>>>>>+{
>>>>>+	omap_init_processor_devices();
>>>>>+
>>>>> 	/* initialize the opp table if board file has not done so */
>>>>> 	omap3_pm_init_opp_table();
>>>>>
>>>>>+	omap_pm_if_init();
>>>>>+
>>>>>+	return 0;
>>>>>+}
>>>>>+device_initcall(omap2_late_common_init);
>>> Hello Kevin,
>>>
>>> Any particular reason for making this a late init and not keeping
>>> this a part of init_common_hw?  The reason is the board files also
>>> have an option of calling/ overriding omap3_pm_init_opp_table. This
>>> happens really early in init_irq. (Refer board_3430sdp.c). So if a
>>> board file calls into omap3_pm_init_opp_table, the opp
>>> initializations will happen before the omap_device pointers are
>>> build for mpu, iva and l3. So the dev pointers stored as part of
>>> dev_opp tables will be screwed up.  My personal preference would be
>>> to call the omap_init_processor_devices just after
>>> hwmod_late_init. This will remove any race conditions as above.
>>
>>I agree, I changed this yesterday and the current pm-wip/hwmods is
>>doing exactly this.
>>
>>The initial reason for the late initcall was because omap_device_build
>>creates platform_devices and devices, but the driver core was not
>>yet initialized at this point.
>>
>>To fix, I now create these devices as early platform devices so that
>>the init sequence can remain the same.
>>
>>I'll be posting an updated version of this series today.

But then early platform devices do not create a dev pointer. So you do two initializations, eh?

Regards
Thara

