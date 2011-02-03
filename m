From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE power state
Date: Thu, 3 Feb 2011 14:30:10 +0530
Message-ID: <7f9f718bd21a8c81eba2fa3d8b60b700@mail.gmail.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com><1296212688-21951-2-git-send-email-santosh.shilimkar@ti.com><87pqrbmdwx.fsf@ti.com><bcc7ec64222e616309287af8eb23d659@mail.gmail.com>
 <87aaieazyb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:57889 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755149Ab1BCJAN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 04:00:13 -0500
Received: by mail-gx0-f178.google.com with SMTP id 25so411856gxk.23
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 01:00:12 -0800 (PST)
In-Reply-To: <87aaieazyb.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, February 03, 2011 2:58 AM
> To: Rajendra Nayak
> Cc: Santosh Shilimkar; linux-omap@vger.kernel.org; paul@pwsan.com;
> Benoit Cousson; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/6] omap4: powerdomain: Add supported INACTIVE
> power state
>
> Rajendra Nayak <rnayak@ti.com> writes:
>
> > Hi Kevin,
> >
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@ti.com]
> >> Sent: Wednesday, February 02, 2011 6:49 AM
> >> To: Santosh Shilimkar
> >> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; b-cousson@ti.com;
> > rnayak@ti.com; linux-arm-
> >> kernel@lists.infradead.org
> >> Subject: Re: [PATCH 1/6] omap4: powerdomain: Add supported
> INACTIVE
> > power state
> >>
> >> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> >>
> >> > On OMAP4, one can explicitly program INACTIVE as the power
> state of
> >> > the logic area inside the power domain. Techincally PD state
> > programmed
> >> > to ON and if all the clock domains within the PD are idled, is
> > equivalent
> >> > tp PD programmed to INACTIVE and all the clock domains within
> the PD
> > are
> >> > idled. There won't be any power difference in above two.
> >> >
> >> > Since the CPUIDLE C-states explicitly make use of INACTIVE as a
> PD
> >> > targeted state
> >>
> >> I think you're referring to code that is not upstream here.  I'm
> not
> >> aware of any C-states targetting INACTIVE.
> >
> > On OMAP3, C2/3/4 have target state as CORE inactive, while C1 is
> > CORE active.
>
> I see what you're saying now.
>
> However, from a code point of view, all of those C-states are
> programmed
> to PWRDM_POWER_ON.
>
> Therefore the changelog is not accurate.  Specifically the use of
> "explicitly" is wrong, because the use of INACTIVE is most certainly
> not explicit.
>
Ok. The 'explicit' came from OMAP4 where you could program it. I agree
the code is not there in mainline to show this.

I can drop the explicit from change log if it helps.

Regards,
Santosh
