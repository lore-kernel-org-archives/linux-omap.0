From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP3 PM: Fix IO Daisychain sequence
Date: Tue, 04 Oct 2011 13:47:48 -0700
Message-ID: <87r52s8owb.fsf@ti.com>
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
	<1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:35523 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933353Ab1JDUrw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Oct 2011 16:47:52 -0400
Received: by mail-qy0-f170.google.com with SMTP id 16so5674964qyl.1
        for <linux-omap@vger.kernel.org>; Tue, 04 Oct 2011 13:47:51 -0700 (PDT)
In-Reply-To: <1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Tue, 4 Oct 2011 23:22:01 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mohanv@ti.com

Hi Vishwa,

Vishwanath BS <vishwanath.bs@ti.com> writes:

> As per OMAP3630 TRM Section 3.5.7.2.2, the right sequence for enabling IO Daisy
> chain is "The I/O wake-up scheme is enabled by triggering the I/O daisy chain
> control (Wu clock) by programming a dedicated register
> (PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN) in the PRCM module.Software must wait for
> the I/O daisy chain to complete before it transitions the PER domain to a
> nonfunctional state. This is done by polling a dedicated status bit in the PRCM
> module (PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN). This status bit must be cleared by
> software when the bit is read to  1".
>
> The original code was polling on a wrong register which is fixed in this patch.
> Also omap3_enable_io_chain is made non static as it's going to be used in
> subsequent patches.
>  
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

A fix for this was posted[1] by Mohan V (added to Cc) back in June.  It
recieved a few minor comments but an updated version was never posted.

Maybe you can ping Mohan or update that version fixing the comments
mentioned in that thread.

Thanks,

Kevin

[1] http://marc.info/?l=linux-omap&w=2&r=1&s=%27Mohan+V%27&q=b
