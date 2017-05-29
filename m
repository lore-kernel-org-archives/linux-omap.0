From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/7] clocksource: Rename clocksource_probe
Date: Mon, 29 May 2017 10:04:34 +0530
Message-ID: <20170529043434.GB5752@vireshk-i7>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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
Cc: "open list:MIPS" <linux-mips@linux-mips.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Rich Felker <dalias@libc.org>, Heiko Stuebner <heiko@sntech.de>, "open list:SUPERH" <linux-sh@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, Russell King <linux@armlinux.org.uk>, Max Filippov <jcmvbkbc@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Icenowy Zheng <icenowy@aosc.xyz>, Andrea Gelmini <andrea.gelmini@gelma.net>, Rob Herring <robh@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Viresh Kumar <vireshk@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, Chen-Yu
List-Id: linux-omap@vger.kernel.org

On 27-05-17, 11:58, Daniel Lezcano wrote:
>  arch/arm/mach-spear/spear13xx.c          |  2 +-

> diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
> index ca2f6a8..31c43ca 100644
> --- a/arch/arm/mach-spear/spear13xx.c
> +++ b/arch/arm/mach-spear/spear13xx.c
> @@ -124,5 +124,5 @@ void __init spear13xx_timer_init(void)
>  	clk_put(pclk);
>  
>  	spear_setup_of_timer();
> -	clocksource_probe();
> +	timer_probe();
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
