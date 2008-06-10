From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Added sleep support to UART
Date: Mon, 9 Jun 2008 23:06:24 -0700
Message-ID: <20080610060624.GE23796@atomide.com>
References: <1212490022-5866-1-git-send-email-tero.kristo@nokia.com> <20080610051104.GD23796@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54925 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYFJGGY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2008 02:06:24 -0400
Content-Disposition: inline
In-Reply-To: <20080610051104.GD23796@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080609 22:11]:
> Hi,
> 
> Sorry for the delay on looking at this, it's looking pretty good in
> general. Few more mostly cosmetic comments below.

Here's one more comment:

> > --- a/arch/arm/mach-omap2/pm24xx.c
> > +++ b/arch/arm/mach-omap2/pm24xx.c
> >  	if (omap2_pm_debug) {
> >  		unsigned long long tmp;
> > -		u32 resume_time;
> > +		s64 resume_time;
> > +		struct timespec t;
> >  
> > -		resume_time = omap2_read_32k_sync_counter();
> > +		getnstimeofday(&t);
> > +		resume_time = timespec_to_ns(&t);
> >  		tmp = resume_time - sleep_time;
> > -		tmp *= 1000000;
> > -		omap2_pm_dump(0, 1, tmp / 32768);
> > +		omap2_pm_dump(0, 1, tmp / 1000);
> >  	}

You should make all these calculations using timespec_sub():

struct timespec ts1, ts2, ts_delta;
getnstimeofday(&ts1);
getnstimeofday(&ts2);
ts_delta = timespec_sub(&ts2, &ts1);

Regards,

Tony
