From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move init,exit to driver
Date: Thu, 7 Oct 2010 11:04:17 +0200
Message-ID: <4CAD8D11.2050500@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com> <1286363699-9614-2-git-send-email-svadivu@ti.com> <1286363699-9614-3-git-send-email-svadivu@ti.com> <1286363699-9614-4-git-send-email-svadivu@ti.com> <1286363699-9614-5-git-send-email-svadivu@ti.com> <1286363699-9614-6-git-send-email-svadivu@ti.com> <1286363699-9614-7-git-send-email-svadivu@ti.com> <1286363699-9614-8-git-send-email-svadivu@ti.com> <1286363699-9614-9-git-send-email-svadivu@ti.com> <1286363699-9614-10-git-send-email-svadivu@ti.com> <1286363699-9614-11-git-send-email-svadivu@ti.com> <1286363699-9614-12-git-send-email-svadivu@ti.com> <1286363699-9614-13-git-send-email-svadivu@ti.com> <B85A65D85D7EB246BE421B3FB0FBB5930234205060@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC356087034B94AD49@dbde02.ent.ti.com> <4CAD73E
 E.2040802@ti.com> <FCCFB4CDC6E5564B9182F639FC356087034B94AE77@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49242 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752999Ab0JGJEZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 05:04:25 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034B94AE77@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 10/7/2010 10:44 AM, Guruswamy, Senthilvadivu wrote:
>
>> From: Cousson, Benoit
>> Sent: Thursday, October 07, 2010 12:47 PM
>>
>> Hi Senthil,
>>
>> On 10/7/2010 8:16 AM, Guruswamy, Senthilvadivu wrote:
>>>
>>>> From: Premi, Sanjeev
>>>>
>>>>> From: linux-omap-owner@vger.kernel.org
>>>>>
>>>>> From: Senthilvadivu Guruswamy<svadivu@ti.com>
>>>>>
>>>>> Move init exit methods to its driver probe,remove.
>>>>> pdev member has to be maintained by its own drivers.
>>>>
>>>> [sp] How is this change related to hwmod mentioned in the
>>>>        subject line?
>>> [Senthil] As part of the hwmod design, dispc is made as platform driver.
>>> Hence the dispc_init and dispc_exit has to be moved from core
>> "omapdisplay"
>>> Driver to "dss_dispc" platform driver.  Pdev is the platform device
>> structure maintained in dss_dispc driver containing silicon specific info
>> like baseaddr, irqs of DISPC HW.
>>
>> It is still not a reason to put hwmod in the subject. That is valid for
>> most patches of this series.
>> You have to put the plaform name then the subsystem if this is related
>> to the OMAP arch directory, which is DSS, not hwmod DSS.
>>
>> In the case of DSS driver changes, then you should start with video:
>> DSS:, or maybe DSS is enough if there is no possible confusion.
>>
>> The goal of that is just to highlight in the subject what part of the
>> kernel you are changing, since the maintainers are not necessarily the
>> same.
> [Senthil] If "hwmod" is creating confusion, it could be removed.
> Is it an ack for this patch series considering that "change in the header" is the only comment to be incorporated?

Mmm, not really, but since it is the subject, this is the very first 
things you see. That why it is important to provide good subject :-)

I'll have a look at this series before the end of the week.

Benoit

