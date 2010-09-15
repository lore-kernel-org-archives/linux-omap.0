From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCHv2 4/8] OMAP3: PM: Adding smartreflex device file.
Date: Wed, 15 Sep 2010 11:42:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0329441E9C@dbde02.ent.ti.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
	<1281707231-3026-5-git-send-email-thara@ti.com>
	<878w3ucor1.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0329441CF0@dbde02.ent.ti.com>
 <8739tctirc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53693 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760Ab0IOGM3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 02:12:29 -0400
In-Reply-To: <8739tctirc.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Derrick, David" <dderrick@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Tuesday, September 14, 2010 9:33 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand;
>>Derrick, David
>>Subject: Re: [PATCHv2 4/8] OMAP3: PM: Adding smartreflex device file.
>>
>>"Gopinath, Thara" <thara@ti.com> writes:
>>
>>[...]
>>
>>>>>> +	sr_data->device_enable = omap_device_enable;
>>>>>> +	sr_data->device_shutdown = omap_device_shutdown;
>>>>>> +	sr_data->device_idle = omap_device_idle;
>>>>>
>>>>>Please drop these and use runtime PM as suggested in previous patch.
>>>
>>> At this stage I am not sure whether we should make smartreflex patches
>>> dependent on runtime pm. I would like to do the conversion once and for all
>>> once runtime pm is up streamed.
>>
>>Using runtime PM instead of the sr_data-> calls will simplify this
>>patch.
>>
>>Also, runtime PM core for OMAP will be merged this merge window.  If you
>>use my 'pm-core' branch for testing, you will have it included in your
>>baseline, along with all the other things that are targeted for merge in
>>2.6.37.

Is this branch latest kernel + stuff targeted for 2.6.37 ??

Regards
Thara

