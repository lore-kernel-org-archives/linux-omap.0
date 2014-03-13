From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 4/5] clocksource: omap-timer: Introduce clocksource driver
 for OMAP SoCs
Date: Thu, 13 Mar 2014 13:48:52 -0700
Message-ID: <20140313204851.GB23432@atomide.com>
References: <1394742919-32163-1-git-send-email-joelf@ti.com>
 <1394742919-32163-5-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33598 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755139AbaCMUs6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 16:48:58 -0400
Content-Disposition: inline
In-Reply-To: <1394742919-32163-5-git-send-email-joelf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@TI.com>
Cc: Rob Herring <robh@kernel.org>, Tero Kristo <t-kristo@TI.com>, Nishanth Menon <nm@TI.com>, Suman Anna <s-anna@TI.com>, Felipe Balbi <balbi@TI.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

* Joel Fernandes <joelf@TI.com> [140313 13:43]:
> We introduce functions to initialize clocksource and clockevent, use
> CLOCKSOURCE_OF_DECLARE to declare the clocksource, and handle the clocksource
> selection on a per-SoC basis (Currently only AM335x is supported). Powering up
> of the timer will be done with the help of the mach-omap layer function that's
> introduced earlier in the series.
> 
> We make a local copy of dmtimer API for use by clocksource, the original
> dmtimer API in plat-omap is kept as-is till the migration of all SoCs is
> completed after which it can't be deleted.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  drivers/clocksource/Makefile     |    1 +
>  drivers/clocksource/omap-timer.c | 1157 ++++++++++++++++++++++++++++++++++++++
>  drivers/clocksource/omap-timer.h |  422 ++++++++++++++
>  3 files changed, 1580 insertions(+)
>  create mode 100644 drivers/clocksource/omap-timer.c
>  create mode 100644 drivers/clocksource/omap-timer.h

Hmm this leaves duplicate arch/arm/plat-omap/dmtimer.c code, please
sort out that issue too by allowing omap1 and omap3 still to use
the legacy timer init functions but with timer code under
drivers/clocksource/omap-timer.c.

And not the that drivers/clocksource/omap-timer.h won't be needed at
all, those defines can stay private to the drivers/clocksource/omap-timer.c.

So this patch really should just be moving of the code to the new
location.

Regards,

Tony
