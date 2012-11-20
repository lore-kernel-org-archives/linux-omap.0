From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 064/493] hwspinlock: remove use of __devexit_p
Date: Tue, 20 Nov 2012 23:44:21 +0100
Message-ID: <CACRpkdbY7V50oZFiAj7+TaxcNFueB+f-ZMF21t0sn_STmsgoVg@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-64-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:41953 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab2KTWoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 17:44:22 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so2585179eaa.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Nov 2012 14:44:21 -0800 (PST)
In-Reply-To: <1353349642-3677-64-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Ohad Ben-Cohen <ohad@wizery.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Nov 19, 2012 at 7:20 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
