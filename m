From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
Date: Wed, 5 Dec 2018 12:50:51 +0100
Message-ID: <CACRpkdbaU03uDbHnRuCp0ef2Zzbb4XcAGgUCn=xBfAxuCEciOw@mail.gmail.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Cory Maccarrone <darkstar6262@gmail.com>, David Dajun Chen <dchen@diasemi.com>, Dong Aisheng <dong.aisheng@linaro.org>, Eric Miao <eric.miao@marvell.com>, Graeme Gregory <gg@slimlogic.co.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Haojian Zhuang <haojian.zhuang@marvell.com>, jinyoungp@nvidia.com, Jorge Eduardo Candelaria <jedu@slimlogic.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mattias NILSSON <mattias.i.nilsson@stericsson.com>, Michael Hennerich <michael.hennerich@analog.com>, Mike Rapoport <mike@compulab.co.il>, ext Tony Lindgren <tony@atomide.com>, Ve
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 3, 2018 at 5:24 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> [v1 --> v2: add some more commits as requested by Lee (MFD maintainer),
>  update the 00/NN text; re-do build and link testing on new linux-next. ]
>
> This group of MFD drivers are all controlled by "bool" Kconfig settings,
> but contain various amounts of largely pointless uses of infrastructure
> related to modular operations, even though they can't be built modular.
>
> We can easily remove/replace all of it.  We are trying to make driver
> code consistent with the Makefiles/Kconfigs that control them.  This
> means not using modular functions/macros for drivers that can never be
> built as a module.  Some of the downfalls this oversight leads to are:

This series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

IMO it is clearly the right thing to do, moving a whole bunch
of clutter out of the way so we can see clearly and the effect
of getting rid of the <linux/module.h> is a substantial improvement
in its own right.

Yours.
Linus Walleij
