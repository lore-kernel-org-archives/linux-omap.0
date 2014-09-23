From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] kbuild: remove unnecessary variable initializaions
Date: Tue, 23 Sep 2014 16:56:01 +0200
Message-ID: <CACRpkdZxLrdvPPwrXgTn_oVntxz_f+GCdsdSbDZ0R0Mre6F_Dg@mail.gmail.com>
References: <1410258381-7088-1-git-send-email-yamada.m@jp.panasonic.com>
	<1410258381-7088-3-git-send-email-yamada.m@jp.panasonic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410258381-7088-3-git-send-email-yamada.m@jp.panasonic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.m@jp.panasonic.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Greg Ungerer <gerg@uclinux.org>, Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 9, 2014 at 12:26 PM, Masahiro Yamada
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
