From: Kevin Hilman <khilman@linaro.org>
Subject: Re: Removing vestiges of CONFIG_USB_SUSPEND
Date: Mon, 06 May 2013 15:47:29 -0700
Message-ID: <87ip2vwwse.fsf@linaro.org>
References: <Pine.LNX.4.44L0.1305011115090.1380-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:55324 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360Ab3EFWrd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 May 2013 18:47:33 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so2194488pbc.23
        for <linux-omap@vger.kernel.org>; Mon, 06 May 2013 15:47:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1305011115090.1380-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Wed, 1 May 2013 11:22:55 -0400 (EDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

Hi Alan,

Alan Stern <stern@rowland.harvard.edu> writes:

> Felipe and Kevin:
>
> While removing the remaining usages of USB_SUSPEND (things that I
> missed in the original patch), I noticed that
> arch/arm/configs/omap2plus_defconfig does not enable PM_RUNTIME -- even
> though it currently does enable USB_SUSPEND, which depends on
> PM_RUNTIME.  Was this an oversight?

Looks like an oversight, but covered up by some other default options
in mach-omap2/Kconfig.  Specifially, config ARCH_OMAP2PLUS_TYPICAL
(default y) does a select PM_RUNTIME.

> In a little while I will submit a patch which removes USB_SUSPEND from
> that file.  You or someone else may want to write a separate patch to
> enable PM_RUNTIME.

I think we'll be covered by our current defaults.

Thanks for the heads up.

Kevin
