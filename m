From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 23/23] mfd: omap-usb-host: Don't spam console on clk_set_parent
 failure
Date: Mon, 10 Dec 2012 13:31:22 +0200
Message-ID: <50C5C80A.3090307@ti.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com> <1355134833-5199-24-git-send-email-rogerq@ti.com> <50C5C666.9050105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50C5C666.9050105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: balbi@ti.com, sameo@linux.intel.com, tony@atomide.com, paul@pwsan.com, sshtylyov@mvista.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, keshava_mgowda@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bjorn@mork.no
List-Id: linux-omap@vger.kernel.org

On 12/10/2012 01:24 PM, Rajendra Nayak wrote:
> On Monday 10 December 2012 03:50 PM, Roger Quadros wrote:
>> clk_set_parent is expected to fail on OMAP3 platforms. We don't
>> consider that as fatal so don't spam console.
> 
> And what if it fails on a non-OMAP3 platform?

The driver just prints a debug message and continues to work just as
before. The USB port will not work for the user in that case. He will
have to enable DEBUG flag to see the debug message. I see this behaviour
better than before where all OMAP3 users see the error message for no
reason.

cheers,
-roger

> 
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/mfd/omap-usb-host.c |   18 +++++++++---------
>>   1 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 0bb54393..344ce09 100644
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
>> +            dev_dbg(dev, "xclk60mhsp1_ck set parent failed: %d\n",
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
>> +            dev_dbg(dev, "xclk60mhsp2_ck set parent failed: %d\n",
>> +                    ret);
>>       } else if (is_ehci_tll_mode(pdata->port_mode[1])) {
>>           ret = clk_set_parent(omap->utmi_clk[1],
>>                           omap->init_60m_fclk);
>>           if (ret != 0)
>> -            dev_err(dev, "init_60m_fclk set parent"
>> -                "failed error:%d\n", ret);
>> +            dev_dbg(dev, "P1 init_60m_fclk set parent failed: %d\n",
>> +                    ret);
>>       }
>>
>>       omap_usbhs_init(dev);
>>
> 
