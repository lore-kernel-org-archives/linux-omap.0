From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] am35xx-emac: move generic EMAC init to separate file
Date: Thu, 15 Dec 2011 11:39:35 +0200
Message-ID: <4EE9C057.6010204@compulab.co.il>
References: <1321490199-24371-1-git-send-email-yanok@emcraft.com> <20111208001503.GV31337@atomide.com> <4EE93564.3010006@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:36064
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932276Ab1LOJjq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 04:39:46 -0500
In-Reply-To: <4EE93564.3010006@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Paul Walmsley <paul@pwsan.com>

Hi Ilya

On 12/15/11 01:46, Ilya Yanok wrote:
> Hi Tony,
> 
> On 08.12.2011 04:15, Tony Lindgren wrote:
>>> AM35xx SoCs include DaVinci EMAC IP. Initialization code in
>>> board-am3517evm.c is pretty board independent and will work for any
>>> AM35xx based board so move this code to it's own file to be reused by
>>> other boards.
>>
>> Should this be just called emac-common.c? Or is it so am35xx specific
>> that it won't work with others?
> 
> Uh.. I'm not sure but I thought that EMAC is present only on am35xx SoCs...
> 
>>> +	clk_add_alias(NULL, dev_name(&am35xx_emac_device.dev),
>>> +		      "emac_clk", &am35xx_emac_device.dev);
>>> +	clk_add_alias(NULL, dev_name(&am35xx_mdio_device.dev),
>>> +		      "phy_clk", &am35xx_emac_device.dev);
>>
>> Hmm after moving the code and should be a separate patch, don't
>> we already have these clock aliases in cloc3xxx_data.c?
> 
> No, we have
> CLK("davinci_emac", "emac_clk"...) and
> CLK("davinci_emac", "phy_clk"...)
> while drivers want ("davinci_emac", NULL) and ("davinci_mdio", NULL).
> 
> Probably we have to fix the clock definitions instead of adding the aliases.
> 
> So, should I post this as a separate patch?

If it comes to that question, Cc Paul...

-- 
Regards,
Igor.
