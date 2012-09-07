From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Fri, 7 Sep 2012 23:39:48 +0200
Message-ID: <CACRpkdYgcYAFy7bBn3XNcrkSoCpeA8yNaa9LZNd4w33Zp3Jjnw@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
	<201209050513.08588.marex@denx.de>
	<20120905233416.GP1303@atomide.com>
	<201209060405.08997.marex@denx.de>
	<20120906174531.GX1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42443 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab2IGVjt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 17:39:49 -0400
Received: by wibhi8 with SMTP id hi8so234855wib.1
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 14:39:48 -0700 (PDT)
In-Reply-To: <20120906174531.GX1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Marek Vasut <marex@denx.de>, devicetree-discuss@lists.ozlabs.org, rpurdie@rpsys.net, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org

On Thu, Sep 6, 2012 at 7:45 PM, Tony Lindgren <tony@atomide.com> wrote:

>> > The warning should be pinctrl related as the pinctrl drivers may not be
>> > device tree based drivers.
>>
>> Exactly my concern. Also the warning shouldnt be present on systems where
>> pinctrl is disabled.
>
> But pinctrl_get_select() returns 0 in include/linux/pinctrl/consumer.h if
> CONFIG_PINCTRL is not selected, so no warning is produced AFAIK ;)

This is correct, nothing to worry about.

The one troublesome case is if a pinctrl driver is present but not
being used, then you might need to call pinctrl_provide_dummies().

Yours,
Linus Walleij
