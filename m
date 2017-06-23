From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 13/23] clocksource/drivers: Rename clocksource_probe to timer_probe
Date: Fri, 23 Jun 2017 11:56:38 +0800
Message-ID: <CAGb2v65PAg3twJnLmre6MkBoRj7UP_BD0UJf_g2ZttLQX+gpJw@mail.gmail.com>
References: <20170614123800.GH2261@mai> <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
 <1497443984-12371-13-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1497443984-12371-13-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, Tony Lindgren <tony@atomide.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deac>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 14, 2017 at 8:39 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The function name is now renamed to 'timer_probe' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arc/kernel/setup.c                  |  2 +-
>  arch/arm/kernel/time.c                   |  2 +-
>  arch/arm/mach-mediatek/mediatek.c        |  2 +-
>  arch/arm/mach-omap2/timer.c              | 10 +++++-----
>  arch/arm/mach-rockchip/rockchip.c        |  2 +-
>  arch/arm/mach-shmobile/setup-rcar-gen2.c |  2 +-
>  arch/arm/mach-spear/spear13xx.c          |  2 +-
>  arch/arm/mach-sunxi/sunxi.c              |  2 +-

Acked-by: Chen-Yu Tsai <wens@csie.org>
