From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and
 L-Z)
Date: Tue, 24 Feb 2009 11:09:02 +0200
Message-ID: <49A3B92E.9030101@nokia.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>	 <1234850560.13109.9.camel@eenurkka-desktop>	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com>	 <1235396273.12653.8.camel@eenurkka-desktop>	 <49A2D66F.9050809@gmail.com>	 <1FFEF31EBAA4F64B80D33027D4297760036DEC2F6F@NOK-EUMSG-02.mgdnok.nokia.com> <782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24131 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbZBXJJY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 04:09:24 -0500
In-Reply-To: <782515bb0902231019l17eaef2crfcb6426fbbbf8d04@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <menon.nishanth@gmail.com>
Cc: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "r-woodruff2@ti.com" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

ext Nishanth Menon wrote:
> Oops.. copy-paste typo.. :(
> tLow = (scll+3) * iclk
> tHigh = (sclh+9) * iclk
> Vs:
> TRM:
> tHigh  = ( sclh +5 )*iclk period
> tLow  = ( scll +7 )*iclk period
> 
> But my question is this: why are we trying to a different equation
> here compared to the equation in the TRM?

The problem with TRM (the table 18-13 you referred earlier) is that it 
assumes 50% duty cycle while the correct one is more like 33%. This is 
corrected by Eero's patch:

+                       fsscll = internal_clk / (dev->speed * 2) - 3;
+                       fssclh = internal_clk / (dev->speed * 2) - 9;

this is same as (with internal_clk == 9600 and dev->speed == 400):

scl = internal_clk / dev->speed;
fsscll = scl - scl/3 - 7;
fssclh = scl/3 - 5;

If the code would be like this, then I guess the readers of both TRM 
_and_ the I2C spec would be happy?

The problem with Eero's patch is that it changes the internal clock 
(again thanks to that confusing table). You should be able to use same 
for all modes. Also note that the noise filter is one internel clock 
period. Currently the driver uses 19.2 MHz which exceeds the I2C spec 
max. So 24 MHz would be a safer choice.

A.
