From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM
 with the PM core
Date: Fri, 2 May 2014 16:35:44 +0200
Message-ID: <CAMuHMdUGdfF8x58dz46VWNsC4X0cmFng39Z2xSO_pXYqn9u=HA@mail.gmail.com>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
	<1398334403-26181-4-git-send-email-geert+renesas@glider.be>
	<CAPDyKFpTwPDu9afhOjhhQ2PKGFB+hWsp=mcaYTq8OvuGF7yT3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47227 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbaEBOfp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2014 10:35:45 -0400
In-Reply-To: <CAPDyKFpTwPDu9afhOjhhQ2PKGFB+hWsp=mcaYTq8OvuGF7yT3Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Felipe Balbi <balbi@ti.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Ulf,

On Fri, May 2, 2014 at 10:56 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> +static int of_clk_pm_runtime_suspend(struct device *dev)
>> +{
>> +       int ret;
>> +
>> +       ret = pm_generic_runtime_suspend(dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = pm_clk_suspend(dev);
>
> What about slow clocks? Those aren't handled with pm_clk_suspend().

How are slow clocks handled?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
