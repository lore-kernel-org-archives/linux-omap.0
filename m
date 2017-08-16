From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ARM: Convert to using %pOF instead of full_name
Date: Wed, 16 Aug 2017 22:27:44 +0200
Message-ID: <CAK8P3a0UfQ6fThn61Dch1TKPvKkF+7RtDwbv+xhSoWPHNC60hg@mail.gmail.com>
References: <20170721192835.25555-1-robh@kernel.org> <CAL_JsqJQ7yUhtJca1hupd5zSqo5RTj5k5zc_Ueex1nzbOnjXdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJQ7yUhtJca1hupd5zSqo5RTj5k5zc_Ueex1nzbOnjXdw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "arm@kernel.org" <arm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>"linux-arm-kernel@lists.infradead.org" <linux>
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 10, 2017 at 12:06 AM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Jul 21, 2017 at 2:28 PM, Rob Herring <robh@kernel.org> wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>>  arch/arm/kernel/cpuidle.c            | 4 ++--
>>  arch/arm/kernel/devtree.c            | 5 ++---
>>  arch/arm/kernel/topology.c           | 3 +--
>>  arch/arm/mach-exynos/suspend.c       | 7 +++----
>>  arch/arm/mach-imx/gpc.c              | 4 ++--
>>  arch/arm/mach-mvebu/kirkwood.c       | 3 +--
>>  arch/arm/mach-omap2/omap-wakeupgen.c | 4 ++--
>>  arch/arm/mach-omap2/omap_hwmod.c     | 4 ++--
>>  arch/arm/mach-rockchip/platsmp.c     | 4 ++--
>>  arch/arm/mach-shmobile/pm-rmobile.c  | 7 +++----
>>  10 files changed, 20 insertions(+), 25 deletions(-)
>
> Arnd, Olof,
>
> Can you please apply this one.

Applied to next/cleanup now, with the Acks. I think that should be the last
patch of this series that you wanted me to apply. Can you double-check
and maybe re-submit any patches I may have missed?

        Arnd
