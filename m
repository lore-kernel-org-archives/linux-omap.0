From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/5] omap2plus: Trivial build break fixes
Date: Wed, 5 Jan 2011 16:28:47 +0530
Message-ID: <6a39d0124306a5ac6b567edca88f0671@mail.gmail.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com> <8762u4423o.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:48431 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751778Ab1AEK6t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 05:58:49 -0500
Received: by gyg13 with SMTP id 13so5768796gyg.16
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 02:58:48 -0800 (PST)
In-Reply-To: <8762u4423o.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Wednesday, January 05, 2011 6:08 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 0/5] omap2plus: Trivial build break fixes
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > These are trivial build fixes which I found while doing some
> > testing 'omap-for-linus' branch.
> >
> > The series is generated against the linux-omap 'omap-for-linus'
> branch
> > and boot tested on OMAP4430 SDP and OMAP3630 ZOOM.
>
> Minor nit in your git-send-email config.
>
> Can you add the following to your ~/.gitconfig, or update to newer
> git
> where this is now the default:
>
> [sendemail]
> 	chainreplyto = false
>
> This will make all patches a reply to PATCH 0 instead of to the
> previous
> patch.
>
Have tried this in v2 I posted but it didn't appear to be a
reply for PATCH 0.


May be I missed something.

Regards,
Santosh
