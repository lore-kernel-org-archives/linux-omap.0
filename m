From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 2/8] gpio: omap: simplify omap_set_gpio_dataout_x()
Date: Fri, 20 Mar 2015 19:40:02 +0100
Message-ID: <CABxcv==sXByjSKWenjAzPg5e1AaBVFQE42g7TVBEaJ_FGbHx4Q@mail.gmail.com>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
	<1426785944-17255-3-git-send-email-grygorii.strashko@linaro.org>
	<550C4EA7.9080207@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:33327 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbbCTSkE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 14:40:04 -0400
Received: by weop45 with SMTP id p45so88815994weo.0
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2015 11:40:03 -0700 (PDT)
In-Reply-To: <550C4EA7.9080207@oracle.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Cc: grygorii.strashko@linaro.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On Fri, Mar 20, 2015 at 5:45 PM, santosh.shilimkar@oracle.com
<santosh.shilimkar@oracle.com> wrote:
> On 3/19/15 10:25 AM, grygorii.strashko@linaro.org wrote:
>>
>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>
>> Both functions omap_set_gpio_dataout_reg() and
>> omap_set_gpio_dataout_mask() accept GPIO offset
>> as 'gpio' input parameter, so rename it to 'offset' and
>> drop usage of GPIO_BIT() macro.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>> ---
>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
