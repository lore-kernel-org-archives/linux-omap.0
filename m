From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 07/21] genirq: Add =?UTF-8?Q?irqchip=5Fset=5Fwake?=  =?UTF-8?Q?=5Fparent?=
Date: Sat, 10 Jan 2015 12:46:22 +0000
Message-ID: <dd81cd2b499ca6cc595010ebe80d8f89@www.loen.fr>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-8-git-send-email-marc.zyngier@arm.com>
 <20150108151500.GA24705@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150108151500.GA24705@kahuna>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sascha Hauer <kernel@pengutronix.de>, Simon Horman <horms@verge.net.au>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-omap@vger.kernel.org

On 2015-01-08 15:15, Nishanth Menon wrote:
> On 17:42-20150107, Marc Zyngier wrote:
>> This proves to be usefull with stacked domains, when the current
> 			^^ useful ?
> minor:
> +WARNING: 'usefull' may be misspelled - perhaps 'useful'?
> +#6:
> +This proves to be usefull with stacked domains, when the current
> +CHECK: extern prototypes should be avoided in .h files
> +#23: FILE: include/linux/irq.h:463:
> ++extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned
> int on);

Consistency trumps whatever checkpatch says, I'm afraid.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
