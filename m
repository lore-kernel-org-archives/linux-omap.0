From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 24/25] OMAPDSS: DSI: improve DSI module id handling
Date: Fri, 4 May 2012 15:35:24 +0530
Message-ID: <4FA3A9E4.3040802@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>  <1336053481-25433-25-git-send-email-tomi.valkeinen@ti.com>  <4FA39CBB.6010500@ti.com> <1336125229.2701.30.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50051 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590Ab2EDKGG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 06:06:06 -0400
In-Reply-To: <1336125229.2701.30.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 04 May 2012 03:23 PM, Tomi Valkeinen wrote:
> On Fri, 2012-05-04 at 14:39 +0530, Archit Taneja wrote:
>> On Thursday 03 May 2012 07:28 PM, Tomi Valkeinen wrote:
>>> We currently use the id of the dsi platform device (dsidev->id) as the
>>> DSI hardware module ID. This works because we assign the ID manually in
>>> arch/arm/mach-omap2/display.c at boot time.
>>>
>>> However, with device tree the platform device IDs are automatically
>>> assigned to an arbitrary number, and we can't use it.
>>
>> If this number is arbitrary we would need to change the "dsi_pdev_map"
>> approach of mapping a dsi module and it's corresponding platform device.
>> Currently dsi_pdev_map is:
>>
>> static struct platform_device *dsi_pdev_map[MAX_NUM_DSI];
>>
>> So we either need to increase the array size to take larger arbitrary
>> numbers, or do something else.
>>
>> We would also need to fix the usage of dsi_get_dsidev_from_id(), as
>> right now we manually pass 0 and 1 to it only, for example:
>>
>> static void dsi1_dump_irqs(struct seq_file *s)
>> {
>>           struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
>>
>>           dsi_dump_dsidev_irqs(dsidev, s);
>> }
>>
>> The immediate solution that comes to mind is to maintain 2 id's, one
>> which is sequential, and the other which the DT has created, and keep an
>> array to map these. But this seems messy!
>
> This is only a problem with device tree, and I solved it so that I pass
> a DSI module ID in the device tree data. So, with old pdata way I
> initialize dsi->module_id from the pdev->id, but with DT I initialize
> dsi->module_id from the DT data.

Oh ok, so the code which decides how dsi->module_id is initialised(from 
DT or pdata) is not in this series right? And it would come later? Right 
now it's just set to dsidev->id in probe.

>
> So basically we remove the use of pdev->id in this patch, and add
> dsi->module_id field, which needs to be initialized to 0 or 1, depending
> on the corresponding HW module. We just happen to use the pdev->id to
> initialize it when using the old pdata method, as we know it tells the
> right id. But we could initialize it from any other source.

Right, I get it now.

>
> This allows us to keep the 0 and 1 DSI IDs, and I think we need those
> anyway. Some parts of the code could work fine with arbitrary ID, as
> long as a pdev can be linked to/from this ID. However, there are things
> where we must have the ID, like configuring the clock source settings in
> dss_core, where we set a certain bit for DSI module 0, and certain bit
> for module 1.
>
> Perhaps even those could be handled without explicit ID of 0 or 1, but
> that doesn't sound trivial and I didn't want to start tackling that in
> this series.
>
> I wish there was a way to get the module ID from the HW registers
> somehow. Then we wouldn't need to pass the ID via SW, which doesn't feel
> very correct. At least with DT it's a bit wrong, in my opinion, but best
> I could come up with.

We could derive it via a parameter like number of lanes or something 
similar through DSI_GNQ, but that doesn't seem very nice, and may not be 
usable on future OMAPs.

Archit

>
>   Tomi
>

