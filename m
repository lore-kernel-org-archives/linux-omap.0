From: Kukjin Kim <kgene.kim@samsung.com>
Subject: Re: [PATCH v5 REPOST 2/5] ARM: SMP: Refactor Kconfig to be more
 maintainable
Date: Mon, 19 Dec 2011 00:57:47 +0900
Message-ID: <4EEE0D7B.5080805@samsung.com>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
 <1324053332-6431-3-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1324053332-6431-3-git-send-email-dave.martin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <dave.martin@linaro.org>
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Will Deacon <will.deacon@arm.com>, Daniel Walker <dwalker@fifo99.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, David Brown <davidb@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, linux-arm-msm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, linux-samsung-soc@vger.kernel.org, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.>
List-Id: linux-omap@vger.kernel.org

On 12/17/11 01:35, Dave Martin wrote:
> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.
>
> This patch moves the knowledge of which platforms are SMP-capable
> to the individual machines.  To enable this, a new HAVE_SMP config
> option is introduced to allow machines to indicate that they can
> run in a SMP configuration.
>
> Signed-off-by: Dave Martin<dave.martin@linaro.org>
> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>          (for nomadik, ux500)
> Acked-by: Tony Lindgren<tony@atomide.com>
>          (for omap)

for exynos:
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> ---
>   arch/arm/Kconfig               |   18 ++++++++++++++----
>   arch/arm/mach-exynos/Kconfig   |    1 +
>   arch/arm/mach-imx/Kconfig      |    1 +
>   arch/arm/mach-msm/Kconfig      |    1 +
>   arch/arm/mach-omap2/Kconfig    |    1 +
>   arch/arm/mach-realview/Kconfig |    4 ++++
>   arch/arm/mach-vexpress/Kconfig |    1 +
>   7 files changed, 23 insertions(+), 4 deletions(-)

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
