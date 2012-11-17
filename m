From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: twl4030: Use only TWL4030_MODULE_LED for LED configuration
Date: Sat, 17 Nov 2012 21:16:10 +0100
Message-ID: <CACRpkdayZK2sPXJW=COFi7C=P5=fbi-q7UukWbQ8dheaJ=bjAA@mail.gmail.com>
References: <1352799313-21019-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34580 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab2KQUQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Nov 2012 15:16:11 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so465700eek.19
        for <linux-omap@vger.kernel.org>; Sat, 17 Nov 2012 12:16:10 -0800 (PST)
In-Reply-To: <1352799313-21019-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, Nov 13, 2012 at 10:35 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> Avoid using the TWL4030_MODULE_PWMA/B as module ID. The LEDEN, PWMA ON/OFF
> and PWMB ON/OFF registers are in a continuous range starting from LED base.
> This is going to be helpful for further cleanup in the twl stack.
>
> No functional changes.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

OK if you say so.

Patch applied!

Yours,
Linus Walleij
