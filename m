From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+: Move the stubbed prm and cm functions to
 prcm.c file and make them __weak.
Date: Wed, 4 Jul 2012 20:55:49 +0530
Message-ID: <CAJ7qFSc7qNJ91J9sbsYFA5TW=qvyyDXkoL+XuTkHxvFrqBLqkg@mail.gmail.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
	<1336669615-16454-3-git-send-email-r.sricharan@ti.com>
	<alpine.DEB.2.00.1205101140230.32719@utopia.booyaka.com>
	<CAJ7qFSdiMgM3S5Q+XaFAGrgcL5M5f8CLHyKSRtBKu4AK6ei-BA@mail.gmail.com>
	<CAJ7qFSfu3yyj8YqETTzx+wipi1Nbf5m5fDLC26Tfojav+Lb56Q@mail.gmail.com>
	<alpine.DEB.2.00.1207040431400.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:51990 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750846Ab2GDPZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 11:25:52 -0400
Received: by lbjn8 with SMTP id n8so13697256lbj.14
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 08:25:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207040431400.6760@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com

Hi Paul,
On Wed, Jul 4, 2012 at 8:49 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Thu, 28 Jun 2012, R, Sricharan wrote:
>
>>  Ping..
>
> Since the prcm.c cleanup series isn't ready yet, I've queued this modified
> version of your patch.
>
> Once the prcm.c cleanup series is ready, hopefully in the 3.7 time frame,
> we'll be able to get rid of all of these nasty stubs.
>
 Thanks a lot. I think this should help to get rid of the OMAP5 dependency.

Thanks,
 Sricharan
