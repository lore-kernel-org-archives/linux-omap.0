From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH v2 2/7] i2c: core: use I2C locking behaviour also for SMBUS
Date: Mon, 4 Mar 2019 13:35:10 +0100
Message-ID: <CAMuHMdXPbsoWD3kJKK25=KL1kXsA23o7-7LsayMSoB=so4-zxw@mail.gmail.com>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com> <20190302134735.4393-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302134735.4393-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Phil Reid <preid@electromag.com.au>, Tero Kristo <t-kristo@ti.com>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 2, 2019 at 2:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> If I2C transfers are executed in atomic contexts, trylock is used
> instead of lock. This behaviour was missing for SMBUS, although a lot of
> transfers are of SMBUS type, either emulated or direct. So, factor out
> the locking routine into a helper and use it for I2C and SMBUS.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Peter Rosin <peda@axentia.se>
> Acked-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
