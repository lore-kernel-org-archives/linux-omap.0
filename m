From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 00/12] gpio/omap: Some more driver cleanup and fixes
Date: Mon, 19 Mar 2012 17:37:07 -0700
Message-ID: <87aa3c3y6k.fsf@ti.com>
References: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:48888 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757782Ab2CTAhL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Mar 2012 20:37:11 -0400
Received: by pbcuo1 with SMTP id uo1so1951538pbc.40
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 17:37:09 -0700 (PDT)
In-Reply-To: <1331906760-5259-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Fri, 16 Mar 2012 19:35:48 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> The cleanup is mostly getting rid of redundant fields in struct gpio_bank{}
> as we already have them as part of bank->context now. Also, remove un-used
> variable from gpio_irq_handler. Also, the suspend/resume callbacks are
> removed bacause they are not needed any more.

OK.

> The fixes include correction of _set_gpio_irqenable() implementation,
> missing wakeup_en register update in set_gpio_wakeup(), type mismatch
> of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
> register update in set_gpio_dataout_() and few corrections in context
> save logic.

These fixes need to be separated out from the cleanups and prepared for
v3.4-rc.  We need these as standlone fixes (indepenent of the cleanups)
so they can be applied for 3.4-rc.  The rest of the cleanups will have
to wait until 3.5.

> It is baselined on top of:
> git://git.secretlab.ca/git/linux-2.6.git gpio/next
> Commit: 81b279d80a63628e580c71a31d30a8c3b3047ad4
>
> Series is available here for reference:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_more_cleanup_fixes
>
> Power Test: 
> Off-mode and Retention on OMAP3430 (Suspend and Idle paths).
> Also confirmed that dataout register content preserved over
> off-mode.

I've confirmed these fixes also correct off-mode GPIO ouptut glitches
that I was seeing on n900.

Kevin
