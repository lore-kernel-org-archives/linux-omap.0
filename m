From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for GPT1
Date: Thu, 10 Mar 2011 21:57:08 +0530
Message-ID: <9c47364db2da7c8bcec3e21463f001fe@mail.gmail.com>
References: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
 <alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com> <3b8b985f13158fbcd110cf45ed7035ad@mail.gmail.com>
 <alpine.DEB.2.00.1103100744500.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:44896 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363Ab1CJQ1O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 11:27:14 -0500
Received: by qwb7 with SMTP id 7so1585783qwb.30
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 08:27:13 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103100744500.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, March 10, 2011 8:15 PM
> To: Santosh Shilimkar
> Cc: Benoit Cousson; Rajendra Nayak; linux-omap@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; Kevin Hilman
> Subject: RE: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle
> for GPT1
>
> On Thu, 10 Mar 2011, Santosh Shilimkar wrote:
>
> > We continued further debug on the static dependency issues with
> > OMAP4 PM series.
> > So far from the findings what I have, this timer patch is actually
> not
> > needed and can be dropped. Infact the patch is not really
> effective
> > because current timer driver(not hwmod adapted yet) puts timer1
> > in smart idle again.
> >
> > There is another static dep. just like MPUSS<-->EMIF seems to
> create
> > an issue. The lock-up is not very consistently reproducible so
> it's
> > very easy to get miss-leading results. Timer patch was one of
> those
> > observations. With or without timer patch I can reproduce the hang
> > with long duration test.
> >
> > Will keep narrowing down the next offending static dependency but
> > in mean time I suggest you to drop this patch.
>
> Okay, dropped.
>
Managed to narrow down the issue with below two offender.
1) MPUSS <--> MEMIF_STATDEP
2) MPUSS <--> L3_1_STATDEP

If we keep both of these static deps, then I don't see any
issues. Will give a overnight run to check the stability.

Will update the below patch to include L3_1 CD and
repost the same.
https://patchwork.kernel.org/patch/620351/

Regards
Santosh
