From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/3] memory: gpmc: Move omap gpmc code to live under drivers
Date: Wed, 26 Nov 2014 13:22:50 +0200
Message-ID: <5475B80A.5010207@ti.com>
References: <1416594856-15201-1-git-send-email-tony@atomide.com> <1416594856-15201-4-git-send-email-tony@atomide.com> <547301AB.9040905@ti.com> <20141124154403.GB2817@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59226 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbaKZLXW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2014 06:23:22 -0500
In-Reply-To: <20141124154403.GB2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

On 24/11/14 17:44, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [141124 02:02]:
>> On 11/21/2014 08:34 PM, Tony Lindgren wrote:
>>> --- a/drivers/memory/Kconfig
>>> +++ b/drivers/memory/Kconfig
>>> @@ -41,6 +41,14 @@ config TI_EMIF
>>>  	  parameters and other settings during frequency, voltage and
>>>  	  temperature changes
>>>  
>>> +config OMAP_GPMC
>>> +	bool
>>
>> We should depend on ARCH_OMAP2PLUS. Other platforms won't benefit
>> anything from this driver.
> 
> We can't do that yet until we have sorted out the remaining platform
> data issues with arch/arm/mach-omap2/*gpmc*.c files.
> 
> So OMAP_GPMC is currently a silent Kconfig option that does not show
> up as the description after the bool is not there, we select
> OMAP_GPMC automatically based on ARCH_OMAP2PLUS.
> 
> Once we have the remaining legacy code issues sorted out, we can
> make this into just a regular device driver.

OK. In that case,

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger
