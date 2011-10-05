From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 1/4] ARM: OMAP3 PM: Fix IO Daisychain sequence
Date: Wed, 5 Oct 2011 09:49:10 +0530
Message-ID: <592e3a0bdb9d2604638d3cf70ff9cc34@mail.gmail.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com><1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
 <87r52s8owb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:55219 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751657Ab1JEETF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 00:19:05 -0400
Received: by mail-wy0-f181.google.com with SMTP id 19so1401081wyf.12
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 21:19:03 -0700 (PDT)
In-Reply-To: <87r52s8owb.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mohan Viswanathan <mohanv@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Wednesday, October 05, 2011 2:18 AM
> To: Vishwanath BS
> Cc: linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; mohanv@ti.com
> Subject: Re: [PATCH 1/4] ARM: OMAP3 PM: Fix IO Daisychain sequence
>
> Hi Vishwa,
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > As per OMAP3630 TRM Section 3.5.7.2.2, the right sequence for
> enabling IO Daisy
> > chain is "The I/O wake-up scheme is enabled by triggering the I/O
> daisy chain
> > control (Wu clock) by programming a dedicated register
> > (PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN) in the PRCM module.Software
> must wait for
> > the I/O daisy chain to complete before it transitions the PER
> domain to a
> > nonfunctional state. This is done by polling a dedicated status
> bit in the PRCM
> > module (PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN). This status bit must
> be cleared by
> > software when the bit is read to  1".
> >
> > The original code was polling on a wrong register which is fixed
> in this patch.
> > Also omap3_enable_io_chain is made non static as it's going to be
> used in
> > subsequent patches.
> >
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
>
> A fix for this was posted[1] by Mohan V (added to Cc) back in June.
> It
> recieved a few minor comments but an updated version was never
> posted.
>
> Maybe you can ping Mohan or update that version fixing the comments
> mentioned in that thread.
OK. I will update the original patchset from Mohan with your comments and
repost.

Vishwa
>
> Thanks,
>
> Kevin
>
> [1] http://marc.info/?l=linux-omap&w=2&r=1&s=%27Mohan+V%27&q=b
