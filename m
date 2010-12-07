From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5 9/12] OMAP: dmtimer: platform driver
Date: Tue, 7 Dec 2010 11:17:42 +0530
Message-ID: <20101207054742.GA29773@GLPP-machine>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <1291679059-13419-10-git-send-email-tarun.kanti@ti.com>
 <20101206191018.GF4924@manju-desktop>
 <5A47E75E594F054BAF48C5E4FC4B92AB03736F506A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42242 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598Ab0LGFrN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 00:47:13 -0500
Received: by mail-gx0-f176.google.com with SMTP id 4so8308728gxk.7
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 21:47:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03736F506A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [2010-12-07 11:02:26 +0530]:

> > -----Original Message-----
> > From: G, Manjunath Kondaiah
> > Sent: Tuesday, December 07, 2010 12:40 AM
> > To: DebBarma, Tarun Kanti
> > Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> > Subject: Re: [PATCH v5 9/12] OMAP: dmtimer: platform driver
> > 
> > On Tue, Dec 07, 2010 at 05:14:16AM +0530, Tarun Kanti DebBarma wrote:
> > > From: Thara Gopinath <thara@ti.com>
> > >
> > > Add dmtimer platform driver functions which include:
> > > (1) platform driver initialization
> > > (2) driver probe function
> > > (3) driver remove function
> > >
> > > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > > Signed-off-by: Thara Gopinath <thara@ti.com>
> > > Reviewed-by: Cousson, Benoit <b-cousson@ti.com>

[...]

> > > +
> > > +err_free_mem:
> > > +	kfree(timer);
> > > +
> > > +err_release_ioregion:
> > > +	release_mem_region(mem->start, resource_size(mem));
> > > +
> > > +err_free_pdev:
> > You can also free pdata?
> This pdata points to data within pdev created by omap_device_build.
> But the pdata which was allocated locally is already freed
> After omap_device_build() in omap_timer_init() in mach-omap.

You should also free memory allocated for pdata during omap_device_build
since you no longer require pdata due to probe fail.

> 
> > > +	platform_device_del(pdev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * omap_dm_timer_remove - cleanup a registered timer device
> > > + * @pdev:	pointer to current timer platform device
> > > + *
> > > + * Called by driver framework whenever a timer device is unregistered.
> > > + * In addition to freeing platform resources it also deletes the timer
> > > + * entry from the local list.
> > > + */
> > > +static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
> > > +{
> > > +	struct omap_dm_timer *timer, *tmp;
> > > +	unsigned long flags;
> > > +	int ret = -EINVAL;
> > > +
> > > +	spin_lock_irqsave(&dm_timer_lock, flags);
> > > +	list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {
> > > +		if (timer->pdev->id == pdev->id) {
> > > +			platform_device_del(timer->pdev);
> > > +			list_del(&timer->node);
> > > +			kfree(timer);
> > kfree(pdev->dev.platform_data);
> Ok, this is supposed to be done as part of platform_device_del above.

No. platform_device_del will not free platform_data. You have use kfree for
freeing pdata or platform_data.

-Manjunath
