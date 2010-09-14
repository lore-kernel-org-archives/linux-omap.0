From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 4/8] OMAP3: PM: Adding smartreflex device file.
Date: Tue, 14 Sep 2010 09:03:19 -0700
Message-ID: <8739tctirc.fsf@deeprootsystems.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-5-git-send-email-thara@ti.com>
	<878w3ucor1.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0329441CF0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35156 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab0INQDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 12:03:23 -0400
Received: by pxi10 with SMTP id 10so2478555pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 09:03:23 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0329441CF0@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Tue, 14 Sep 2010 21:06:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Derrick, David" <dderrick@ti.com>

"Gopinath, Thara" <thara@ti.com> writes:

[...]

>>>> +	sr_data->device_enable = omap_device_enable;
>>>> +	sr_data->device_shutdown = omap_device_shutdown;
>>>> +	sr_data->device_idle = omap_device_idle;
>>>
>>>Please drop these and use runtime PM as suggested in previous patch.
>
> At this stage I am not sure whether we should make smartreflex patches
> dependent on runtime pm. I would like to do the conversion once and for all
> once runtime pm is up streamed. 

Using runtime PM instead of the sr_data-> calls will simplify this
patch.  

Also, runtime PM core for OMAP will be merged this merge window.  If you
use my 'pm-core' branch for testing, you will have it included in your
baseline, along with all the other things that are targeted for merge in
2.6.37.

Kevin


