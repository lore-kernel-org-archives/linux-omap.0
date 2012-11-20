From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 253/493] hwspinlock: remove use of __devinit
Date: Tue, 20 Nov 2012 23:44:36 +0100
Message-ID: <CACRpkdZtKAmFN7R2sSvQN3cb_wKMt9+AK=getXf+Y=Cnf=giHQ@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-253-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60369 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab2KTWoh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 17:44:37 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so1988099eek.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Nov 2012 14:44:36 -0800 (PST)
In-Reply-To: <1353349642-3677-253-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Ohad Ben-Cohen <ohad@wizery.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Nov 19, 2012 at 7:23 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
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
