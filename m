From: archit taneja <archit@ti.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Functions to request/release DSI VCs
Date: Tue, 1 Mar 2011 10:47:00 +0530
Message-ID: <4D6C814C.5070307@ti.com>
References: <1298882849-7432-1-git-send-email-archit@ti.com>	 <1298882849-7432-2-git-send-email-archit@ti.com> <1298897516.9809.48.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41491 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab1CAFON (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 00:14:13 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p215EAs7000335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 23:14:12 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p215E9SG025646
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 10:44:10 +0530 (IST)
In-Reply-To: <1298897516.9809.48.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Monday 28 February 2011 06:21 PM, Valkeinen, Tomi wrote:
> On Mon, 2011-02-28 at 02:47 -0600, Taneja, Archit wrote:
>> Introduce functions which request and release VC's. This will be used in panel
>> drivers in their probes.
>>
>> omap_dsi_request_vc() takes in the pointer to the omap_dss_device, the VC_ID
>> parameter which goes into the header of the DSI packets, and returns a Virtual
>> channel number (or virtual channel register set) which it can use.
>>
>> omap_dsi_releae_vc() takes the omap_dss_device pointer and frees all VCs which
>> were used by that device.
>>
>> Initialisation of VC parameters is done in dsi_init().
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>
>> ---
>>   arch/arm/plat-omap/include/plat/display.h |    3 ++
>>   drivers/video/omap2/dss/dsi.c             |   55 ++++++++++++++++++++++++++---
>>   2 files changed, 53 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
>> index d45f107..0057259 100644
>> --- a/arch/arm/plat-omap/include/plat/display.h
>> +++ b/arch/arm/plat-omap/include/plat/display.h
>> @@ -560,6 +560,9 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
>>   		int channel,
>>   		u16 x, u16 y, u16 w, u16 h,
>>   		void (*callback)(int, void *), void *data);
>> +int omap_dsi_request_vc(struct omap_dss_device *dssdev, int vc_id,
>> +		int *channel);
>> +void omap_dsi_release_vc(struct omap_dss_device *dssdev);
>
> The release function is misnamed. It's actually release_all_vcs.
> However, I think the request and release functions should match:
> request/release one vc.
>
> So perhaps something like:
>
> void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel);
>
> dssdev is not really needed there, but can be used for checking validity
> of the release call.

Yes, this is better.

>
> Also, about the returned channel value. It is something that the panel
> driver should not use for anything else than to pass to DSI functions.
> Perhaps this would be a good case for typedeffing (see CodingStyle,
> chapter 5, part a). dsi_channel_t? Well, we can think about this later.
>
> In the future we could possibly encode the DSI module number in the
> channel also.
>

That's a good idea.


<snip>

>>   }
>>
>> +int omap_dsi_request_vc(struct omap_dss_device *dssdev, int vc_id, int *channel)
>> +{
>> +	int p = dsi.num_vc_used;
>> +
>> +	if (p>= 4) {
>> +		DSSERR("cannot get VC for display %s", dssdev->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dsi.vc[p].dssdev = dssdev;
>> +	dsi.vc[p].vc_id = vc_id;
>> +	*channel = p;
>> +
>> +	dsi.num_vc_used += 1;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(omap_dsi_request_vc);
>> +
>> +void omap_dsi_release_vc(struct omap_dss_device *dssdev)
>> +{
>> +	int i, num_vc_used_disp = 0;
>> +
>> +	for (i = 0; i<  4; i++) {
>> +		if (dsi.vc[i].dssdev == dssdev) {
>> +			dsi.vc[i].dssdev = NULL;
>> +			dsi.vc[i].vc_id = 0;
>> +			dsi.vc[i].mode = DSI_VC_MODE_L4;
>> +			num_vc_used_disp++;
>> +		}
>> +	}
>> +
>> +	dsi.num_vc_used -= num_vc_used_disp;
>> +}
>> +EXPORT_SYMBOL(omap_dsi_release_vc);
>
> I don't think these work quite right. What happens if there are two
> panel drivers, both have allocated one channel. Then the first channel
> is released. At this point num_vc_used is 1. Next request would allocate
> channel number 1, which is still in use.
>

This is quite silly of me. I think I made this thinking that the 
sequence of releases by panels will happen in opposite order to sequence 
of requests. But that won't be the case at all when the panels are 
inserted as modules

> I think the code will be cleaner and simpler if you removed num_vc_used,
> and loop through the 4 channels when allocating, trying to find a free
> one. It's just 4 iterations.
>

I will make this change.

Archit
