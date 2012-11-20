From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 403/493] hwspinlock: remove use of __devexit
Date: Tue, 20 Nov 2012 23:45:20 +0100
Message-ID: <CACRpkdZCy_RwSTp+jm_sBmEroVn8YS3CAzvxvoN3uXoLDPWH=w@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-403-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:50544 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab2KTWpV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 17:45:21 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so2585473eaa.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Nov 2012 14:45:20 -0800 (PST)
In-Reply-To: <1353349642-3677-403-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Ohad Ben-Cohen <ohad@wizery.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Nov 19, 2012 at 7:25 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
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
