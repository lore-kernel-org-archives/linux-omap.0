From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC v1 15/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
Date: Wed, 20 May 2015 17:28:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505201715380.4225@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Roland Stigge <stigge@antcom.de>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free>
List-Id: linux-omap@vger.kernel.org

On Wed, 20 May 2015, Jiang Liu wrote:
> -static void locomo_handler(unsigned int irq, struct irq_desc *desc)
> +static void locomo_handler(struct irq_desc *desc)
>  {
>  	struct locomo *lchip = irq_desc_get_chip_data(desc);
> +	unsigned int irq;
>  	int req, i;

That leaves irq unitialized ....

Thanks,

	tglx
