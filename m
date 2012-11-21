From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 11/16] mfd: omap-usb-host: Manage HSIC clocks for HSIC
 mode
Date: Wed, 21 Nov 2012 17:49:16 +0200
Message-ID: <50ACF7FC.9020704@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-12-git-send-email-rogerq@ti.com> <20121121135451.GM10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121121135451.GM10216-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/21/2012 03:54 PM, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Nov 15, 2012 at 04:34:09PM +0200, Roger Quadros wrote:
>> Enable the optional HSIC clocks (60MHz and 480MHz) for the ports
>> that are configured in HSIC mode.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/mfd/omap-usb-host.c |   56 +++++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 0d39bd7..e5ba193 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -88,6 +88,8 @@
>>  
>>  struct usbhs_port {
>>  	struct clk	*utmi_clk;
>> +	struct clk	*hsic60m_clk;
>> +	struct clk	*hsic480m_clk;
>>  };
>>  
>>  struct usbhs_hcd_omap {
>> @@ -300,6 +302,26 @@ static int usbhs_runtime_resume(struct device *dev)
>>  				}
>>  			}
>>  		}
>> +
>> +		/* Enable HSIC clocks if required */
>> +		if (is_ehci_hsic_mode(pdata->port_mode[i])) {
>> +			if (omap->port[i].hsic60m_clk) {
>> +				r = clk_enable(omap->port[i].hsic60m_clk);
>> +				if (r) {
>> +					dev_err(dev,
>> +					 "%s: Can't enable port %d hsic60m clk : %d\n",
>> +					 __func__, i, r);
>> +				}
>> +			}
>> +			if (omap->port[i].hsic480m_clk) {
>> +				r = clk_enable(omap->port[i].hsic480m_clk);
>> +				if (r) {
>> +					dev_err(dev,
>> +					 "%s: Can't enable port %d hsic480m clk : %d\n",
>> +					 __func__, i, r);
>> +				}
>> +			}
>> +		}
>>  	}
> 
> with this deep indentation, it should've caught your attention that
> something can definitely be re-factored.

OK.

> 
>> @@ -323,6 +345,14 @@ static int usbhs_runtime_suspend(struct device *dev)
>>  			if (omap->port[i].utmi_clk)
>>  				clk_disable(omap->port[i].utmi_clk);
>>  		}
>> +
>> +		if (is_ehci_hsic_mode(pdata->port_mode[i])) {
>> +			if (omap->port[i].hsic60m_clk)
>> +				clk_disable(omap->port[i].hsic60m_clk);
>> +
>> +			if (omap->port[i].hsic480m_clk)
>> +				clk_disable(omap->port[i].hsic480m_clk);
>> +		}
>>  	}
>>  
>>  	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
>> @@ -575,6 +605,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>>  	for (i = 0; i < omap->nports; i++) {
>>  		struct clk *pclk;
>>  		char utmi_clk[] = "usb_host_hs_utmi_px_clk";
>> +		char hsic_clk[] = "usb_host_hs_hsic480m_px_clk";
> 
> same comment from another patch. Was this lazyness ?

:)

> 
>> @@ -590,6 +621,21 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>>  		else
>>  			omap->port[i].utmi_clk = pclk;
>>  
>> +		sprintf(hsic_clk, "usb_host_hs_hsic480m_p%d_clk", i + 1);
> 
> will overflow if 'i' ever goes over 8.
> 
>> +		pclk = clk_get(dev, hsic_clk);
>> +		if (IS_ERR(pclk))
>> +			dev_err(dev, "Failed to get clock : %s : %ld\n",
>> +				hsic_clk, PTR_ERR(pclk));
>> +		else
>> +			omap->port[i].hsic480m_clk = pclk;
>> +
>> +		sprintf(hsic_clk, "usb_host_hs_hsic60m_p%d_clk", i + 1);
> 
> ditto.
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
