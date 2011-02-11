From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 3/3] OMAP4: clockdomain: Add wkup/sleep dependency support
Date: Fri, 11 Feb 2011 10:51:37 +0530
Message-ID: <478620b0abf7ff99cb41192dd4ee9e6d@mail.gmail.com>
References: <1297084631-27474-1-git-send-email-rnayak@ti.com>
 <1297084631-27474-2-git-send-email-rnayak@ti.com> <1297084631-27474-3-git-send-email-rnayak@ti.com>
 <1297084631-27474-4-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1102101905160.21991@utopia.booyaka.com>
 <3754d10e94217aa81846aa1d41fe0a9d@mail.gmail.com> <alpine.DEB.2.00.1102102135220.21991@utopia.booyaka.com>
 <74b7dfbe67e19da4358f7df0bc4dd8f1@mail.gmail.com> <alpine.DEB.2.00.1102102209080.21991@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47826 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750871Ab1BKFVj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 00:21:39 -0500
Received: by mail-fx0-f42.google.com with SMTP id 11so2396182fxm.29
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 21:21:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102102209080.21991@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Friday, February 11, 2011 10:44 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Benoit Cousson;
linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 3/3] OMAP4: clockdomain: Add wkup/sleep dependency
support
>
> Hi Rajendra
>
> On Fri, 11 Feb 2011, Rajendra Nayak wrote:
>
> > Failing silently is going to make it more difficult to identify and
fix.
> > Maybe a WARN in else?
> >
> > 	if (cd->clkdm) {
> > 		...
> > 	} else
> > 		WARN()
>
> I was thinking it might be nice to put it right next to the
> _clkdm_lookup()s in clkdm_init(), since the _clkdm_lookup is what is
> actually failing.  Then we could do a
>
> if (!cd->clkdm)
> 	continue;
>
> in the SoC-specific *_all_wkdep/sleepdep* code, just to keep the system
> from crashing...
>
> Does that sound okay to you?

Yep, that sounds better.

Thanks,
Rajendra

>
>
> - Paul
