From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: do we need CHIP_GE_OMAP3630ES1in .oc? (was Re: [PATCH 02/19]
 omap3630: hwmod: sr: enable for higher ES)
Date: Mon, 21 Feb 2011 11:20:24 +0530
Message-ID: <c3e6c8b2e10ed9e7ededead85ea5ec4f@mail.gmail.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com> <1298116918-30744-3-git-send-email-nm@ti.com>
 <cfec809cd80216111287ec9509b30250@mail.gmail.com> <4D60A5FB.8080901@ti.com> <4D60A8DE.1000805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:45717 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752130Ab1BUFu1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 00:50:27 -0500
Received: by mail-fx0-f41.google.com with SMTP id 5so833776fxm.14
        for <linux-omap@vger.kernel.org>; Sun, 20 Feb 2011 21:50:26 -0800 (PST)
In-Reply-To: <4D60A8DE.1000805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

> Better might be to introduce and use CHIP_GE_OMAP3630ES1 in hwmod
> structs in that case - that should ease things up. but the ES1 story
> should be fixed I guess.
>
>
> > What do people think of this?
>
>
> + Anand from commit b0a1a6ce0597662c06f970643da60b8ebb5cdd1c which
> introduced the code in id.c to hear his views as well.

There's one instance where we needed to distinguish between ES1.0 and
all later revs of the 36xx - this was in commit 58dcfb3a0f
(omap: 3630: disable TLL SAR on 3630 ES1).

I chose to pick the same approach that was done for 3430 ES3.0 and below.

We keep two "struct powerdomain core_3xx*pwrdm" instances in
mach-omap2/powerdomains34xx.h with TLL SAR disabled in one. I couldn't
think up a better way to handle this at the time.

- Anand
