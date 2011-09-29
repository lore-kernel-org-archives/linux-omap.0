From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
Date: Thu, 29 Sep 2011 23:30:28 +0200
Message-ID: <CAKnu2Mp4QnQPwcGJCrfMqS6VcfvvvAxginjJkLG1mPLO0WJBUw@mail.gmail.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
	<1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53569 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab1I2Vaa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Sep 2011 17:30:30 -0400
Received: by wyg34 with SMTP id 34so439126wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 29 Sep 2011 14:30:28 -0700 (PDT)
In-Reply-To: <1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

2011/9/8 Santosh Shilimkar <santosh.shilimkar@ti.com>:

> Local timer clock is sourced from the CPU clock and hence changes
> along with CPU clock. These per CPU local timers are used as
> clock-events, so they need to be reconfigured on CPU frequency
> change as part of CPUfreq governor.

This requires patch 6956/2 right?
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6956/2

Can I add your Tested-by: to the patch as well?

Yours,
Linus Walleij
