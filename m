From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Thu, 1 Jul 2010 09:50:44 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323763D43@dbde02.ent.ti.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
	<1277423084-25528-11-git-send-email-khilman@deeprootsystems.com>
	<87y6dxrblk.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323763838@dbde02.ent.ti.com>
 <87ocesjlwf.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323763D1C@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5E417E1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43737 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab0GAEUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 00:20:40 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5E417E1@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>



>>-----Original Message-----
>>From: Shilimkar, Santosh
>>Sent: Thursday, July 01, 2010 9:46 AM
>>To: Gopinath, Thara; Kevin Hilman
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com
>>Subject: RE: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Gopinath, Thara
>>> Sent: Thursday, July 01, 2010 9:35 AM
>>> To: Kevin Hilman
>>> Cc: linux-omap@vger.kernel.org; paul@pwsan.com
>>> Subject: RE: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
>>>
>>>
>>>
>>> >>-----Original Message-----
>>> >>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>> >>Sent: Thursday, July 01, 2010 2:09 AM
>>> >>To: Gopinath, Thara
>>> >>Cc: linux-omap@vger.kernel.org; paul@pwsan.com
>>> >>Subject: Re: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
>>> >>
>>> >>"Gopinath, Thara" <thara@ti.com> writes:
>>> >>
>>> >>[...]
>>> >>
>>> >>>>>+static int __init omap_common_pm_init(void)
>>> >>>>>+{
>>> >>>>>+	omap_init_processor_devices();
>>> >>>>>+	omap_pm_if_init();
>>> >>>>>+
>>> >>>>>+	return 0;
>>> >>>>>+}
>>> >>>>>+device_initcall(omap_common_pm_init);
>>> >>
>>> >>>
>>> >>> But I guess opp layer is still getting initialized before this. Esp if
>>> >>> the board files are initializing the opp structures. Or do you have a
>>> >>> patch to fix it in some other branch ?
>>> >>>
>>> >>
>>> >>The common OPP init will be done in this function as well (see current
>>> >>PM branch.)  Board files no longer do OPP init (by default) as it is
>>> >>handled by common code.  Only boards that add OPPs need to call the init
>>> >>function, and we'll have to figure out way to handle that late.
>>>
>>> Yes you are correct. The common OPP init is done in this function. One
>>> other thing I am a bit worried about is the order of initializations. The
>>> order should be
>>> 				Opp layer
>>> 				Voltage layer
>>> 				Smartreflex device layer.
>>>
>>> Presently all three layers are device_initcalls. The sequence is
>>> maintained due to the way these drivers are compiled in. We need to make
>>> them work independent of the way the drivers are compiled.
>>> One way is to have the omap_common_pm_init call into the inits of all
>>> these layers sequentially and
>>> remove the separate init calls. Any other suggestion anyone?
>>>
>>Grouping the initcalls is good idea but with this you can never be
>>able to build any of these as loadable modules.
>>This is valid only if any of above you plan to build as loadable module

I do not think we need to build voltage, opp and smartreflex as modules. I would consider them as system critical layers and should be part of the basic kernel. Do you see a use case where these layers need to be modules? Also all these layers are stand alone libraries. Not registered with any bus or anything. So we will have to do some work if we need to load them as modules.

Regards
Thara
