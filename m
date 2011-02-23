From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: Move omap_hwmod_late_init() to mdesc->timer->init() code
Date: Wed, 23 Feb 2011 11:12:47 +0530
Message-ID: <eeb4d4bc7d16b99b52d278491e7a5cdb@mail.gmail.com>
References: <1298385449-27356-1-git-send-email-santosh.shilimkar@ti.com> <20110222164902.GJ15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42676 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752526Ab1BWFmt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 00:42:49 -0500
Received: by mail-qy0-f182.google.com with SMTP id 27so2586449qyk.20
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 21:42:48 -0800 (PST)
In-Reply-To: <20110222164902.GJ15225@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, February 22, 2011 10:19 PM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Paul Walmsley; Kevin Hilman; Benoit
> Cousson
> Subject: Re: [PATCH] omap: Move omap_hwmod_late_init() to mdesc-
> >timer->init() code
>
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110222 06:35]:
> > To adhere to recent early_init changes, commit '44dc0' made
> > omap_hwmod_late_init() to core_initcall to avoid ioremap()
> failures.
> >
> > Later 'e7c7d7' removed _mpu_rt_va population
> omap_hwmod_late_init()
> >
> > So now if we move the  omap_hwmod_late_init() to mdesc->timer-
> >init(),
> > timer1 should work with hwmod instead of any special hwmod
> settings.
>
> There should be no need to have all hwmods initialized just to get
> the system timer running. The system timer should be initialized
> with minimal code needed.
>
Sure

> Sure it can use hwmod functions as long as it makes sense, but
> we certainly don't want the whole hwmod framework initialized
> that early.
>
Something like hwmod_early_init() would solve the issue of early
devices. At least this is better than hacking early hwmod
drivers.
Looks like that's what we decided to go head with
looking at other thread.

Regards,
Santosh
