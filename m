From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] ARM: configs: Cleanup old Kconfig options
Date: Mon, 3 Feb 2020 12:52:45 +0100
Message-ID: <CAJKOXPf5Mf4FCmtME5yJsBZeP8BkYJgcxkKzS2hd-gp-mq3nag@mail.gmail.com>
References: <20200130195525.4525-1-krzk@kernel.org> <20200130195525.4525-2-krzk@kernel.org>
 <9f8a0a8e09893e7087d2212fb0eeb94a908b7be1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9f8a0a8e09893e7087d2212fb0eeb94a908b7be1.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Russell King <linux@armlinux.org.uk>, Alexander Shiyan <shc_work@mail.ru>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali>
List-Id: linux-omap@vger.kernel.org

On Thu, 30 Jan 2020 at 23:06, Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-01-30 at 20:55 +0100, Krzysztof Kozlowski wrote:
> > CONFIG_MMC_BLOCK_BOUNCE is gone since commit c3dccb74be28 ("mmc: core:
> > Delete bounce buffer Kconfig option").
> >
> > CONFIG_LBDAF is gone since commit 72deb455b5ec ("block: remove
> > CONFIG_LBDAF").
> >
> > CONFIG_IOSCHED_DEADLINE and CONFIG_IOSCHED_CFQ are gone since
> > commit f382fb0bcef4 ("block: remove legacy IO schedulers").
> >
> > The IOSCHED_DEADLINE was replaced by MQ_IOSCHED_DEADLINE and it will be
> > now enabled by default (along with MQ_IOSCHED_KYBER).
> >
> > The IOSCHED_BFQ seems to replace IOSCHED_CFQ so select it in configs
> > previously choosing the latter.
> >
> > CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
> > CONFIG_CROSS_COMPILE support").
>
> Hi Krzysztof.
>
> There seems there are a lot more of these unused CONFIG_<foo>
> symbols in various defconfigs. (just for arm and treewide below)
>
> ARM defconfigs:

Hi Joe,

Nice finding! The trickier point is to nicely remove them because:
1. The easiest is 'savedefconfig' but then some valuable options might
disappear (like recently happened with DEBUG_FS),
2. They could be removed in automated way with a script. However in
such case what about replacements? If some symbol was replaced with
other (or just renamed), maybe we should enable the other one to
restore the desired functionality?
3. Or maybe let's don't care about keeping defconfigs stable and just
clean them up automatically.

Best regards,
Krzysztof

> --------------------------------------------------------------------
>
> # find all defined config symbols in Kconfig files
>
> $ git grep -P -oh '^\s*(?:menu)?config\s+\w+' -- '*/Kconfig*' | \
>   sed -r -e 's/\s*config\s+//' -e 's/\s*menuconfig\s+//' | \
>   sort | uniq > config_symbols
>
> # find CONFIG_ symbols in arm defconfigs
>
> $ git grep -w -oh -P 'CONFIG_\w+' 'arch/arm*/*defconfig*' | \
>   sort | uniq > used_in_arm_defconfigs
>
> # find all the unused symbols
>
> $ cat used_in_arm_defconfigs | \
>   while read line ; do \
>     echo -n "$line " ; grep -w -c ${line/CONFIG_/} config_symbols ; \
>   done | \
>   grep " 0" | \
>   sed 's/ 0//'

(...)
