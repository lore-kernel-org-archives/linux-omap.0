From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv6 1/2] drivers: spi: Add qspi flash controller
Date: Mon, 29 Jul 2013 16:45:02 +0530
Message-ID: <51F64EB6.5020807@ti.com>
References: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
	<1375082550-30544-2-git-send-email-sourav.poddar@ti.com>
	<20130729093128.GE23710@radagast> <51F63FF3.5070304@ti.com>
	<20130729102038.GK23710@radagast> <51F64C49.4080606@ti.com>
	<20130729110902.GE24801@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130729110902.GE24801@radagast>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 29 July 2013 04:39 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, Jul 29, 2013 at 04:34:41PM +0530, Sourav Poddar wrote:
>>>>>> +	irq = platform_get_irq(pdev, 0);
>>>>>> +	if (irq<    0) {
>>>>>> +		dev_err(&pdev->dev, "no irq resource?\n");
>>>>>> +		return irq;
>>>>>> +	}
>>>>>> +
>>>>>> +	spin_lock_init(&qspi->lock);
>>>>>> +
>>>>>> +	qspi->base = devm_ioremap_resource(&pdev->dev, r);
>>>>>> +	if (IS_ERR(qspi->base)) {
>>>>>> +		ret = PTR_ERR(qspi->base);
>>>>>> +		goto free_master;
>>>>>> +	}
>>>>>> +
>>>>>> +	ret = devm_request_threaded_irq(&pdev->dev, irq, ti_qspi_isr,
>>>>>> +			ti_qspi_threaded_isr, IRQF_NO_SUSPEND | IRQF_ONESHOT,
>>>>> why do you need IRQF_NO_SUSPEND ?
>>>>>
>>>> I should get away with this.
>>> why ? Do you need or do you *not* need it ? And in either case, why ?
>>>
>> I was thinking, this will keep the irqs up even when we are
>> hitting suspend, we will not be prepared to handle it. ?
> won't be prepared in what way ?
>
Our driver will be down, so the irq might go un-serviced.


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
