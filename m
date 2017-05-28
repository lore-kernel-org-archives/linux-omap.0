From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/7] clocksource: Rename clocksource_probe
Date: Sun, 28 May 2017 15:49:38 +0200
Message-ID: <CACRpkdZGUkcpE97cQ6a=tk-UZZf6j4MwRh+xq9L0LzuaGNaUKQ@mail.gmail.com>
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
Cc: "open list:MIPS" <linux-mips@linux-mips.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Rich Felker <dalias@libc.org>, Heiko Stuebner <heiko@sntech.de>, "open list:SUPERH" <linux-sh@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, Russell King <linux@armlinux.org.uk>, Max Filippov <jcmvbkbc@gmail.com>, Ray Jui <ray.jui@broadcom.com>, Icenowy Zheng <icenowy@aosc.xyz>, Andrea Gelmini <andrea.gelmini@gelma.net>, Rob Herring <robh@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Viresh Kumar <vireshk@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, Chen-Yu Tsai <wens@csie.org>, Noam Camus <noamc@ezchip>
List-Id: linux-omap@vger.kernel.org

On Sat, May 27, 2017 at 11:58 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> The function name is now renamed to 'timer_probe' for consistency with
> the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
