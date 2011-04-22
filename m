From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 00/18] OMAP: GPIO: cleanup GPIO driver
Date: Fri, 22 Apr 2011 15:34:29 -0700
Message-ID: <87oc3xvrt6.fsf@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:35650 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756572Ab1DVWec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 18:34:32 -0400
Received: by mail-pw0-f47.google.com with SMTP id 9so647063pwj.34
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 15:34:31 -0700 (PDT)
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com> (Charulatha V.'s
	message of "Fri, 22 Apr 2011 16:38:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com

Hi Charu,

Charulatha V <charu@ti.com> writes:

> Modifies the OMAP GPIO driver to avoid usage of cpu_is* checks
> for different OMAP architectures. This is done by moving some
> architecture specific code to mach-omap* and call them from
> plat-omap* using function pointers. Also remove the register offset
> macros from OMAP GPIO driver and handle the same in mach-omap*.

Thanks for working on this cleanup, this driver really needs a cleanup.

You've hit on all the main areas for cleanup, but unfortunately, it's
not really going in the direction I was hoping.  Rather than moving code
into the SoC specific parts, I was hoping to generalize the driver such
that SoC-specific code would just pass in register offsets/options into
the common driver.  Your current approach isn't really reducing code,
it's just moving it around.

I had started on a similar cleanup as well, and will post that series
shortly to demonstrate the direction I think the cleanups should be
going.  I've tackled most of the same functions/areas that you have
(except the IRQ triggering stuff), but have a rather different approach.
I'll get to the IRQ triggering stuff next (after going on vacation for a
week), but feel free to build on top of my series if you like.

The direction I'd like to go is towards having a generalized driver that
can not only work across all OMAP SoCs, but also hopefully towards
something that can be shared with other SoCs as well.  Of course, the
first step is cleaning up the OMAP driver, but the next step will be
looking for other areas of consolidation.  Towards that end, I'm also
working towards converting the GPIO IRQs in this driver to use the new
generic IRQ chip infrastructure posted by Thomas Gleixner.  In my
series, you'll see that I started that for the MPUIO IRQs, but the GPIO
IRQs will come next.

Kevin
