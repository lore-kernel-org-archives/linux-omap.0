From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: tHigh tLow discussion (was [pacth] I2C bug fixes for L-O and
 L-Z)
Date: Mon, 23 Feb 2009 19:01:35 +0200
Message-ID: <49A2D66F.9050809@gmail.com>
References: <1234767724.16827.7.camel@eenurkka-desktop>	 <13B9B4C6EF24D648824FF11BE896716203771DC940@dlee02.ent.ti.com>	 <1234850560.13109.9.camel@eenurkka-desktop>	 <13B9B4C6EF24D648824FF11BE896716203771DD194@dlee02.ent.ti.com>	 <13B9B4C6EF24D648824FF11BE896716203772C3CAF@dlee02.ent.ti.com> <1235396273.12653.8.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:44191 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbZBWRBm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 12:01:42 -0500
Received: by bwz5 with SMTP id 5so4956485bwz.13
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 09:01:39 -0800 (PST)
In-Reply-To: <1235396273.12653.8.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: "ext Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Eero Nurkkala said the following on 02/23/2009 03:37 PM:
> On Fri, 2009-02-20 at 21:59 +0100, ext Woodruff, Richard wrote:
>   
>> I received the following comment from a HW Apps person whom has dealt with this at the board level.
>>
>> <comment start>
>> Attached is the I2C spec that I have.  As I understand it, the I2C only specify the minimum tLow and tHigh (which is not "balanced").  However what is more important is that the appropriate setup and hold time are followed.
>>
>> If the equal time still meets the setup/hold time then there should not be any issue from a compliance standpoint.
>> <comment end>
>>
>> Regards,
>> Richard W.
>>     
> With out board, the tLow and tHigh values are in line with I2C standard
> with the patch:
> http://marc.info/?l=linux-omap&m=122770723311340&w=2
>
> Would that risk the setup and hold times? (If I remember correctly, the
> values (setup, hold) were within the I2C standard even with the patch.)
>
> I think it's a risk not to meet tLow and tHigh. I'm saying, with open
> source values with our board, the tLow was not in standard. If using
> TRM minimum values, things get even worse. Why? because it states, for
> example, Fast Mode SCLL = 5 and SCLH = 7. This means that the low
> period is smaller than the high! Shouldn't it be vice versa? (scope
> verified).
>   
just couple of views: (Disclaimer - it might be good if someone could re
validate my math :( )..
a) tHigh and tLow could be device dependent. for an I2C bus with
multiple devices, we probably need a common denominator. the question is
- is there a min and max for the tHigh and tLow? some of the datasheets
I have seen seem to have this.
b) the drivers/i2c/busses/i2c-omap.c does computation based on
dev->speed. the equation is based on:
tHigh  = ( sclh +6 )*iclk period
tLow  = ( scll +6 )*iclk period
the TRM ([2] table18-12(page 2942)) instead speaks of:
tHigh  = ( sclh +5 )*iclk period
tLow  = ( scll +7 )*iclk period
current i2c driver attempts to put the same value to scll and sclh reg.
The result would be that tHigh != tLow, unless I am missing something.

I am not entirely sure about the basis of Eero's equation:

scll = (scl+3) * iclk
sclh = (scl+9) * iclk


Now computing a bit, i2c spec [1] says in table 5 for minimum for FS as
tLow as 1.3uS and tHigh as 0.6uS. max is not mentioned :(.. OMAP3430 TRM
([2] table 18-13 (page 2943)) says:
psc=9, scl = 5, sch =7 - for fclk = 96Mhz.
translating this:
iclk =96M/(9+1) = 9.6Mhz = 0.104167uSec.
tHigh  = ( sclh +5 )*iclk = (7+5)*0.104167 = 1.250004 uSec (spec min is
0.6uSec)
tLow  = ( scll +7 )*iclk =(5+7)*0.104167 = 1.250004 uSec (spec min is
1.3uSec <== I might be missing something here - but does that look like
some sort of violation?

Now, from a s/w perspective, If we would like to have it so that we can
configure tHigh and tLow based on devices, electrical characteristics on
a bus, not just speed of the bus, the current implementation would
probably need to change(I think).

Regards,
Nishanth Menon

Ref:
[1] http://www.nxp.com/acrobat_download/literature/9398/39340011.pdf
[2] http://focus.ti.com/pdfs/wtbu/SWPU114I_PrelimFinalEPDF_06_10_2008.pdf
