From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 0/3] OMAP2+ hwmod fixes
Date: Wed, 23 Feb 2011 15:35:07 +0530
Message-ID: <19850e063c924a8a30c69ac02621a659@mail.gmail.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
 <4D5BCC10.2060301@ti.com> <6cc4b2788ff1e15c22987d5db91f0395@mail.gmail.com>
 <4D5E85EA.70605@ti.com> <alpine.DEB.2.00.1102210901140.22636@utopia.booyaka.com>
 <e6550ef1ea27499e3bc093e264c54d0f@mail.gmail.com> <alpine.DEB.2.00.1102221200260.22636@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:60203 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752349Ab1BWKFM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 05:05:12 -0500
Received: by mail-fx0-f51.google.com with SMTP id 11so3489470fxm.24
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 02:05:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1102221200260.22636@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, February 23, 2011 12:40 AM
> To: Rajendra Nayak; Cousson, Benoit
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 0/3] OMAP2+ hwmod fixes
>
> Hi Rajendra
>
> On Tue, 22 Feb 2011, Rajendra Nayak wrote:
>
> > The original behavior of the iterators, to terminate upon
> > encountering an error, seems fine to me. The only problem
> > I faced was that they fail silently and go undetected, unless
> > their user catches the return value and WARN's, which I found
> > was not the case with most users, mainly those of
> > omap_hwmod_for_each_by_class.
> > I was thinking of keeping the behaviour of these iterators
> > same for now and add WARN's in these iterators itself upon
> > an error, so its seen even if the user fails to catch it.
>
> What's your opinion on adding the pr_err() or WARN() into the code that
> the iterator calls for each hwmod?  That code should know why something
> fails, so it should be able to provide a more detailed error message.
Of
> course, it is not as general a solution...

I agree, if the callback functions are written with proper errors
or WARN's, they are the right place where most of the details'
exist. So maybe we don't need these in the iterator's after all.

Regards,
Rajendra

>
>
> - Paul
