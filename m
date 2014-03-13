From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/7] ARM: dts: overo: Add new expansion boards
Date: Thu, 13 Mar 2014 09:29:34 +0100
Message-ID: <53216C6E.9050706@epfl.ch>
References: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch> <20140312172247.GC30897@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:34614 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbaCMI3h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Mar 2014 04:29:37 -0400
In-Reply-To: <20140312172247.GC30897@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 03/12/2014 06:22 PM, Tony Lindgren wrote:
> * Florian Vaussard <florian.vaussard@epfl.ch> [140311 05:24]:
>> Hi,
>>
>> This series adds the support for 5 new expansion boards from Gumstix:
>> - Palo43
>> - Gallop43
>> - Chestnut43
>> - Alto35
>> - Summit
>>
>> The 1st patch is a preparatory work, in order to factorize some
>> peripherals that are common to most Gumstix expansion boards. Patch 2
>> adds the support for an accelerometer that is present on most boards.
>>
>> Palo43, Gallop43 and Chestnut43 are all pretty similar. I tested
>> on a Gallop43 (with both OMAP35xx and OMAP36xx Overo).
>>
>> Alto35 is slightly different. Again, I tested with both OMAP35xx and
>> OMAP36xx Overo.
>>
>> Summit is pretty similar to Tobi. I do not have a Summit at hand,
>> but given the similarity with Tobi, it should work fine.
>>
>> To avoid unnecessary duplications, I put all the common stuff for each
>> board inside an omap3-overo-xxx-common.dsti include file. By doing so,
>> I can have minimal SoC-specific omap3-overo-xxx.dts (omap34xx based)
>> and omap3-overo-storm-xxx.dts (omap36xx based) device trees.
>>
>> This series depends on my previous Overo series [1]. A complete testing
>> tree (including the graphics support, soon to be posted) is available
>> at [2].
> 
> Thanks, applying the whole series into omap-for-v3.15/dt-overo.
> As it's this close to the merge window, no guarantees anything
> will get pulled in though.
> 

Thanks! Let's see. Anyway, this will not kill baby bears if it can't
make it into 3.15 :)

Regards,
Florian
