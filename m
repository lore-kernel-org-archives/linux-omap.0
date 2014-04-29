From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v4 5/5] ARM: DRA7: Add support for soc_is_dra74x() and
 soc_is_dra72x() varients
Date: Tue, 29 Apr 2014 16:49:59 +0530
Message-ID: <535F8ADF.6090702@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com> <1398769513-8736-6-git-send-email-rnayak@ti.com> <4792826.emf6IohHd6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43412 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933674AbaD2LVz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2014 07:21:55 -0400
In-Reply-To: <4792826.emf6IohHd6@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com, nm@ti.com, s-anna@ti.com

On Tuesday 29 April 2014 04:48 PM, Arnd Bergmann wrote:
> On Tuesday 29 April 2014 16:35:13 Rajendra Nayak wrote:
>> @@ -393,7 +395,12 @@ IS_OMAP_TYPE(3430, 0x3430)
>>  
>>  #if defined(CONFIG_SOC_DRA7XX)
>>  #undef soc_is_dra7xx
>> +#undef soc_is_dra74x
>> +#undef soc_is_dra72x
>>  #define soc_is_dra7xx()        (of_machine_is_compatible("ti,dra7"))
>> +#define soc_is_dra74x()        (of_machine_is_compatible("ti,dra74"))
>> +#define soc_is_dra72x()        (of_machine_is_compatible("ti,dra72"))
>> +
> 
> You shouldn't normally have to define these. Why are they needed?
> 
> Maybe it's better to wait for a user to show up, and then we can decide
> whether we actually want to have them this way, or if there is a better
> solution for the particular use case.
> 
> Normally, we'd want to make run-time decisions based on properties
> of the nodes a driver is working on, not the global machine compatible
> string.

Yeah, actually this can be dropped. There is no user for it now.

> 
> 	Arnd
> 

