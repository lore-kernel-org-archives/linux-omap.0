From: Peter Foley <pefoley2@pefoley.com>
Subject: Re: [PATCH 2/3] kbuild: remove unnecessary variable initializaions
Date: Tue, 9 Sep 2014 12:23:45 -0400
Message-ID: <CAOFdcFOxDSJfT2J382c6X9ryWhtYdfZdBmhxDxrhEkxkiUwx4w@mail.gmail.com>
References: <1410258381-7088-1-git-send-email-yamada.m@jp.panasonic.com> <1410258381-7088-3-git-send-email-yamada.m@jp.panasonic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1410258381-7088-3-git-send-email-yamada.m@jp.panasonic.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.m@jp.panasonic.com>
Cc: linux-kbuild@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Greg Ungerer <gerg@uclinux.org>, Ben Dooks <ben-linux@fluff.org>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 9, 2014 at 6:26 AM, Masahiro Yamada
<yamada.m@jp.panasonic.com> wrote:
> Clearing obj-y, obj-m, obj-n, obj- in each Makefile is
> a useless habit.
>
> They are non-exported variables; therefore they are always empty
> whenever descending into each subdirectory.
> (Moreorver, obj-y and obj-m are also set to empty at the beginning
> of scripts/Makefile.build)
>
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>

Acked-by: Peter Foley <pefoley2@pefoley.com>
