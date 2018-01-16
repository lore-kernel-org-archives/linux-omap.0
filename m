From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v7 5/8] can: m_can: Add PM Support
Date: Tue, 16 Jan 2018 16:35:31 +0530
Message-ID: <e451bf68-051e-31dd-c456-7a76aa5c011f@ti.com>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
 <1515581725-29242-6-git-send-email-faiz_abbas@ti.com>
 <a94cf10c-b40d-9e2e-a4cd-f7e5d0399530@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <a94cf10c-b40d-9e2e-a4cd-f7e5d0399530@pengutronix.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Monday 15 January 2018 07:25 PM, Marc Kleine-Budde wrote:
> On 01/10/2018 11:55 AM, Faiz Abbas wrote:
>> From: Franklin S Cooper Jr <fcooper@ti.com>
>>
>> Add support for CONFIG_PM which is the new way to handle managing clocks.
>>
>> Move the clock management to pm_runtime_resume() and pm_runtime_suspend()
>> callbacks for the driver.
>>
>> CONFIG_PM is required by OMAP based devices to handle clock management.
>> Therefore, this allows future Texas Instruments SoCs that have the MCAN IP
>> to work with this driver.
>>
>> Reviewed-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> [nsekhar@ti.com: handle pm_runtime_get_sync() failure, fix some bugs]
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  drivers/net/can/m_can/m_can.c | 95 ++++++++++++++++++++++++++++---------------
>>  1 file changed, 62 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>> index 07ebe7f..f5c5028 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/iopoll.h>
>>  #include <linux/can/dev.h>
>>  
>> @@ -625,21 +626,16 @@ static int m_can_clk_start(struct m_can_priv *priv)
>>  {
>>  	int err;
>>  
>> -	err = clk_prepare_enable(priv->hclk);
>> -	if (err)
>> -		return err;
>> -
>> -	err = clk_prepare_enable(priv->cclk);
>> +	err = pm_runtime_get_sync(priv->device);
>>  	if (err)
>> -		clk_disable_unprepare(priv->hclk);
>> +		pm_runtime_put_noidle(priv->device);
>>  
>>  	return err;
>>  }
>>  
>>  static void m_can_clk_stop(struct m_can_priv *priv)
>>  {
>> -	clk_disable_unprepare(priv->cclk);
>> -	clk_disable_unprepare(priv->hclk);
>> +	pm_runtime_put_sync(priv->device);
>>  }
>>  
>>  static int m_can_get_berr_counter(const struct net_device *dev,
>> @@ -1561,37 +1557,26 @@ static int m_can_plat_probe(struct platform_device *pdev)
>>  		goto failed_ret;
>>  	}
>>  
>> -	/* Enable clocks. Necessary to read Core Release in order to determine
>> -	 * M_CAN version
>> -	 */
>> -	ret = clk_prepare_enable(hclk);
>> -	if (ret)
>> -		goto disable_hclk_ret;
>> -
>> -	ret = clk_prepare_enable(cclk);
>> -	if (ret)
>> -		goto disable_cclk_ret;
>> -
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
>>  	addr = devm_ioremap_resource(&pdev->dev, res);
>>  	irq = platform_get_irq_byname(pdev, "int0");
>>  
>>  	if (IS_ERR(addr) || irq < 0) {
>>  		ret = -EINVAL;
>> -		goto disable_cclk_ret;
>> +		goto failed_ret;
>>  	}
>>  
>>  	/* message ram could be shared */
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
>>  	if (!res) {
>>  		ret = -ENODEV;
>> -		goto disable_cclk_ret;
>> +		goto failed_ret;
>>  	}
>>  
>>  	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>>  	if (!mram_addr) {
>>  		ret = -ENOMEM;
>> -		goto disable_cclk_ret;
>> +		goto failed_ret;
>>  	}
>>  
>>  	/* get message ram configuration */
>> @@ -1600,7 +1585,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
>>  					 sizeof(mram_config_vals) / 4);
>>  	if (ret) {
>>  		dev_err(&pdev->dev, "Could not get Message RAM configuration.");
>> -		goto disable_cclk_ret;
>> +		goto failed_ret;
>>  	}
>>  
>>  	/* Get TX FIFO size
>> @@ -1612,13 +1597,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
>>  	dev = alloc_candev(sizeof(*priv), tx_fifo_size);
>>  	if (!dev) {
>>  		ret = -ENOMEM;
>> -		goto disable_cclk_ret;
>> +		goto failed_ret;
>>  	}
>>  
>> -	ret = setup_m_can_dev(pdev, dev, addr);
>> -	if (ret)
>> -		goto disable_cclk_ret;
>> -
>>  	priv = netdev_priv(dev);
>>  	dev->irq = irq;
>>  	priv->device = &pdev->dev;
>> @@ -1632,6 +1613,20 @@ static int m_can_plat_probe(struct platform_device *pdev)
>>  	platform_set_drvdata(pdev, dev);
>>  	SET_NETDEV_DEV(dev, &pdev->dev);
>>  
>> +	/* Enable clocks. Necessary to read Core Release in order to determine
>> +	 * M_CAN version
>> +	 */
>> +	pm_runtime_enable(&pdev->dev);
>> +	ret = pm_runtime_get_sync(&pdev->dev);
> 
> Why don't you make use of m_can_clk_start() here?
> 

Sure. Will replace.

Thanks,
Faiz
