From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 07 Nov 2013 18:37:28 +0100
Message-ID: <527BCFD8.9010207@gmail.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com> <527BC118.1050609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:58861 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3KGRhe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Nov 2013 12:37:34 -0500
Received: by mail-bk0-f44.google.com with SMTP id mx11so365882bkb.3
        for <linux-omap@vger.kernel.org>; Thu, 07 Nov 2013 09:37:32 -0800 (PST)
In-Reply-To: <527BC118.1050609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: linux-omap@vger.kernel.org, gururaja.hebbar@ti.com, balajitk@ti.com, nsekhar@ti.com, s.neumann@raumfeld.com, Russ.Dill@ti.com, linux-arm-kernel@lists.infradead.org

Hi Joel,

On 11/07/2013 05:34 PM, Joel Fernandes wrote:
> Thanks for your followup patch on this. It looks much better now using existing
> functions to save/restore the state.

Yes, thanks for the suggesting it in the first place.

> On 10/30/2013 03:21 PM, Daniel Mack wrote:
>> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> [..]
>> +static int edma_pm_resume(struct device *dev)
>> +{
>> +	int i, j;
>> +
>> +	pm_runtime_get_sync(dev);
>> +
>> +	for (j = 0; j < arch_num_cc; j++) {
>> +		struct edma *cc = edma_cc[j];
>> +
>> +		s8 (*queue_priority_mapping)[2];
>> +		s8 (*queue_tc_mapping)[2];
>> +
>> +		queue_tc_mapping = cc->info->queue_tc_mapping;
>> +		queue_priority_mapping = cc->info->queue_priority_mapping;
>> +
>> +		/* Event queue to TC mapping */
>> +		for (i = 0; queue_tc_mapping[i][0] != -1; i++)
>> +			map_queue_tc(j, queue_tc_mapping[i][0],
>> +					queue_tc_mapping[i][1]);
>> +
>> +		/* Event queue priority mapping */
>> +		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
>> +			assign_priority_to_queue(j,
>> +						queue_priority_mapping[i][0],
>> +						queue_priority_mapping[i][1]);
> 
> I know ti,edma-regions property is not currently being used, but we should
> future proof this by setting up DRAE for like done in probe:
> 
>                 for (i = 0; i < info[j]->n_region; i++) {
>                         edma_write_array2(j, EDMA_DRAE, i, 0, 0x0);
>                         edma_write_array2(j, EDMA_DRAE, i, 1, 0x0);
>                         edma_write_array(j, EDMA_QRAE, i, 0x0);
>                 }

That doesn't work for me. I'm running long-time tests here on a device
which has a mwifiex connected to omap_hsmmc. The test procedure includes:

a) a script on the device that puts the device to sleep some seconds
after it has been woken up

b) a script on a host that wakes up the device with wake-on-lan every 10
seconds

c) a flood ping that checks whether the device is responding


That precedure is running since a couple of hourse here, and it works
well with both by v3 and v4 patches. Moving the functions to
.suspend/resume _noirq doesn't seem to break anything.

Setting QRAE to 0 as you mentioned above, however, makes the device fail
at resume.

>> +static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);
> 
> I agree with Nishanth here, it is better to do this in .suspend/resume _noirq
> stage to rule out any ordering bugs that may show up in the future, since such
> an issue already showed up in earlier testing.

Alright, I already did that.

> I would appreciate it if you can make these 2 changes and post a v5. Thanks for
> a lot for all the hardwork.

No problem at all :)

> Acked-by: Joel Fernandes <joelf@ti.com>

Still sure about that? What about your follow-up to your own reply?


Many thanks for all the feedback!

Daniel




