From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/13] OMAP: Introduce API to return a device list associated with a voltage domain
Date: Thu, 16 Sep 2010 08:23:21 -0700
Message-ID: <87y6b1d85y.fsf@deeprootsystems.com>
References: <1282130412-12027-1-git-send-email-thara@ti.com>
	<1282130412-12027-5-git-send-email-thara@ti.com>
	<87d3sxdlwl.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03294424CB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39729 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab0IPPXn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 11:23:43 -0400
Received: by pzk34 with SMTP id 34so366262pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 08:23:42 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03294424CB@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Thu, 16 Sep 2010 15:40:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>>Sent: Thursday, September 02, 2010 6:04 AM
>>>To: Gopinath, Thara
>>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Sripathy, Vishwanath; Sawant, Anand; Cousson, Benoit
>>>Subject: Re: [PATCH 04/13] OMAP: Introduce API to return a device list associated with a voltage
>>>domain
>>>
>>>Thara Gopinath <thara@ti.com> writes:
>>>
>>>> This patch adds an API in the opp layer that
>>>> can be used by the voltage layer to get a list of all the
>>>> scalable devices belonging to a particular voltage domain.
>>>> This API is to be typically called only once by the voltage
>>>> layer per voltage domain instance and the device list should
>>>> be stored. This approach makes it easy during dvfs to scale
>>>> all the devices associated with a voltage domain and then
>>>> scale the voltage domain.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>>
>>>I don't think the OPP layer is the right place for this after all.
>>>
>>>How about something like this in the voltage layer:
>>>
>>>  omap_voltage_add_device(struct voltagedomain *voltdm, struct device *dev)
>>>
>>>During omap_device_build(), if the hwmod has a voltage domain, it
>>>calls this function to register it with the voltage layer.
>
> This mandates voltage layer to be initialized before the first omap_device_build
> has happened. I think that is going to be a very confusing sequencing. Also today
> voltage layer init happens later in the system.

If we split into an early and late init, that would help here too.

Kevin
