From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 00/18] ARM: dts: Better support for Gumstix Overo
Date: Thu, 09 Jan 2014 20:59:26 +0100
Message-ID: <52CEFF9E.1000509@epfl.ch>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch> <52CED72C.5050703@baylibre.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:38663 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756046AbaAIT7a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 14:59:30 -0500
In-Reply-To: <52CED72C.5050703@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Benoit,

On 01/09/2014 06:06 PM, Benoit Cousson wrote:
> Hi Florian,
> 
> On 09/01/2014 17:47, Florian Vaussard wrote:
>> Hello,
>>
>> This series adds a number of improvements to Gumstix Overo.
> 
> Thanks for that nice series.
> 
>> Patch 1+2: fix an issue with the vendor prefix (reported long ago by
>> Javier Martinez Canillas)
>> Patch 3+4: add some missing pinctrl entries
>> Patch 5: completely turn off the PMIC on power off
>> Patch 6: enable the on-board Wifi
>> Patch 7: add the high-speed USB PHY
>> Patch 8: add specific timings for LAN9221 into a generic file
>> -> This might interest other people using the same chip, result in
>> doubled bandwith
>>
>> Patch 9: simplify omap3-tobi by using patch 8
>> Patch 10: add support for AT24C01 EEPROM used on expansion boards
>> Patch 11: factorize parts common to all expansion boards
>> Patch 12: rename omap3-tobi to omap3-overo-tobi
>> -> I do not know to which extent this might qualify as an API breakage,
>>     but the new name is far better IMHO
>>

Do you have any thoughts on this? I guess that the Tobi DT is not very
widely used, apart for testing purposes, but I do not want to be flamed
due to an API breakage :D But I deem the new name to be worth the risk.

>> Patch 13 to 17: add new extension boards (Palo43, Gallop43, Alto35,
>> Chestnut43, Summit)
>> Patch 18: add the HDMI output
>> -> this patch depends on Tomi Valkeinen's DT binding for OMAPDSS,
>> which is
>>     not yet merged, so this patch will have to wait
>>
>>
>> The patches 13 to 17 are based on the hardware schematics and
>> compile-tested, as I
>> do not have the necessary hardware (anyone willing to send me some
>> boards ? :-)
>> We are mainly missing the support for the various LCDs, the
>> accelerometer + probably
>> other small things.
>>
>> This series is based on Tony's omap-for-v3.14/dt branch + work from
>> Tomi [1] for the patch 18.
>>
>> Benoit: I guess that I am too late for the 3.14... ?
> 
> Yeah, I think so, even my 3.14 branch is too late for 3.14 :-)
> 

Damn!

Ok, will go for 3.15. Anyway, I have other DT patches under the hood
(OMAP4 DuoVero + my own board), so everything can go into the same release.

Best,

Florian
