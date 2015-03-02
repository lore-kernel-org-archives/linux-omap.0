From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 05/10] clkdev: add clkdev_create() helper
Date: Mon, 2 Mar 2015 18:22:31 +0100
Message-ID: <CAMuHMdWHAu+zDKce0+ianDb=RHYR59eeMoiYBDK4PC=YMY0JXg@mail.gmail.com>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
	<E1YSTnW-0001Jk-Tm@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <E1YSTnW-0001Jk-Tm@rmk-PC.arm.linux.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 2, 2015 at 6:06 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> --- a/include/linux/clkdev.h
> +++ b/include/linux/clkdev.h
> @@ -37,6 +37,9 @@ struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
>  void clkdev_add(struct clk_lookup *cl);
>  void clkdev_drop(struct clk_lookup *cl);
>
> +struct clk_lookup *clkdev_create(struct clk *clk, const char *con_id,
> +       const char *dev_fmt, ...);

__printf(3, 4)

While you're at it, can you please also add the __printf attribute to
clkdev_alloc() and clk_register_clkdev()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
