From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 11/25] OMAPDSS: create custom pdevs for DSS omap_devices
Date: Fri, 4 May 2012 14:43:10 +0530
Message-ID: <4FA39DA6.6040807@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>  <1336053481-25433-12-git-send-email-tomi.valkeinen@ti.com>  <4FA39091.8010007@ti.com> <1336122006.2701.19.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42482 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614Ab2EDJNu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 05:13:50 -0400
In-Reply-To: <1336122006.2701.19.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 04 May 2012 02:30 PM, Tomi Valkeinen wrote:
> On Fri, 2012-05-04 at 13:47 +0530, Archit Taneja wrote:
>> On Thursday 03 May 2012 07:27 PM, Tomi Valkeinen wrote:
>
>>> @@ -221,22 +279,24 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
>>>    		oh_count = ARRAY_SIZE(omap4_dss_hwmod_data);
>>>    	}
>>>
>>> -	for (i = 0; i<   oh_count; i++) {
>>> -		oh = omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
>>> -		if (!oh) {
>>> -			pr_err("Could not look up %s\n",
>>> -				curr_dss_hwmod[i].oh_name);
>>> -			return -ENODEV;
>>> -		}
>>> +	dss_pdev = NULL;
>>>
>>> -		pdev = omap_device_build(curr_dss_hwmod[i].dev_name,
>>> -				curr_dss_hwmod[i].id, oh,
>>> +	for (i = 0; i<   oh_count; i++) {
>>> +		pdev = create_dss_pdev(curr_dss_hwmod[i].dev_name,
>>> +				curr_dss_hwmod[i].id,
>>> +				curr_dss_hwmod[i].oh_name,
>>>    				NULL, 0,
>>> -				NULL, 0, 0);
>>> +				dss_pdev);
>>> +
>>> +		if (IS_ERR(pdev)) {
>>> +			pr_err("Could not build omap_device for %s\n",
>>> +					curr_dss_hwmod[i].oh_name);
>>> +
>>> +			return PTR_ERR(pdev);
>>> +		}
>>>
>>> -		if (WARN((IS_ERR(pdev)), "Could not build omap_device for %s\n",
>>> -				curr_dss_hwmod[i].oh_name))
>>> -			return -ENODEV;
>>> +		if (i == 0)
>>> +			dss_pdev = pdev;
>>
>> The above line is a bit tricky to understand, maybe something like this
>> may explain the parent-child setting better:
>>
>> 		if (!strcmp(curr_dss_hwmod[i].oh_name, "dss_core"))
>> 			dss_pdev = pdev;
>
> I agree that it's a bit confusing. But your suggestion is not very good
> either, as the code does not work properly if the dss_core is not the
> first one created. I'll look into it. Perhaps I can separate the code
> into a small function, and then I can more easily do something like:

Right, my suggestion wont work either.

>
> dss_pdev = create_the_device();
>
> for () {
> 	// create the rest of the devices
> 	create_the_device();
> }
>
> and that would clarify what's going on.

Yes, or you could just add a comment saying i == 0 is the dss_core 
hwmod, and we make sure dss_core is the first one on the list.

>
>> I had another general question about the parent-child series. What is
>> the use of the platform device omap_display_device (with the name
>> "omapdss"). Is it just a way to get the board data?
>
> Originally, before hwmods, we had only omapdss device, which contained
> all the dss code. Then came hwmods, and the omapdss was split into
> smaller devices, but omapdss was still there.
>
> As I see it, omapdss is currently a "virtual" higher level device
> (virtual in the sense that it doesn't correspond directly to any HW),
> and the code for omapdss is more or less in the core.c file. It's used
> to pass the board data, but also has some generic dss stuff that all dss
> subdevices can use.
>
> I think in the long run we should remove omapdss device, and probably
> handle the generic stuff in dss_core (dss.c), which, as a parent to
> other subdevices, should fit fine for the role.
>
> For the time being we can't remove it. It's the only simple way to pass
> callbacks from the arch code with device tree.

Okay, makes sense now.

Thanks,
Archit

>
>   Tomi
>

