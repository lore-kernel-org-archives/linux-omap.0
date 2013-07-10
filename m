From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] musb: omap: Fix: pass all the resources to musb core
Date: Wed, 10 Jul 2013 19:09:58 +0530
Message-ID: <51DD642E.2030900@ti.com>
References: <51DAAEEA.60409@cogentembedded.com> <1373453962-21344-1-git-send-email-kishon@ti.com> <20130710112746.GA18966@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130710112746.GA18966-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, inux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 10 July 2013 04:57 PM, Felipe Balbi wrote:
> On Wed, Jul 10, 2013 at 04:29:22PM +0530, Kishon Vijay Abraham I wrote:
>> commit 09fc7d (usb: musb: fix incorrect usage of resource pointer)
>> assumes musb core will always have only 2 resources. But for OMAP
>> platforms there can be 3 resources (2 irq resource and 1 iomem
>> resource). Fixed it here.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>> Changes from v1:
>> *) Removed redundant initialization of *i*
>>
>>  drivers/usb/musb/omap2430.c |   18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>> index 5b6113a..5bbef78 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -481,7 +481,7 @@ static u64 omap2430_dmamask = DMA_BIT_MASK(32);
>>  
>>  static int omap2430_probe(struct platform_device *pdev)
>>  {
>> -	struct resource			musb_resources[2];
>> +	struct resource			musb_resources[3];
>>  	struct musb_hdrc_platform_data	*pdata = pdev->dev.platform_data;
>>  	struct omap_musb_board_data	*data;
>>  	struct platform_device		*musb;
>> @@ -489,6 +489,7 @@ static int omap2430_probe(struct platform_device *pdev)
>>  	struct device_node		*np = pdev->dev.of_node;
>>  	struct musb_hdrc_config		*config;
>>  	int				ret = -ENOMEM;
>> +	int				i;
>>  
>>  	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
>>  	if (!glue) {
>> @@ -571,15 +572,12 @@ static int omap2430_probe(struct platform_device *pdev)
>>  	memset(musb_resources, 0x00, sizeof(*musb_resources) *
>>  			ARRAY_SIZE(musb_resources));
>>  
>> -	musb_resources[0].name = pdev->resource[0].name;
>> -	musb_resources[0].start = pdev->resource[0].start;
>> -	musb_resources[0].end = pdev->resource[0].end;
>> -	musb_resources[0].flags = pdev->resource[0].flags;
>> -
>> -	musb_resources[1].name = pdev->resource[1].name;
>> -	musb_resources[1].start = pdev->resource[1].start;
>> -	musb_resources[1].end = pdev->resource[1].end;
>> -	musb_resources[1].flags = pdev->resource[1].flags;
>> +	for (i = 0; i < ARRAY_SIZE(musb_resources); i++) {
> 
> then this is not enough, what if one device using omap2430.c has 2
> resources and the other has 3 ? and what if a new one has 4 ?
> 
> How about using pdev->num_resources to dynamically allocate
> musb_resources array and using the same thing iterate here ?

Yeah. This looks better.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
