From: archit taneja <archit@ti.com>
Subject: Re: [PATCH 4/4] OMAP: DSS2: Check for SDI HW before accessing SDI
 registers
Date: Tue, 1 Mar 2011 13:16:40 +0530
Message-ID: <4D6CA460.7080002@ti.com>
References: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com>	 <1298554461-9879-4-git-send-email-tomi.valkeinen@ti.com>	 <4D6C96E9.20206@ti.com> <1298965117.2011.17.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46127 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482Ab1CAHnw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 02:43:52 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p217hndh030539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 01:43:51 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p217hmNx003072
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 13:13:48 +0530 (IST)
In-Reply-To: <1298965117.2011.17.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tuesday 01 March 2011 01:08 PM, Valkeinen, Tomi wrote:
> On Tue, 2011-03-01 at 00:49 -0600, Taneja, Archit wrote:
>> Hi,
>>
>> On Thursday 24 February 2011 07:04 PM, Valkeinen, Tomi wrote:
>>> Only OMAP 3430 hardware has SDI support. The availability of SDI HW can
>>> be found out by checking if the LCD channel supports SDI displays.
>>>
>>> This patch checks for SDI HW support before accessing SDI registers,
>>> which fixes a crash on OMAP4 when SDI SW support is compiled in.
>>>
>>> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
>>> ---
>>>    drivers/video/omap2/dss/display.c |   10 ++++++++++
>>>    drivers/video/omap2/dss/dss.c     |   29 ++++++++++++++++++-----------
>>>    2 files changed, 28 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
>>> index 3f4fa0b..58459f4 100644
>>> --- a/drivers/video/omap2/dss/display.c
>>> +++ b/drivers/video/omap2/dss/display.c
>>> @@ -30,6 +30,7 @@
>>>
>>>    #include<plat/display.h>
>>>    #include "dss.h"
>>> +#include "dss_features.h"
>>>
>>>    static LIST_HEAD(display_list);
>>>
>>> @@ -392,6 +393,15 @@ void dss_init_device(struct platform_device *pdev,
>>>    	struct device_attribute *attr;
>>>    	int i;
>>>    	int r;
>>> +	enum omap_display_type supported;
>>> +
>>> +	supported = dss_feat_get_supported_displays(dssdev->channel);
>>> +
>>> +	if (!(supported&   dssdev->type)) {
>>> +		DSSERR("Unsupported display interface for display '%s'.\n",
>>> +				dssdev->name);
>>> +		return;
>>> +	}
>>
>> This would make it necessary to specify the channel in the board file,
>> especially digit. I think this patch should also add the channel
>> parameters for all board files which add a tv display.
>
> Argh. You're right, dssdev->channel is not what I thought it is. That is
> rather confusing. I remember this was discussed when that
> dssdev->channel was introduced.
>
> I believe this should work if I change dssdev->channel to
> dssdev->manager->id.
>

I am not sure it will work, dss_init_device is called before 
dss_recheck_connections which sets the manager for the display.

Hence, dssdev->manager will be NULL.

> But this dssdev->channel has to be fixed somehow, I'm 100% sure this
> won't be the last time somebody tries to use it =).
>

I think after the managers are set, we should somehow make the channel 
parameter "void".

Archit
