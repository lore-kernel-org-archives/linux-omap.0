From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 0/6] ARM: OMAP3PLUS: IO daisychain support fixes
Date: Mon, 05 Mar 2012 16:32:21 -0800
Message-ID: <877gyyin6y.fsf@ti.com>
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57911 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932091Ab2CFAcX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 19:32:23 -0500
Received: by mail-pz0-f47.google.com with SMTP id o14so5066929dad.34
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 16:32:23 -0800 (PST)
In-Reply-To: <1330525621-29836-1-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Wed, 29 Feb 2012 16:26:55 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> Hi,
>
> The previous version of this set was sent by Vishwanath BS, but as he
> is busy with other stuff, I am taking over.
>
> Some basic info about this set based on comments received on set v2.
> IO chain is now enabled always, and a re-trigger for the chain is
> done during hwmod enable / disable. This means that IO chain is always
> armed according to the latest pad specific WAKE_ENABLE setting, and
> if it is modified, the IO chain needs to be re-armed (thus the hooks
> within omap_hwmod code.) Having IO chain armed all the time allows us
> to receive IO event interrupts even during non-sleep states if the
> corresponding hardware module is disabled, and is unable to detect any
> IO activity itself.
>
> Version 3 contains the following changes:
>
> - global: renamed *_trigger_wuclk_ctrl funcs as *_trigger_io_chain
> - patch 3: added trigger WUCLKIN disable at the end of omap4_trigger_io_chain
>   (fix pulled from the omap4 core retention set)
> - patch 5: added function pointer for using machine specific io_chain trigger
>   function, initialized during boot
> - patch 7 dropped as the support capability for omap3 is now handled as
>   part of patch 5 init
>
> Tested on omap3 beagle + omap4 blaze boards. Suspend / resume works, and
> hwmod_io interrupts are generated. Omap4 was tested with the core retention
> support set.

Reviewed-by: Kevin Hilman <khilman@ti.com>

I also tested this on 3430/n900 and verified IO wakeups are working as
expected.

Tested-by: Kevin Hilman <khilman@ti.com>

Paul, as discussed on IRC, when you're OK with it, this can go through
your queue since it's mostly PRM core code.

Kevin
