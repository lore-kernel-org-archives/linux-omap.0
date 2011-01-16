From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: State of SDP4430 platform
Date: Sun, 16 Jan 2011 11:55:47 +0530
Message-ID: <a40bc7a304b60cef73a3a0cfb84b2ee8@mail.gmail.com>
References: <20110116010936.GA21795@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:33451 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750979Ab1APG0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Jan 2011 01:26:06 -0500
Received: by fxm9 with SMTP id 9so4687610fxm.17
        for <linux-omap@vger.kernel.org>; Sat, 15 Jan 2011 22:25:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Sunday, January 16, 2011 11:37 AM
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org
> Subject: Re: State of SDP4430 platform
>
> On Sun, 16 Jan 2011, Russell King - ARM Linux wrote:
>
> > It's probably best if I just quote the boot log, and people see
> about
> > fixing the masses of WARN_ON()s.  Notice that it completely
> obliterates
> > the early part of the boot log due to the number of WARN_ON()s
> > triggered.
>
> These come from the clockdomain code, which is missing quite a bit
> of
> OMAP4 implementation.  Some patches to add that code in have been
> posted
> for the 2.6.39 timeframe[1][2], so it should be reasonable to use
> something like the following patch for 2.6.38, which converts those
> backtraces to pr_err()s.
>
I was just typing the same about clockdomain WARNS(). Till the
clockdomain split series is ready for merge, I guess your below
patch can be merged.

> > Other stuff that shows in this boot log:
>
> ...
>
> > - Bunch of regulators are returning errors (is this a problem?)
> > - I2C timeouts which add quite a bit to the boot-time
>
> These two are probably related.  Looks like something is wrong with
> communication with the TWL/TPS PMIC on that board.  Those problems
> don't
> show up on the OMAP4430ES2 Panda here, so they are probably
> 4430SDP-specific.
>
>
Actually I don't see these errors which ring a bell. There was an
I2C pull related issue with ES1.0 silicon. I guess these timeouts
would show up only on ES1.0 OMAP4 boards and not on ES2.0 boards.

Monday I will check on my ES1.0 board and if needed send an updated
bootloader ( setting up right pull values) or a patch to kernel.

[....]

>
> [PATCH] OMAP4: clockdomain: bypass unimplemented wake-up dependency
> functions on OMAP4
>
> Clockdomain functions that manipulate wake-up dependencies are not
> implemented yet on OMAP4 for 2.6.38.  This patch bypasses the
> OMAP2/3
> functions on OMAP4, which in turn avoids the warnings when the
> functions would attempt to call the underlying OMAP2/3 PRCM
> functions.
>
> A clockdomain wake-up and sleep dependency implementation for OMAP4
> from Rajendra should be possible to merge during the 2.6.39 merge
> window:
>
>     http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg41748.html
>
>     http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg42222.html
>
>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Beno=C4=ABt Cousson <b-cousson@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
Have tried similar fix to remove WARNS() but since
Rajendra's split series was addressing it correctly,
I dropped that patch.

Anyways...

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
