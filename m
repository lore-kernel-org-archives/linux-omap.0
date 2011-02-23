From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 15/19] omap3+: sr: introduce notifier_control
Date: Wed, 23 Feb 2011 12:16:18 +0530
Message-ID: <e161df1aa3dda3a792d1db6f93abbf98@mail.gmail.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <1298116918-30744-16-git-send-email-nm@ti.com>
 <765c3f6e8053293455100f296fb76ae5@mail.gmail.com> <4D609D86.8040608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:39691 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751657Ab1BWGq3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 01:46:29 -0500
Received: by ewy1 with SMTP id 1so1015060ewy.29
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 22:46:26 -0800 (PST)
In-Reply-To: <4D609D86.8040608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

> -----Original Message-----
> From: Nishanth Menon [mailto:nm@ti.com]
> Sent: Sunday, February 20, 2011 10:20 AM
> To: Vishwanath Sripathy
> Cc: linux-omap; Tony Lindgren; Kevin Hilman
> Subject: Re: [PATCH 15/19] omap3+: sr: introduce notifier_control
>
> Vishwanath Sripathy wrote, on 02/19/2011 07:10 PM:
>
> >> +int sr_notifier_control(struct voltagedomain *voltdm, bool enable)
> >> +{
> >> +	struct omap_sr *sr = _sr_lookup(voltdm);
> >> +	u32 value = 0;
> >> +	if (IS_ERR_OR_NULL(sr)) {
> >> +		pr_warning("%s: sr corresponding to domain not found\n",
> >> +				__func__);
> >> +		return -EINVAL;
> >> +	}
> >> +	if (!sr->autocomp_active)
> >> +		return -EINVAL;
> > Why you do you return here? Class driver should still be able to place
> > it's request even if sr is disabled though it will be effective only
after
> > sr is enabled.
>
> my intents were as following: which useful event would come without SR
> avs being enabled? what kind of event do you expect with the AVS
> disabled which is useful for class driver, whose clase init alone was
> called and not class enable?
The point I am making here is, why should SR class driver be prevented to
register for some events when SR is disabled? If it is prevented here,
then it needs to keep track that the request is denied and needs to make
the request again when SR is enabled later.

Vishwa

>
> --
> Regards,
> Nishanth Menon
