From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] am35xx-emac: move generic EMAC init to separate file
Date: Fri, 16 Dec 2011 01:42:26 +0400
Message-ID: <4EEA69C2.4000503@emcraft.com>
References: <1321490199-24371-1-git-send-email-yanok@emcraft.com> <20111208001503.GV31337@atomide.com> <4EE93564.3010006@emcraft.com> <4EE9C057.6010204@compulab.co.il> <20111215184342.GT32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:35837 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab1LOVl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:41:59 -0500
In-Reply-To: <20111215184342.GT32251@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Paul Walmsley <paul@pwsan.com>

Hi Tony,

On 15.12.2011 22:43, Tony Lindgren wrote:
>>>> Should this be just called emac-common.c? Or is it so am35xx specific
>>>> that it won't work with others?
>>>
>>> Uh.. I'm not sure but I thought that EMAC is present only on am35xx SoCs...
> 
> OK, maybe just do a quick check on that so we don't end up
> moving the platform init code around again in few months?

Well, according to TI site, EMAC can be also found on AM33x, AM387x and
AM389x... I'm not sure if it's completely compatible but probably though.

>>>>> +	clk_add_alias(NULL, dev_name(&am35xx_emac_device.dev),
>>>>> +		      "emac_clk", &am35xx_emac_device.dev);
>>>>> +	clk_add_alias(NULL, dev_name(&am35xx_mdio_device.dev),
>>>>> +		      "phy_clk", &am35xx_emac_device.dev);
>>>>
>>>> Hmm after moving the code and should be a separate patch, don't
>>>> we already have these clock aliases in cloc3xxx_data.c?
>>>
>>> No, we have
>>> CLK("davinci_emac", "emac_clk"...) and
>>> CLK("davinci_emac", "phy_clk"...)
>>> while drivers want ("davinci_emac", NULL) and ("davinci_mdio", NULL).
>>>
>>> Probably we have to fix the clock definitions instead of adding the aliases.
>>>
>>> So, should I post this as a separate patch?
>>
>> If it comes to that question, Cc Paul...
> 
> Yes please do that as a separate patch.

Ok, let's wait for Paul's answer and then I'll prepare a separate patch.

Regards, Ilya.
