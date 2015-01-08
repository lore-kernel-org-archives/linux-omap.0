From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 07/21] genirq: Add irqchip_set_wake_parent
Date: Thu, 8 Jan 2015 09:15:01 -0600
Message-ID: <20150108151500.GA24705@kahuna>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-8-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420652576-22309-8-git-send-email-marc.zyngier@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 17:42-20150107, Marc Zyngier wrote:
> This proves to be usefull with stacked domains, when the current
			^^ useful ?
minor:
+WARNING: 'usefull' may be misspelled - perhaps 'useful'?
+#6: 
+This proves to be usefull with stacked domains, when the current
+CHECK: extern prototypes should be avoided in .h files
+#23: FILE: include/linux/irq.h:463:
++extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);

-- 
Regards,
Nishanth Menon
