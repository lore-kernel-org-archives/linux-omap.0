From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V6 2/3] ARM: OMAP2+: Replace space=>underscore in the name field of system timers
Date: Wed, 02 May 2012 13:09:58 -0700
Message-ID: <87r4v2fip5.fsf@ti.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
	<1335967014-11937-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:50386 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756951Ab2EBUJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 16:09:57 -0400
Received: by dadz9 with SMTP id z9so376855dad.25
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 13:09:56 -0700 (PDT)
In-Reply-To: <1335967014-11937-3-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Wed, 2 May 2012 19:26:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Depending on the bootloader, passing command-line arguments
> with spaces may have issues. Some bootloaders doesn't seem
> to pass along the quotes, passing only 'gp' part of the string,
> which leads to wrong clocksource override configuration.

For clarity, it would help to specify which command-line options this
affects

> So this patch changes "gp timer" => "gp_timer", for clockevent,
> clocksource and timer irq_handler.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>

With the change above,

Acked-by: Kevin Hilman <khilman@ti.com>

