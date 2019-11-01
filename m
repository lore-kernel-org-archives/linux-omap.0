From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v5 net-next 06/12] net: ethernet: ti: introduce cpsw
 switchdev based driver part 1 - dual-emac
Date: Fri, 1 Nov 2019 22:34:57 +0200
Message-ID: <24b1623d-48df-328a-eda7-4195e9df2b22@ti.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024100914.16840-7-grygorii.strashko@ti.com>
 <20191029123230.GM15259@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191029123230.GM15259@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 29/10/2019 14:32, Andrew Lunn wrote:
>> +static int cpsw_probe(struct platform_device *pdev)
>> +{
>> +	const struct soc_device_attribute *soc;
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *ss_res;
>> +	struct cpsw_common *cpsw;
>> +	struct gpio_descs *mode;
>> +	void __iomem *ss_regs;
>> +	int ret = 0, ch;
>> +	struct clk *clk;
>> +	int irq;
>> +
> 
> ...
> 
>> +
>> +	/* setup netdevs */
>> +	ret = cpsw_create_ports(cpsw);
>> +	if (ret)
>> +		goto clean_unregister_netdev;
> 
> At this point, the slave ports go live. If the kernel is configured
> with NFS root etc, it will start using the interfaces.
> 
> +
>> +	/* Grab RX and TX IRQs. Note that we also have RX_THRESHOLD and
>> +	 * MISC IRQs which are always kept disabled with this driver so
>> +	 * we will not request them.
>> +	 *
>> +	 * If anyone wants to implement support for those, make sure to
>> +	 * first request and append them to irqs_table array.
>> +	 */
>> +
>> +	ret = devm_request_irq(dev, cpsw->irqs_table[0], cpsw_rx_interrupt,
>> +			       0, dev_name(dev), cpsw);
>> +	if (ret < 0) {
>> +		dev_err(dev, "error attaching irq (%d)\n", ret);
>> +		goto clean_unregister_netdev;
>> +	}
>> +
>> +	ret = devm_request_irq(dev, cpsw->irqs_table[1], cpsw_tx_interrupt,
>> +			       0, dev_name(dev), cpsw);
>> +	if (ret < 0) {
>> +		dev_err(dev, "error attaching irq (%d)\n", ret);
>> +		goto clean_unregister_netdev;
>> +	}
> 
> Are there any race conditions if the network starts using the devices
> before interrupts are requested? To be safe, maybe this should be done
> before the slaves are created?

Usually during boot - there is no parallel probing (as opposite to modules loading by
udev, for example). Also, there is barrier init call deferred_probe_initcall() to ensure all
drivers probed before going to mount rootfs.

So, i do not think this could cause any issue - max few packets will be delayed
until kernel will switch back here, but the chances that ndo_open will be finished before probe ->0.

-- 
Best regards,
grygorii
