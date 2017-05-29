From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 3/7] clocksource: Rename clocksource_probe
Date: Mon, 29 May 2017 09:37:03 +0200
Message-ID: <1764361.KSI3GRbcNJ@diego>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <1495879129-28109-3-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "open list:MIPS" <linux-mips@linux-mips.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Rich Felker <dalias@libc.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, Russell King <linux@armlinux.org.uk>, Max Filippov <jcmvbkbc@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Icenowy Zheng <icenowy@aosc.xyz>, Andrea Gelmini <andrea.gelmini@gelma.net>, Rob Herring <robh@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Viresh Kumar <vireshk@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, Chen-Yu Tsai <wens@csie.org>, Noam Camus <noamc>
List-Id: linux-omap@vger.kernel.org

Am Samstag, 27. Mai 2017, 11:58:44 CEST schrieb Daniel Lezcano:
> The function name is now renamed to 'timer_probe' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
[...]
> diff --git a/arch/arm/mach-rockchip/rockchip.c
> b/arch/arm/mach-rockchip/rockchip.c index ef0500a..5ab834e 100644
> --- a/arch/arm/mach-rockchip/rockchip.c
> +++ b/arch/arm/mach-rockchip/rockchip.c
> @@ -55,7 +55,7 @@ static void __init rockchip_timer_init(void)
>  	}
> 
>  	of_clk_init(NULL);
> -	clocksource_probe();
> +	timer_probe();
>  }
> 
>  static void __init rockchip_dt_init(void)

Acked-by: Heiko Stuebner <heiko@sntech.de>
