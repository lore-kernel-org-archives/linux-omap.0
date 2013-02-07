From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
Date: Thu, 7 Feb 2013 09:51:11 -0600
Message-ID: <5113CD6F.3060108@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com> <1360184596-1603-3-git-send-email-jon-hunter@ti.com> <201302071439.13720.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48806 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758292Ab3BGPvx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Feb 2013 10:51:53 -0500
In-Reply-To: <201302071439.13720.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>, Matt Porter <mporter@ti.com>, Balaji T K <balajitk@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, linux-omap <linux-omap@vger.kernel.org>


On 02/07/2013 08:39 AM, Arnd Bergmann wrote:
> On Wednesday 06 February 2013, Jon Hunter wrote:
>> +static struct of_dma_filter_info info;
> 
> Both members of this structure are constant, so you can just initialize it here,
> and it would be nice to give it a more descriptive name, such as omap_dmadev_info.
> 
>>  static struct platform_driver omap_dma_driver = {
>>  	.probe	= omap_dma_probe,
>>  	.remove	= omap_dma_remove,
>>  	.driver = {
>>  		.name = "omap-dma-engine",
>>  		.owner = THIS_MODULE,
>> +		.of_match_table = of_match_ptr(omap_dma_match)
>>  	},
>>  };
> 
> please end the new line with a comma.

Ok.

>> @@ -673,7 +702,7 @@ static int omap_dma_init(void)
>>  {
>>  	int rc = platform_driver_register(&omap_dma_driver);
>>  
>> -	if (rc == 0) {
>> +	if ((rc == 0) && (!of_have_populated_dt())) {
>>  		pdev = platform_device_register_full(&omap_dma_dev_info);
>>  		if (IS_ERR(pdev)) {
>>  			platform_driver_unregister(&omap_dma_driver);
> 
> There is already a patch in linux-next that makes this obsolete.
> The device is now registered in arch/arm/mach-omap2/dma.c, so
> I guess you have to change that location now.

Thanks. Will rebase on top of linux-next.

Cheers
Jon
