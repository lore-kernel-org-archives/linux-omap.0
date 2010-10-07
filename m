From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move init,exit to driver
Date: Thu, 7 Oct 2010 09:17:02 +0200
Message-ID: <4CAD73EE.2040802@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com> <1286363699-9614-2-git-send-email-svadivu@ti.com> <1286363699-9614-3-git-send-email-svadivu@ti.com> <1286363699-9614-4-git-send-email-svadivu@ti.com> <1286363699-9614-5-git-send-email-svadivu@ti.com> <1286363699-9614-6-git-send-email-svadivu@ti.com> <1286363699-9614-7-git-send-email-svadivu@ti.com> <1286363699-9614-8-git-send-email-svadivu@ti.com> <1286363699-9614-9-git-send-email-svadivu@ti.com> <1286363699-9614-10-git-send-email-svadivu@ti.com> <1286363699-9614-11-git-send-email-svadivu@ti.com> <1286363699-9614-12-git-send-email-svadivu@ti.com> <1286363699-9614-13-git-send-email-svadivu@ti.com> <B85A65D85D7EB246BE421B3FB0FBB5930234205060@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC356087034B94AD49@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38602 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018Ab0JGHRL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 03:17:11 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034B94AD49@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Senthil,

On 10/7/2010 8:16 AM, Guruswamy, Senthilvadivu wrote:
>
>> From: Premi, Sanjeev
>> Sent: Wednesday, October 06, 2010 7:49 PM
>> To: Guruswamy, Senthilvadivu; khilman@deeprootsystems.com;
>> tomi.valkeinen@nokia.com; paul@pwsan.com; Hiremath, Vaibhav; linux-
>> omap@vger.kernel.org
>> Subject: RE: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move init,exit to
>> driver
>>
>>> From: linux-omap-owner@vger.kernel.org
>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>>> Guruswamy, Senthilvadivu
>>> Sent: Wednesday, October 06, 2010 4:45 PM
>>> To: khilman@deeprootsystems.com; tomi.valkeinen@nokia.com;
>>> paul@pwsan.com; Hiremath, Vaibhav; linux-omap@vger.kernel.org
>>> Cc: Guruswamy, Senthilvadivu
>>> Subject: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move
>>> init,exit to driver
>>>
>>> From: Senthilvadivu Guruswamy<svadivu@ti.com>
>>>
>>> Move init exit methods to its driver probe,remove.
>>> pdev member has to be maintained by its own drivers.
>>
>> [sp] How is this change related to hwmod mentioned in the
>>       subject line?
> [Senthil] As part of the hwmod design, dispc is made as platform driver.
> Hence the dispc_init and dispc_exit has to be moved from core "omapdisplay"
> Driver to "dss_dispc" platform driver.  Pdev is the platform device structure maintained in dss_dispc driver containing silicon specific info like baseaddr, irqs of DISPC HW.

It is still not a reason to put hwmod in the subject. That is valid for 
most patches of this series.
You have to put the plaform name then the subsystem if this is related 
to the OMAP arch directory, which is DSS, not hwmod DSS.

In the case of DSS driver changes, then you should start with video: 
DSS:, or maybe DSS is enough if there is no possible confusion.

The goal of that is just to highlight in the subject what part of the 
kernel you are changing, since the maintainers are not necessarily the same.

Benoit
