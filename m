From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 23/23] mfd: omap-usb-host: Don't spam console on clk_set_parent
 failure
Date: Wed, 5 Dec 2012 16:13:46 +0200
Message-ID: <50BF569A.1080403@ti.com>
References: <1354631514-24815-1-git-send-email-rogerq@ti.com> <1354631514-24815-8-git-send-email-rogerq@ti.com> <50BF4F30.4030903@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57551 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298Ab2LEOOE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 09:14:04 -0500
In-Reply-To: <50BF4F30.4030903@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: balbi@ti.com, keshava_mgowda@ti.com, bjorn@mork.no, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 12/05/2012 03:42 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 04-12-2012 18:31, Roger Quadros wrote:
> 
>> clk_set_parent is expected to fail on OMAP3 platforms. We don't
>> consider that as fatal so don't spam console.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/mfd/omap-usb-host.c |   18 +++++++++---------
>>   1 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 0bb54393..e5257dc 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -657,32 +657,32 @@ static int __devinit usbhs_omap_probe(struct
>> platform_device *pdev)
>>       }
>>
>>       if (is_ehci_phy_mode(pdata->port_mode[0])) {
>> -        /* for OMAP3 , the clk set paretn fails */
>> +        /* for OMAP3, clk_set_parent fails */
>>           ret = clk_set_parent(omap->utmi_clk[0],
>>                       omap->xclk60mhsp1_ck);
>>           if (ret != 0)
>> -            dev_err(dev, "xclk60mhsp1_ck set parent"
>> -                "failed error:%d\n", ret);
>> +            dev_dbg(dev, "xclk60mhsp1_ck set parent failed : %d\n",
>> +                    ret);
>>       } else if (is_ehci_tll_mode(pdata->port_mode[0])) {
>>           ret = clk_set_parent(omap->utmi_clk[0],
>>                       omap->init_60m_fclk);
>>           if (ret != 0)
>> -            dev_err(dev, "init_60m_fclk set parent"
>> -                "failed error:%d\n", ret);
>> +            dev_dbg(dev, "P0 init_60m_fclk set parent failed: %d\n",
>> +                    ret);
>>       }
>>
>>       if (is_ehci_phy_mode(pdata->port_mode[1])) {
>>           ret = clk_set_parent(omap->utmi_clk[1],
>>                       omap->xclk60mhsp2_ck);
>>           if (ret != 0)
>> -            dev_err(dev, "xclk60mhsp2_ck set parent"
>> -                    "failed error:%d\n", ret);
>> +            dev_dbg(dev, "xclk60mhsp2_ck set parent failed : %d\n",
>> +                    ret);
>>       } else if (is_ehci_tll_mode(pdata->port_mode[1])) {
>>           ret = clk_set_parent(omap->utmi_clk[1],
>>                           omap->init_60m_fclk);
>>           if (ret != 0)
>> -            dev_err(dev, "init_60m_fclk set parent"
>> -                "failed error:%d\n", ret);
>> +            dev_dbg(dev, "P1 init_60m_fclk set parent failed: %d\n",
>> +                    ret);
> 
>    Hm, you sometimes put a space before colon in the error message and
> sometimes not. Inconsistent. :-)
> 

That was because it fit in 80 characters without the space. I'm not sure
what is more important, fitting in 80 or consistency in the print
message. Maybe i should have removed the spaces everywhere so that it is
consistent as well. :)

cheers,
-roger

