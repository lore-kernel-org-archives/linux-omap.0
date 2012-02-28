From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/6] ARM: OMAP4: core retention support
Date: Mon, 27 Feb 2012 17:25:55 -0800
Message-ID: <87d38zrboc.fsf@ti.com>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:56533 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965198Ab2B1BZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 20:25:56 -0500
Received: by mail-pw0-f43.google.com with SMTP id ro2so38498270pbb.30
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 17:25:56 -0800 (PST)
In-Reply-To: <1330003320-17400-1-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Thu, 23 Feb 2012 15:21:54 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> This set adds core retention support on top of mainline. The set
> also adds IO CHAIN wakeup capability for OMAP4, which is a nice feature
> to have while trying suspend / resume with CSWR as it is quite difficult
> to wake up the device without this.
>
> Patch 6 might cause some stir, but this is needed as omap4 PRCM chain
> handler currently does not work without SPARSE_IRQ. Enabling the
> SPARSE_IRQ causes a WARN from gic during boot for omap4, and attempting
> to fix this creates some spam from interrupt handling code which seems to
> originate from GPMC/GPIO. Also, omap3 boot breaks completely,
> thus it is impossible to enable this option as of now.
>
> Tested on OMAP4 blaze board, with OMAP4430 EMU chip. Suspend / resume
> works nicely, and wakeup with UART3 works. The powerdomain state info
> under pm-debug appears to be somewhat bogus right after boot, but fixes
> itself during suspend. This should be addressed separately. Also
> verified that suspend / resume with OMAP3 beagle is okay.

Please separate out the IO daisy chain stuff as a separate series.

Vishwa had a multiple patch series that cleaned some of this up and
also made it common for OMAP3 and 4.

   http://marc.info/?l=linux-omap&m=132387916807059&w=2

I had several review comments on that series that were never responded
to, 

   http://marc.info/?l=linux-omap&w=2&r=1&s=DaisyChain&q=b

so I'd first like to understand why that series was dropped and only
selected parts were taken for $SUBJECT series, and what is the plan for
the IO daisy chain series.

Kevin
