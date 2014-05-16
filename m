From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: OMAP DSS: panel-dpi and enable gpios
Date: Fri, 16 May 2014 20:28:49 +0200
Message-ID: <CAGhQ9Vxxh=98qG6imYbZpfjzE03Fa=MmKLfzN40ASj=UVUJqVA@mail.gmail.com>
References: <CAGhQ9VxDQaRzjCMm1RfxVmPt7Nk14ZTeS0-BmBfFDcxQNy__Tw@mail.gmail.com>
	<5374BEBD.4060305@ti.com>
	<CAGhQ9VwyrO-G4m8Rv-nEUujEmQn+tkDn+9=BwvhU-ZSk0eFtvg@mail.gmail.com>
	<5375C1F1.7000606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:49447 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757831AbaEPS2u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 14:28:50 -0400
Received: by mail-vc0-f169.google.com with SMTP id ij19so6792175vcb.0
        for <linux-omap@vger.kernel.org>; Fri, 16 May 2014 11:28:49 -0700 (PDT)
In-Reply-To: <5375C1F1.7000606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On 16 May 2014 09:44, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 16/05/14 00:02, Joachim Eastwood wrote:
>> On 15 May 2014 15:18, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> On 12/05/14 20:58, Joachim Eastwood wrote:
>>>> Hello Tomi,
>>>>
>>>> There seems to be a mismatch between your panel-dpi code and DT docs.
>>>>
>>>> The docs state that enable-gpios is optinal but in panel-dpi.c you
>>>> have the following code
>>>> gpio = devm_gpiod_get(&pdev->dev, "enable");
>>>> if (IS_ERR(gpio)) {
>>>>     dev_err(&pdev->dev, "failed to parse enable gpio\n");
>>>>     return PTR_ERR(gpio);
>>>> } else {
>>>>     gpiod_direction_output(gpio, 0);
>>>>     ddata->enable_gpio = gpio;
>>>> }
>>>>
>>>> Making probing fail on my DT since I don't use enable-gpios with
>>>
>>> Would this work? Only compile tested.
>>>
>>> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
>>> index dca6b10d1157..2ac38eaa4c8f 100644
>>> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
>>> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
>>> @@ -210,14 +210,19 @@ static int panel_dpi_probe_of(struct platform_device *pdev)
>>>         struct gpio_desc *gpio;
>>>
>>>         gpio = devm_gpiod_get(&pdev->dev, "enable");
>>> +
>>>         if (IS_ERR(gpio)) {
>>> -               dev_err(&pdev->dev, "failed to parse enable gpio\n");
>>> -               return PTR_ERR(gpio);
>>> +               r = PTR_ERR(gpio);
>>> +               if (r == -EPROBE_DEFER || r != -ENOENT)
>>> +                       return r;
>>> +               else
>>> +                       gpio = NULL;
>>>         } else {
>>>                 gpiod_direction_output(gpio, 0);
>>> -               ddata->enable_gpio = gpio;
>>>         }
>>>
>>> +       ddata->enable_gpio = gpio;
>>> +
>>>         ddata->backlight_gpio = -ENOENT;
>>>
>>>         r = of_get_display_timing(node, "panel-timing", &timing);
>>
>> Seems to do the trick here.
>>
>> Display is showing Tux's on boot up again :)
>
> The check above was a bit too complex. Here's an updated patch.
>
> From f48b44ca73e29b2328e7852d9beb06b161bb1cb4 Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Thu, 15 May 2014 16:19:44 +0300
> Subject: [PATCH] OMAPDSS: panel-dpi: enable-gpio
>
> The enable gpio should be optional, but the driver returns an error if
> it doesn't get the gpio.
>
> So change the driver to accept -ENOENT error.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> index dca6b10d1157..3636b61dc9b4 100644
> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> @@ -210,14 +210,18 @@ static int panel_dpi_probe_of(struct platform_device *pdev)
>         struct gpio_desc *gpio;
>
>         gpio = devm_gpiod_get(&pdev->dev, "enable");
> +
>         if (IS_ERR(gpio)) {
> -               dev_err(&pdev->dev, "failed to parse enable gpio\n");
> -               return PTR_ERR(gpio);
> +               if (PTR_ERR(gpio) != -ENOENT)
> +                       return PTR_ERR(gpio);
> +               else
> +                       gpio = NULL;
>         } else {
>                 gpiod_direction_output(gpio, 0);
> -               ddata->enable_gpio = gpio;
>         }
>
> +       ddata->enable_gpio = gpio;
> +
>         ddata->backlight_gpio = -ENOENT;
>
>         r = of_get_display_timing(node, "panel-timing", &timing);
> --
> 1.9.1

Tested-by: Joachim Eastwood <manabian@gmail.com>

This also works fine.

regards
Joachim Eastwood
