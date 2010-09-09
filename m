From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/7] omap4: Temporary fix silicon version detection
Date: Thu, 9 Sep 2010 10:55:38 -0500
Message-ID: <4C89037A.6090706@ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com> <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com> <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com> <20100909114255.GK21060@legolas.emea.dhcp.ti.com> <4C88C940.6070000@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D3A37@dbde02.ent.ti.com> <20100909120746.GB17000@legolas.emea.dhcp.ti.com> <4C88D75C.4020209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42236 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101Ab0IIPzn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Sep 2010 11:55:43 -0400
In-Reply-To: <4C88D75C.4020209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>


On 9/9/2010 7:47 AM, Cousson, Benoit wrote:
> On 9/9/2010 2:07 PM, Balbi, Felipe wrote:
>> Hi Santosh,
>>
>> On Thu, Sep 09, 2010 at 07:02:46AM -0500, Shilimkar, Santosh wrote:
>>> Felipe is suggesting not to add this support where as you want to
>>> have this support.
>>>
>>> Sorry if I haven't understood the comment. Care to clarify
>>
>> no, I suggested not to revert :-) So, just change the comment saying why
>> you need that extra check and remove the "this patch should be reverted
>> later" part :-)
>
> We are fully aligned. On the other hand if the number of buggy devices
> is very limited and not available outside TI, we'd better drop that
> patch. But I'm afraid it is not the case :-(

I believe that just this week we had a case of a "buggy device" turning 
up on one of our customer's blaze boards that was upgraded to ES2.0 but 
appeared to be ES1.0. So this patch is good to have in the mainline.

Cheers
Jon
