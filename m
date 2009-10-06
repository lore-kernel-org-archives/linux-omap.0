From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on
 OMAP3430
Date: Tue, 6 Oct 2009 20:53:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A3324D8@dbde02.ent.ti.com>
References: <1254741761-31546-1-git-send-email-y>
	<87ljjpzs9p.fsf@deeprootsystems.com> <4ACA2C83.9080400@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A3321EF@dbde02.ent.ti.com>
	<87k4z8u0fh.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A33246A@dbde02.ent.ti.com>
	<8763assixq.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A3324B2@dbde02.ent.ti.com>
	<87my44r30r.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A3324C5@dbde02.ent.ti.com>
 <87eipgr29j.fsf@deeprootsystems.com> <4ACB5F98.2080603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39792 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755509AbZJFPYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 11:24:44 -0400
In-Reply-To: <4ACB5F98.2080603@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Tuesday, October 06, 2009 8:48 PM
>>To: Kevin Hilman
>>Cc: Gopinath, Thara; linux-omap@vger.kernel.org; Gulati, Shweta
>>Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on OMAP3430
>>
>>Kevin Hilman had written, on 10/06/2009 10:05 AM, the following:
>>> "Gopinath, Thara" <thara@ti.com> writes:
>>>
>>>> Will repost the patch with the defconfig option added. So that this can be disabled if not needed.
>>>
>>> ok, please update the changelog as well as describe the 300usec value
>>> in terms of cycles.  IOW, is 300usecs going to work at lower OPPs also?
>>>
>>Could I request for 2 options:
>>a) workaround with no delay (manual save restore) - power savings for
>>boards which dont use the pin
>>b) workaround with 300uSec - for boards which use the pin ->functional
How do we find out if the pin is functional or not? 
>>
>>Also please have a check based on CPU revision and add errata number?
I do not think this is yet published as an errata.
>>
>>--
>>Regards,
>>Nishanth Menon
