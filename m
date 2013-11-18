From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/8] gpio: twl4030: Fix passing of pdata in the device
 tree case
Date: Mon, 18 Nov 2013 23:46:55 +0100
Message-ID: <CACRpkdZtA2rh5qe5Qs0OKjrChxHZV8MG=UUDdy9fb0Lvq2KtxQ@mail.gmail.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
	<1384396537-3486-7-git-send-email-tony@atomide.com>
	<20131118182724.GO10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:64954 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab3KRWq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Nov 2013 17:46:56 -0500
Received: by mail-oa0-f43.google.com with SMTP id g12so8043510oah.30
        for <linux-omap@vger.kernel.org>; Mon, 18 Nov 2013 14:46:55 -0800 (PST)
In-Reply-To: <20131118182724.GO10317@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Mon, Nov 18, 2013 at 7:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [131113 18:37]:
>> We still have some legacy code needing the callback functions
>> that won't work properly without platform data. To use platform
>> data for twl4030-gpio, we need to not trash the possible data.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: linux-gpio@vger.kernel.org
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>
>> If this looks OK, I'd like to merge this as a fix via arm-soc tree
>> along with the other patches in this series as my later patches
>> depend on patches in this series.
>
> Here's this one with a fix from Fengguang Wu to use struct assignment
> instead of memcpy folded in.

Looks allright:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
