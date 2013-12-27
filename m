From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH V5 2/4] DRIVERS: IRQCHIP: CROSSBAR: Add support for Crossbar
 IP
Date: Fri, 27 Dec 2013 14:07:03 +0530
Message-ID: <52BD3C2F.9010409@ti.com>
References: <1386066445-28245-1-git-send-email-r.sricharan@ti.com> <1386066445-28245-3-git-send-email-r.sricharan@ti.com> <20131226200106.GA30559@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131226200106.GA30559@saruman.home>
Sender: linux-doc-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, linux@arm.linux.org.uk, tony@atomide.com, rnayak@ti.com, marc.zyngier@arm.com, grant.likely@linaro.org, mark.rutland@arm.com, robherring2@gmail.com, tglx@linutronix.de, galak@codeaurora.org, rob.herring@calxeda.com, santosh.shilimkar@ti.com, nm@ti.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Friday 27 December 2013 01:31 AM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Dec 03, 2013 at 03:57:23PM +0530, Sricharan R wrote:
>> +static const struct of_device_id crossbar_match[] __initconst = {
>> +	{ .compatible = "ti,irq-crossbar" },
>> +	{}
>> +};
>> +
>> +int irqcrossbar_init(void)
>> +{
>> +	struct device_node *np;
>> +	np = of_find_matching_node(NULL, crossbar_match);
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	crossbar_of_init(np);
>> +	return 0;
>> +}
> 
> instead, please use IRQCHIP_DECLARE() then you won't need to expose this
> symbol to be used by arch/arm/ code.
> 

Crossbar node does not have a "interrupt-controller" property and
not a regular Interrupt controller. This was added in here
after all below discussions

 https://lkml.org/lkml/2013/9/18/540

So IRQCHIP_DECLARE() macro cannot be used here.

Regards,
 Sricharan
