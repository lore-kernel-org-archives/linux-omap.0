From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/11] spi: Provide core support for runtime PM during transfers
Date: Sun, 28 Jul 2013 22:51:31 +0200
Message-ID: <CACRpkdZuUiG0MydJ_k4Br5_10hXr-x4xqNLjWP8D_KFyMPg-zQ@mail.gmail.com>
References: <1375022606-7576-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375022606-7576-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Jul 28, 2013 at 4:43 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> Most SPI drivers that implement runtime PM support use identical code to
> do so: they acquire a runtime PM lock in prepare_transfer_hardware() and
> then they release it in unprepare_transfer_hardware(). The variations in
> this are mostly missing error checking and the choice to use autosuspend.
>
> Since these runtime PM calls are normally the only thing in the prepare
> and unprepare callbacks and the autosuspend API transparently does the
> right thing on devices with autosuspend disabled factor all of this out
> into the core with a flag to enable the behaviour.
>
> Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> + * @auto_runtime_pm: the core should ensure a runtime PM reference is held
> + *                   while the hardware is prepared

I'd mention here that the reference is taken on the parent
device of the SPI master, i.e. the very platform or AMBA
device, so that it will hit upwards to the bus.

Yours,
Linus Walleij
