From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/5] ARM: OMAP2+: gpmc: configuration enhancements
Date: Thu, 30 Oct 2014 17:24:26 +0200
Message-ID: <5452582A.9060505@ti.com>
References: <1413895309-9152-1-git-send-email-rogerq@ti.com> <20141030151036.GE2560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52874 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933365AbaJ3PYb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2014 11:24:31 -0400
In-Reply-To: <20141030151036.GE2560@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pekon@pek-sem.com, javier@dowhile0.org, linux-omap@vger.kernel.org

On 10/30/2014 05:10 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [141021 05:43]:
>> Hi Tony,
>>
>> These patches address GPMC configuration issues and are for v3.19.
>> Patches based on v3.18-rc1.
>>
>> - Make sure to print a user visible error if a requested GPMC timing
>> configuration can't be met.
>>
>> - Don't create GPMC child device if a GPMC timing could not be set.
>>
>> - Always enable address lines A26-A11 for non-NAND devices.
>>
>> - Perform GPMC configuration as per recommended procedure i.e.
>> keep Chip Select disabled while changing GPMC configuration.
>>
>> Tested on dra7-evm, am437x-gp-evm and beagleboard.
> 
> For all these, please feel free to add:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 

Thanks. These patches are now available at

git@github.com:rogerq/linux.git		for-v3.19/gpmc-omap


cheers,
-roger
