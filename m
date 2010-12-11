From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH/RFC 2/2] OMAP: PM: implement context loss count APIs
Date: Sat, 11 Dec 2010 12:43:24 +0530
Message-ID: <04a0c6e8413f897941850edcb93a176d@mail.gmail.com>
References: <1291939712-25487-1-git-send-email-khilman@deeprootsystems.com><1291939712-25487-2-git-send-email-khilman@deeprootsystems.com><44f6fc2f0c975af7273975385567acd2@mail.gmail.com>
 <87zksd5ebv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57366 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750787Ab0LKHN0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Dec 2010 02:13:26 -0500
Received: by mail-fx0-f50.google.com with SMTP id 14so4191633fxm.23
        for <linux-omap@vger.kernel.org>; Fri, 10 Dec 2010 23:13:24 -0800 (PST)
In-Reply-To: <87zksd5ebv.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Saturday, December 11, 2010 6:14 AM
> To: Vishwanath Sripathy
> Cc: linux-omap@vger.kernel.org; Paul Walmsely
> Subject: Re: [PATCH/RFC 2/2] OMAP: PM: implement context loss count
> APIs
>
> Vishwanath Sripathy <vishwanath.bs@ti.com> writes:
>
> > Kevin,
> [...]
>
> >> @@ -288,20 +290,19 @@ unsigned long
> omap_pm_cpu_get_freq(void)
> >>
> >>  int omap_pm_get_dev_context_loss_count(struct device *dev)
> >>  {
> >> +	struct platform_device *pdev = to_platform_device(dev);
> >> +	int count;
> >> +
> >>  	if (!dev) {
> >>  		WARN_ON(1);
> >>  		return -EINVAL;
> >>  	};
> >>
> >> -	pr_debug("OMAP PM: returning context loss count for dev %s\n",
> >> -		 dev_name(dev));
> >> +	count = omap_device_get_context_loss_count(pdev);
> >> +	pr_debug("OMAP PM: context loss count for dev %s = %d\n",
> >> +		 dev_name(dev), count);
> >
> > Shouldn't this implementation be part of omap-pm.c where all the
> OMAP PM
> > functions are to be implemented?
>
> Where is omap-pm.c?
It's not present and needs to be added. This file is anyway required for
adding device latency constraints as well.

Vishwa
>
> Kevin
