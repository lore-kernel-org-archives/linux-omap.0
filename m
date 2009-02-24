From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and
 L-Z)
Date: Tue, 24 Feb 2009 14:47:21 +0200
Message-ID: <49A3EC59.4040803@nokia.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>	 <1234850560.13109.9.camel@eenurkka-desktop>	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>	 <1235396273.12653.8.camel@eenurkka-desktop>	 <49A2D66F.9050809@gmail.com>	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F6F@NOK-EUMSG-02.mgdnok.nokia.com> <782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com> <49A3B92E.9030101@nokia.com> <49A3DD52.4020303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64576 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbZBXMte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 07:49:34 -0500
In-Reply-To: <49A3DD52.4020303@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "r-woodruff2@ti.com" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

ext Nishanth Menon wrote:
> Aaro Koskinen said the following on 02/24/2009 11:09 AM:
>>> TRM:
>>> tHigh  = ( sclh +5 )*iclk period
>>> tLow  = ( scll +7 )*iclk period
>>>
>>> But my question is this: why are we trying to a different equation
>>> here compared to the equation in the TRM?
>> The problem with TRM (the table 18-13 you referred earlier) is that it
>> assumes 50% duty cycle while the correct one is more like 33%. This is
>> corrected by Eero's patch:
> Gentle query - could you point me to the place where the 33% duty cycle
> is mentioned in i2c spec? spec mentions minimum timing, but I don't seem
> to find a constraint on duty cycle requirement.. :(

Well, it's implicite... Check the i2c spec table 7 for speeds 3400 and 
1700. If you use TRM calculcations so that tLow == tHigh you get too 
tLow that's below the minimum in both cases. So you must increase tLow, 
and when you do that you must make tHigh shorter, otherwise you don't 
match the rate.

A.
