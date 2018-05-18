From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
Date: Sat, 19 May 2018 00:21:14 +0300
Message-ID: <CAHp75VdNUW6KoM6oupyQ80A1WVRk7vewwDt6WEZOyjrAUifqRg@mail.gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com> <20180518210954.29044-5-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518210954.29044-5-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>, linux-fbdev@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: linux-omap@vger.kernel.org

On Sat, May 19, 2018 at 12:09 AM, Janusz Krzysztofik
<jmkrzyszt@gmail.com> wrote:

> +       gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
> +       if (!IS_ERR_OR_NULL(gpiod_rdy)) {

So, is it optional or not at the end?
If it is, why do we check for NULL?

>                 this->dev_ready = ams_delta_nand_ready;
>         } else {
>                 this->dev_ready = NULL;
>                 pr_notice("Couldn't request gpio for Delta NAND ready.\n");

dev_notice() ?

>         }

> +err_gpiod:
> +       if (err == -ENODEV || err == -ENOENT)
> +               err = -EPROBE_DEFER;

Hmm...

-- 
With Best Regards,
Andy Shevchenko
