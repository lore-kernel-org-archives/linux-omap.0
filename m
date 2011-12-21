From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH V2] am35xx-emac: move generic EMAC init to separate file
Date: Wed, 21 Dec 2011 09:50:29 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8064441@DBDE01.ent.ti.com>
References: <1324423590-32489-1-git-send-email-yanok@emcraft.com>
 <79CD15C6BA57404B839C016229A409A8063F1C@DBDE01.ent.ti.com>
 <4EF1A387.2030708@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48388 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab1LUJuo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Dec 2011 04:50:44 -0500
In-Reply-To: <4EF1A387.2030708@emcraft.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sasha_d@emcraft.com" <sasha_d@emcraft.com>


> -----Original Message-----
> From: Ilya Yanok [mailto:yanok@emcraft.com]
> Sent: Wednesday, December 21, 2011 2:45 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; sasha_d@emcraft.com
> Subject: Re: [PATCH V2] am35xx-emac: move generic EMAC init to separate
> file
> 
> Hi,
> 
> On 21.12.2011 10:07, Hiremath, Vaibhav wrote:
> >> +static struct resource am35xx_mdio_resources[] = {
> >> +	{
> >> +		.start  = AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_MDIO_OFFSET,
> >> +		.end    = AM35XX_IPSS_EMAC_BASE + AM35XX_EMAC_MDIO_OFFSET +
> >> +			  SZ_4K - 1,
> >> +		.flags  = IORESOURCE_MEM,
> >> +	},
> >> +};
> > This will not be board independent, using AM35xx everywhere.
> 
> Why? It will work for any AM35XX based board. Probably we can try and
> make it work with EMACs on other AM3XXXs but I don't have these devices.
> 
> > To make it completely board independent, you should get all this
> platform
> > specific data from board file. Probably have emac_init() function here
> and
> > pass the data.
> 
> Hm.. This data is SoC-dependent not board-dependent, what's the reason
> to move it to the board file?
> 
[Hiremath, Vaibhav] My bad. I got confused between 3530 and AM35x...
Yeup, this is SoC specific thing for AM3517/05 device.

Thanks,
Vaibhav

> > Do you know any other platform or device using this IP?
> 
> Yes, I have a couple of AM3517 based boards that use this IP.
> 
> Regards, Ilya.
