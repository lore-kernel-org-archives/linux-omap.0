From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] gpio/omap: fix off-mode bug: clear debounce clock enable mask on disable
Date: Wed, 24 Oct 2012 07:19:13 -0700
Message-ID: <87pq4854wu.fsf@deeprootsystems.com>
References: <1351015771-6308-1-git-send-email-khilman@deeprootsystems.com>
	<CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45684 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934833Ab2JXOSo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 10:18:44 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so390661pad.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Oct 2012 07:18:44 -0700 (PDT)
In-Reply-To: <CANOLnOOUHJg5W9VbHhnK8ta+Bys_oMpSz9M5jQ0xCeOB1gxtdg@mail.gmail.com>
	(Grazvydas Ignotas's message of "Wed, 24 Oct 2012 15:02:30 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Tue, Oct 23, 2012 at 9:09 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> From: Kevin Hilman <khilman@ti.com>
>>
>> When debounce clocks are disabled, ensure that the banks
>> dbck_enable_mask is cleared also.  Otherwise, context restore on
>> subsequent off-mode transition will restore previous value from the
>> shadow copies (bank->context.debounce*) leading to mismatch state
>> between driver state and hardware state.
>
> This doesn't look right to me, aren't you effectively disabling
> debounce forever here? _gpio_dbck_disable is called from
> omap_gpio_runtime_suspend() and nothing will ever restore
> dbck_enable_mask back to what it was set by _set_gpio_debounce and
> debounce functionality is lost.

Yes, you're right.   Good catch.

I need a fix that's more targetted to the free/reset path.

Linus, please revert if it's not too late, and I'll come up with a more
targetted fix.

Kevin


