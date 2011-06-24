From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 1/6] omap: prcm: switch to a chained IRQ handler mechanism
Date: Fri, 24 Jun 2011 14:02:54 -0700
Message-ID: <87ei2j0wox.fsf@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
	<1308760934-9757-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:51624 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753737Ab1FXVC6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 17:02:58 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so2388829pzk.2
        for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:02:57 -0700 (PDT)
In-Reply-To: <1308760934-9757-2-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 22 Jun 2011 19:42:09 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> Introduce a chained interrupt handler mechanism for the PRCM
> interrupt, so that individual PRCM event can cleanly be handled by
> handlers in separate drivers. We do this by introducing PRCM event
> names, which are then matched to the particular PRCM interrupt bit
> depending on the specific OMAP SoC being used.
>
> arch/arm/mach-omap2/prcm.c implements the chained interrupt mechanism
> itself, with individual PRCM events for OMAP3 and OMAP4 being
> described in arch/arm/mach-omap2/prcm3xxx.c and
> arch/arm/mach-omap2/prcm4xxx.c respectively. At initialization time,
> the set of PRCM events is filtered against the SoC on which we are
> running, keeping only the ones that are actually useful. All the logic
> is written to be generic with regard to OMAP3/OMAP4, even though OMAP3
> has single PRCM event registers and OMAP4 has two PRCM event
> registers.
>
> The wakeup and I/O PRCM events are now handled as two separate
> interrupts, and their handler is registered with IRQF_NO_SUSPEND,
> otherwise the IRQ gets disabled during suspend, which prevents resume.
>
> Patch tested on OMAP4 blaze board, no testing done on OMAP3.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Avinash.H.M <avinashhm@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>

Another minor comment/request:

Can you see if you can keep the chip_is checking out of the generic code
and only in the SoC specific code.  Using the register approach I
mentioned earlier, it should be easy to do the filtering in SoC specific
code before registering so the generic driver doesn't have to care.
IOW, all SoC-specific stuff is done in SoC-specific init and all that is
registered with the generic code is name/offset pairs.

Kevin
