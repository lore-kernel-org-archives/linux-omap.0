From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv10 00/14] PRCM chain handler
Date: Fri, 09 Dec 2011 14:36:21 -0800
Message-ID: <87mxb1l6e2.fsf@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:33418 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751079Ab1LIWgZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 17:36:25 -0500
Received: by iakk12 with SMTP id k12so6473139iak.21
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 14:36:24 -0800 (PST)
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 9 Dec 2011 16:27:23 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> Once more a new version, it was decided that the PRM driver will be
> dropped for now, and we will have the chain handler support under
> mach-omap2 directory. This will most likely be addressed in future.

Just to clarify for others: We decided that since the PRM driver is
going to take some more time to sort out, we would at least get the
chained IRQ support in now so we can unblock drivers that need it for
wakeup support (like UART, USB host, etc.)

> Other than that, the code is pretty close to what was in version 9,
> just location has changed from /drivers/mfd to /arch/arm/mach-omap2.
>
> Tested with omap3 beagleboard, with dynamic idle and suspend, both
> retention and off. omap4 should not be an issue seeing the code is
> close to what was in version 9.
>
> TEMP patches can be ignored, they are provided only for testing
> purposes, and shall be replaced by uart runtime support.

Can you repost a series without the TEMP patches, and Cc
linux-arm-kernel as well.

For testing purposes, you can make a branch available with the temp
patches included, and mention it in the changelog.

Thanks,

Kevin
