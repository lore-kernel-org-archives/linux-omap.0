From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 13/13] OMAP: Add DVFS Documentation
Date: Thu, 03 Feb 2011 17:38:44 -0800
Message-ID: <87oc6swpcr.fsf@ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
	<1295618465-15234-14-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:52955 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753752Ab1BDBis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:38:48 -0500
Received: by mail-yx0-f174.google.com with SMTP id 3so769748yxt.33
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 17:38:47 -0800 (PST)
In-Reply-To: <1295618465-15234-14-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Fri, 21 Jan 2011 19:31:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> Add Documentation for DVFS Framework
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  Documentation/arm/OMAP/omap_dvfs |  111 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 111 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/arm/OMAP/omap_dvfs
>
> diff --git a/Documentation/arm/OMAP/omap_dvfs b/Documentation/arm/OMAP/omap_dvfs
> new file mode 100644
> index 0000000..b026643
> --- /dev/null
> +++ b/Documentation/arm/OMAP/omap_dvfs
> @@ -0,0 +1,111 @@
> +*=============*
> +* DVFS Framework *
> +*=============*
> +(C) 2011 Vishwnath BS <vishwanath.bs@ti.com>, Texas Instruments Incorporated
> +Contents
> +--------
> +1. Introduction
> +2. Data Structure Organization
> +3. DVFS APIs
> +
> +1. Introduction
> +===============
> +DVFS is a technique that uses the optimal operating frequency and voltage to
> +allow a task to be performed in the required amount of time.

Defining the acronym would be helpful here first.

Also, DVFS is not necessarily a "technique".  It also doesn't necessarly
use "optimal" values since the framework would certainly allow you set
optimal settings or sub-optimal settings if you wished.

> +OMAP processors have voltage domains whose voltage can be scaled to
> +various levels depending on which the operating frequencies of certain
> +devices belonging to the domain will also need to be scaled. 

-ENOPARSE

> This voltage
> +frequency tuple is known as Operating Performance Point (OPP). A device
> +can have multiple OPP's. Also a voltage domain could be shared between
> +multiple devices. Also there could be dependencies between various
> +voltage domains for maintaining system performance like VDD<X>
> +should be at voltage v1 when VDD<Y> is at voltage v2.
> +
> +The design of this framework takes into account all the above mentioned points.
> +To summarize the basic design of DVFS framework:-
> +
> +1. Have device opp tables for each device whose operating frequency can be

OPP is an acronym, please capitalize throughout.

> +   scaled. This is easy now due to the existance of hwmod layer which
> +   allow storing of device specific info. 

Except we don't use hwmod to store OPP data.    Not sure of the point here.

> The device opp tables contain
> +   the opp pairs (frequency voltage tuples), the voltage domain pointer
> +   to which the device belongs to, the device specific set_rate and
> +   get_rate API's which will do the actual scaling of the device frequency
> +   and retrieve the current device frequency.

What device OPP tables are you referring to here?  The device OPP tables
in opp*_data.c contain neither voltage domain pointers or get_rate
set_rate APIs.

> +2. Introduce use counting on a per VDD basis. This is to take care multiple
> +   requests to scale a VDD. The VDD will be scaled to the maximum of the
> +   voltages requested.

This isn't done using use-counting, but rather by keeping lists of
request.

> +3. Keep track of all scalable devices belonging to a particular voltage
> +   domain the voltage layer.

This isn't being done in the voltage layer.

> +4. Keep track of frequency requests for each of the device. This will enable
> +   to scale individual devices to different frequency (even w/o scaling voltage
> +   aka frequency throttling)

> +5. Generic dvfs API that can be called by anybody to scale a device opp.

DVFS is an acronym, please capitalize throughout.

> +   This API takes the device pointer and frequency to which the device
> +   needs to be scaled to. This API then internally finds out the voltage
> +   domain to which the device belongs to and the voltage to which the voltage
> +   domain needs to be put to for the device to be scaled to the new frequency
> +   from he device opp table. Then this API will add requested frequency into
> +   the corresponding target device frequency list and add voltage request to
> +   the corresponding vdd. Subsequently it calls voltage scale function which
> +   will find out the highest requested voltage for the given vdd and scales
> +   the voltage to the required one. It also runs through the list of all
> +   scalable devices belonging to this voltage domain and scale them to the
> +   appropriate frequencies using the set_rate pointer in the device opp tables.

Again, the set_rate pointer is not part of the device OPP table.

> +6. Handle inter VDD dependecies.
> +
> +
> +2.  The Core DVFS data structure:
> +=================================
> +
> + 					|-------------------|			|-------------------|
> + 					|User2 (dev2, freq2)|			|User4 (dev4, freq4)|
> + 					|-------^-----------|			|-------^-----------|
> + 							|								|
> + 					|-------|-----------|			|-------|-----------|
> + 					|User1 (dev1, freq1)|			|User3 (dev3, freq3)|(omap_dev_user_list)
> + 					|-------^-----------|			|-------^-----------|
> +                            |                               |
> + 						|---|--------------|             |------------------|
> + 		     |--------->| DEV1 (dev)       |------------>| DEV2 (dev)       |(omap_vdd_dev_list)
> + 			 |			|omap_dev_user_list|			 |omap_dev_user_list|
> + 			 |			|------------------|             |------------------|
> + 			 |
> +   |---------|-----------|
> +   |       VDD_n         |
> +   |  omap_vdd_dev_list  |
> +   |  omap_vdd_user_list |(omap_vdd_dvfs_info)
> +   |                     |
> +   |--------|------------|
> + 			|
> +            |           |------------|  |------------|  |--------------|
> +            |---------> | vdd_user1  |->|  vdd_user2 |->|   vdd_user3  | (omap_vdd_user_list)
> + 						| (dev, volt)|	| (dev, volt)|  | (dev, volt)  |
> + 						|------------|	|------------|	|--------------|

This diagram is not readable.

> +3.  APIs:
> + =====
> + 1. omap_device_scale - Set a new rate at which the device is to operate
> +
> +  Examples:
> +  1. Simple Device scaling:
> +  Suppose module M wants to put device dev1 to frequency f1. Let's say that mdev
> +  is the device * for module M. Then this could be achieved by
> +  ret = omap_device_scale(mdev, dev1, f1)
> +  if (ret)
> +  	/* handle error *.

Why exactly is mdev needed in this case?

> +  2. Frequency Throttling
> +  Suppose say there are 2 modules M1 and M2 in Voltage domain VDDx.
> +  Module M1 wants to set VDDx to OPP100 voltage which means M1 and M2 will
> +  be running at OPP100 frequency. Suppose Module M2 wants to run at OPP50
> +  frequency (say f2_opp50) instead of OPP100. This can be achieved by
> +
> +  /* this operation will place M1 and M2 to run at OPP100 */
> +  ret = omap_device_scale(mdev1, dev1, f1_opp100);
> +  if (ret)
> +  	/* handle error *.
> +
> +  /* This operation will bring M2 to run at f2_opp50 w/o decreasing VDDx voltage */
> +  ret = omap_device_scale(mdev2, dev2, f2_opp50);
> +  if (ret)
> +  	/* handle error *.

What are dev1 and dev2 in this example?

Kevin
