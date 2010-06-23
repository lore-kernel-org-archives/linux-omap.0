From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 05/12] OMAP: create omap_devices for MPU, DSP, L3
Date: Wed, 23 Jun 2010 07:48:41 -0700
Message-ID: <878w6524ae.fsf@deeprootsystems.com>
References: <1276733833-18510-1-git-send-email-khilman@deeprootsystems.com>
	<1276733833-18510-6-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032366AB60@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52395 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab0FWOsq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 10:48:46 -0400
Received: by pwj8 with SMTP id 8so1454005pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 07:48:45 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032366AB60@dbde02.ent.ti.com> (Thara Gopinath's message of "Wed\, 23 Jun 2010 16\:31\:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Thursday, June 17, 2010 5:47 AM
>>>To: linux-omap@vger.kernel.org
>>>Cc: Menon, Nishanth; Gopinath, Thara; Cousson, Benoit
>>>Subject: [PATCH 05/12] OMAP: create omap_devices for MPU, DSP, L3
>>>
>>>Create simple omap_devices for the main processors and busses.
>>>
>>>This is required to support the forth-coming device-based OPP
>>>approach, where OPPs are managed and tracked at the omap_device and
>>>hwmod level.
>>>
>>>Because these omap_devices are based on platform_devices, they cannot
>>>be created until the driver core has been initialized.  Therefore, move
>>>the init of these into a device_initcall().  Also, OMAP PM init cannot
>>>be done until after this step as it depends on the OPP layer.
>>>
>>>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
[...]

>>>+
>>>+static int __init omap2_late_common_init(void)
>>>+{
>>>+	omap_init_processor_devices();
>>>+
>>> 	/* initialize the opp table if board file has not done so */
>>> 	omap3_pm_init_opp_table();
>>>
>>>+	omap_pm_if_init();
>>>+
>>>+	return 0;
>>>+}
>>>+device_initcall(omap2_late_common_init);
> Hello Kevin,
>
> Any particular reason for making this a late init and not keeping
> this a part of init_common_hw?  The reason is the board files also
> have an option of calling/ overriding omap3_pm_init_opp_table. This
> happens really early in init_irq. (Refer board_3430sdp.c). So if a
> board file calls into omap3_pm_init_opp_table, the opp
> initializations will happen before the omap_device pointers are
> build for mpu, iva and l3. So the dev pointers stored as part of
> dev_opp tables will be screwed up.  My personal preference would be
> to call the omap_init_processor_devices just after
> hwmod_late_init. This will remove any race conditions as above.

I agree, I changed this yesterday and the current pm-wip/hwmods is
doing exactly this.

The initial reason for the late initcall was because omap_device_build
creates platform_devices and devices, but the driver core was not
yet initialized at this point.

To fix, I now create these devices as early platform devices so that
the init sequence can remain the same.

I'll be posting an updated version of this series today.

Kevin
