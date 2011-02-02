From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH] OMAP: hwmod: Do not expect an entry in clkdev to add
 alias for opt_clks
Date: Wed, 2 Feb 2011 09:40:45 +0530
Message-ID: <64895f98b88c90709eb4f571d0582407@mail.gmail.com>
References: <1296213475-23460-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1101311606030.16671@utopia.booyaka.com> <997a6c2b061aee29cd2d0c755d4ad80c@mail.gmail.com>
 <alpine.DEB.2.00.1102010948320.15746@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36534 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752125Ab1BBEKr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 23:10:47 -0500
Received: by mail-fx0-f43.google.com with SMTP id 18so8408723fxm.2
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 20:10:46 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102010948320.15746@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, February 01, 2011 10:23 PM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] OMAP: hwmod: Do not expect an entry in clkdev to
add alias for opt_clks
>
> On Tue, 1 Feb 2011, Rajendra Nayak wrote:
>
> > One other thing I was thinking of is if the function name
> > _add_optional_clock_alias need to be changed to something like
> > _add_optional_clock_clkdev since we are adding a new clkdev entry,
> > if it does not exist, and no longer adding an 'alias' for an existing
> > entry.
>
> Fine with me.
>
> > Also, the adding of an entry in clkdev is today done for
> > optional clocks alone. Is there any reason why we should not do
> > this at runtime for all main clks and interface clks also.
> > That way we get rid of all dependencies with the static clkdev
> > table, and we might infact not need one if all entries are added
> > runtime.
>
> Heh, you've just uncovered my "secret" plan.  It seemed best to me to
wait
> until all of the hwmod conversions were done to avoid alarming certain
> people who might be consulting the static clkdev table in
> mach-omap2/clock*_data.c as a platform reference...

Ok, sounds good to me, thanks.
Will repost this one with the mentioned changes.

>
>
> - Paul
