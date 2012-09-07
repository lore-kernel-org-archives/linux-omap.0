From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Fri, 7 Sep 2012 23:36:41 +0200
Message-ID: <CACRpkdYE_ysxatAoVwDCf25+-1LLffVnQhbtzwpEWMMAWSnE8A@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36537 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab2IGVgm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 17:36:42 -0400
Received: by wibhi8 with SMTP id hi8so232660wib.1
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 14:36:41 -0700 (PDT)
In-Reply-To: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: bryan.wu@canonical.com, rpurdie@rpsys.net, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Sep 1, 2012 at 10:16 AM, AnilKumar Ch <anilkumar@ti.com> wrote:

> Adopt pinctrl support to leds-gpio driver based on leds-gpio
> device pointer, pinctrl driver configure SoC pins to GPIO
> mode according to definitions provided in .dts file.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Looks good from a pinctrl point of view!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
