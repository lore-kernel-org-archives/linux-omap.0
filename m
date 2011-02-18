From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for iclks, OMAP2xxx
Date: Fri, 18 Feb 2011 11:03:04 +0530
Message-ID: <8404ce0409e328dc482eae2f927407ac@mail.gmail.com>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
 <b83b1717e83fc907a1caf589cc53badf@mail.gmail.com> <alpine.DEB.2.00.1102161510410.29817@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57370 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750842Ab1BRFdH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 00:33:07 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so3702899fxm.33
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 21:33:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102161510410.29817@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, February 17, 2011 3:44 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 00/11] OMAP2+: clock: add clockfw autoidle for
iclks, OMAP2xxx
>
> Hi Rajendra
>
> On Wed, 16 Feb 2011, Rajendra Nayak wrote:
>
> > > -----Original Message-----
> > > From: linux-arm-kernel-bounces@lists.infradead.org
> > [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf
> > > Of Paul Walmsley
> > > Sent: Wednesday, February 16, 2011 12:23 PM
> > >
> > > This series also ensures that all clock autoidle is disabled during
> > > boot and only re-enabled if CONFIG_PM is enabled.
> >
> > This does not seem to be the case. Maybe something like the
> > below patch is what is missing..
>
> Thanks for the review, you are absolutely right.  Rather than the patch
> you sent, and since mach-omap2/pm.c is compiled in even if !CONFIG_PM,
> I'd propose a different approach.  Until we can sort out the
> CONFIG_PM/pm.c issue, probably it would make more sense to move the
> autoidle-enable as part of CONFIG_OMAP_RESET_CLOCKS.  Will send a patch
in
> reply to the original thread.

I had a look at the patch and it does look like a better way to handle
it for now, till the CONFIG options are further cleaned up.
Thanks,
Rajendra

>
>
> - Paul
