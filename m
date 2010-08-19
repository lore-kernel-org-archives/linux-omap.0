From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCHv2 2/2] omap: rx51: add support for USB chargers
Date: Thu, 19 Aug 2010 17:25:49 +0300
Message-ID: <4C6D3EED.7040703@nokia.com>
References: <1282219777-17657-1-git-send-email-ext-heikki.krogerus@nokia.com> <1282219777-17657-3-git-send-email-ext-heikki.krogerus@nokia.com> <20100819124042.GA15837@oksana.dev.rtsoft.ru> <20100819130937.GC4363@esdhcp041123.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17932 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab0HSOZU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 10:25:20 -0400
In-Reply-To: <20100819130937.GC4363@esdhcp041123.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krogerus Heikki (EXT-Teleca/Helsinki)" <ext-heikki.krogerus@nokia.com>
Cc: ext Anton Vorontsov <cbouatmailru@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, "Lehtonen Markus (Nokia-MS/Helsinki)" <markus.lehtonen@nokia.com>, Tony Lindgren <tony@atomide.com>

On 08/19/2010 04:09 PM, Krogerus Heikki (EXT-Teleca/Helsinki) wrote:
> On Thu, Aug 19, 2010 at 02:40:42PM +0200, ext Anton Vorontsov wrote:
>> On Thu, Aug 19, 2010 at 03:09:37PM +0300, Krogerus Heikki (EXT-Teleca/Helsinki) wrote:
>>> @@ -909,5 +913,6 @@ void __init rx51_peripherals_init(void)
>>>   	spi_register_board_info(rx51_peripherals_spi_board_info,
>>>   				ARRAY_SIZE(rx51_peripherals_spi_board_info));
>>>   	omap2_hsmmc_init(mmc);
>>> +	platform_device_register(&rx51_charger_device);
>>
>> Maybe
>>
>>    platform_device_register_simple("isp1704_charger", -1, NULL, 0);
>
> I guess it's enough in this case. Ameya, Roger, any objections?
>
I'm fine with the current approach. No need to re-spin.

-- 
regards,
-roger
