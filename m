From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv2 6/13] dmtimer: hwmod: OMAP2PLUS: device registration
Date: Wed, 01 Sep 2010 08:29:38 -0700
Message-ID: <87d3sxmqhp.fsf@deeprootsystems.com>
References: <1281800238-15135-1-git-send-email-tarun.kanti@ti.com>
	<87zkwcq3g5.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03291AD382@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44030 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0IAP3u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 11:29:50 -0400
Received: by pvg2 with SMTP id 2so2897108pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Sep 2010 08:29:50 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03291AD382@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Wed, 1 Sep 2010 15:41:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

[...]

>> > +static void omap2_dm_timer_enable(struct platform_device *pdev)
>> > +{
>> > +   if (!pdev) {
>> > +           dev_err(&pdev->dev, "%s: invalid pdev\n", __func__);
>> > +           return;
>> > +   }
>> > +   pm_runtime_get_sync(&pdev->dev);
>> > +}
>> > +
>> > +static void omap2_dm_timer_disable(struct platform_device *pdev)
>> > +{
>> > +   if (!pdev) {
>> > +           dev_err(&pdev->dev, "%s: invalid pdev\n", __func__);
>> > +           return;
>> > +   }
>> > +   pm_runtime_put_sync(&pdev->dev);
>> > +}
>>
>> There is no need for these functions.  Driver should be calling runtime
>> PM API directly.
>>

> In that case, driver will have to make call by directly accessing
> acquired timer's internal variables as shown below.
> pm_runtime_put_sync(&timer->pdev->dev); 
>
> However, I believe we would like other drivers' perform all operations
> on acquired timers through exported APIs and keep the
> pm_runtime_put_sync() call internal to exported APIs as is the case
> current implementation.
>
> Let me know if I am missing anything here!!

These new functions are not part of the exported API.  You have made
them static, and part of the device layer.

These are created as wrappers to pm_runtime_* API which are then called
by the driver layer.  What I suggest is not creating these functions
(and the pdata-> function pointers to wrap them) but instead calling the
runtime PM api directly instead of using the pdata-> function pointers.

Kevin

