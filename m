From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Mon, 10 Sep 2012 21:40:12 +0200
Message-ID: <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53607 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758460Ab2IJTkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 15:40:14 -0400
Received: by weyx8 with SMTP id x8so1510857wey.19
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 12:40:12 -0700 (PDT)
In-Reply-To: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>, tony@atomide.com
Cc: bryan.wu@canonical.com, rpurdie@rpsys.net, devicetree-discuss@lists.ozlabs.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@wwwdotorg.org>, Grant Likely <grant.likely@secretlab.ca>

On Sat, Sep 1, 2012 at 10:16 AM, AnilKumar Ch <anilkumar@ti.com> wrote:

> Adopt pinctrl support to leds-gpio driver based on leds-gpio
> device pointer, pinctrl driver configure SoC pins to GPIO
> mode according to definitions provided in .dts file.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

So looking back at this after Stephen posed a real good
question, when you say "configure SoC pins to GPIO
mode", does that mean anything else than to mux them into
GPIO mode?

In that case, have you considered augmenting
pinctrl-single.c to implement .gpio_request_enable()
.gpio_disable_free() and maybe also .gpio_set_direction()
in its struct pinmux_ops pinmux backend?

If not, why?

Currently it looks like this:

static int pcs_request_gpio(struct pinctrl_dev *pctldev,
                        struct pinctrl_gpio_range *range, unsigned offset)
{
        return -ENOTSUPP;
}

static struct pinmux_ops pcs_pinmux_ops = {
        .get_functions_count = pcs_get_functions_count,
        .get_function_name = pcs_get_function_name,
        .get_function_groups = pcs_get_function_groups,
        .enable = pcs_enable,
        .disable = pcs_disable,
        .gpio_request_enable = pcs_request_gpio,
};

Yours,
Linus Walleij
