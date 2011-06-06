From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2 to use REGULATOR_SUPPLY
Date: Mon, 6 Jun 2011 13:18:41 -0400
Message-ID: <547324C9-4B76-410E-86E6-092D062C95AB@linuxhacker.ru>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru> <1307342762-25363-2-git-send-email-green@linuxhacker.ru> <20110606092126.GG18731@legolas.emea.dhcp.ti.com> <EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru> <20110606171326.GK12242@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:35374 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756410Ab1FFRTE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 13:19:04 -0400
In-Reply-To: <20110606171326.GK12242@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Rapoport <mike@compulab.co.il>, Nishant Kamat <nskamat@ti.com>, Steve Sakoman <steve@sakoman.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hello!

On Jun 6, 2011, at 1:13 PM, Felipe Balbi wrote:
> On Mon, Jun 06, 2011 at 11:45:29AM -0400, Oleg Drokin wrote:
>>>> -static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
>>>> -	{
>>>> -		.supply = "vmmc",
>>>> -		.dev_name = "omap_hsmmc.1",
>>>> -	},
>>>> -};
>>>> +static struct regulator_consumer_supply sdp4430_vaux_supply =
>>>> +	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1");
>>> this should be an array, as it was before.
>> 
>> Only one is defined right now.
>> Whoever needs a second element can convert it to array, I think?
>> What;s the importance of having it as an array right now?
> because later patches will be easier to review. Look below:
...
> can you see now ?

Ok, I get the idea. Do you think it would be best to convert every supply
definition to an array then just in case?
I wonder what are the chances of additional regulators to appear at all
in many of these.
What about supplies that are not going to have additional elements
(like that cm-t35 board, because there simply are no more regulators in the twl)?

Bye,
    Oleg