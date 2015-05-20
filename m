From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [RFC v1 15/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
Date: Wed, 20 May 2015 20:54:12 +0200
Message-ID: <87mw0zhygb.fsf@belgarion.home>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
	<1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
	(Jiang Liu's message of "Wed, 20 May 2015 18:00:03 +0800")
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Roland Stigge <stigge@antcom.de>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: linux-omap@vger.kernel.org

Jiang Liu <jiang.liu@linux.intel.com> writes:

> diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
> index 2897da2a5df6..0d8331f8536e 100644
> --- a/arch/arm/mach-pxa/pcm990-baseboard.c
> +++ b/arch/arm/mach-pxa/pcm990-baseboard.c
> @@ -287,6 +287,7 @@ static struct irq_chip pcm990_irq_chip = {
>  static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	unsigned long pending;
> +	unsigned int irq;
That doesn't look good, double irq definition.

Cheers.

-- 
Robert
