From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/5] ARM: Few patches for PM enablement.
Date: Fri, 11 Feb 2011 19:54:46 +0530
Message-ID: <d6a3825e4669b02ddf62ebcc768a500c@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com> <f804b2179a222189b71c9429285de723@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:49369 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756394Ab1BKOYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 09:24:50 -0500
Received: by wyj26 with SMTP id 26so2524038wyj.28
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 06:24:47 -0800 (PST)
In-Reply-To: <f804b2179a222189b71c9429285de723@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, ccross@android.com, catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-arm-kernel@lists.infradead.org

Russell,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Friday, February 04, 2011 3:49 PM
> To: Russell King - ARM Linux
> Cc: linux-omap@vger.kernel.org; ccross@android.com;
> catalin.marinas@arm.com; linus.ml.walleij@gmail.com; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH 0/5] ARM: Few patches for PM enablement.
>

> ARM: gic: Add hooks for architecture specific extensions
> ARM: gic: Add distributor and interface enable/disable accessory api
I plan to submit below to patches to your patch system.

> ARM: twd: Add context save restore support
> ARM: scu: Move register defines to header file
Alternate for these two are already in you tree, so I drop them.

> ARM: smp: Skip secondary cpu calibration to speed-up boot
This one we still haven't agree. So I postpone this one till you
find any other better way to handle this though I really hate that
~ 200 ms in this path.

Regards,
Santosh
