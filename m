From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 14 Feb 2013 08:56:03 +0200
Message-ID: <511C8A83.5070407@compulab.co.il>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:42204 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410Ab3BNG4K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 01:56:10 -0500
In-Reply-To: <511BB87E.60003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/13/13 17:59, Tomi Valkeinen wrote:
> On 2013-02-13 17:28, Tomi Valkeinen wrote:
>> On 2013-02-13 17:16, Igor Grinberg wrote:
>>> Hi Archit,
>>>
>>> On 02/13/13 16:21, Archit Taneja wrote:
>>>> The cm-t35 board file currently requests gpios required to configure the tdo35s
>>>> panel, and provides platform_enable/disable callbacks to configure them.
>>>>
>>>> These tasks have been moved to the generic dpi panel driver itself and shouldn't
>>>> be done in the board files.
>>>>
>>>> Remove the gpio requests and the platform callbacks from the board file.
>>>> Add the gpio information to generic dpi panel's platform data so that it's
>>>> passed to the panel driver.
>>>>
>>>> Note: In cm_t35_init_display(), the gpios were disabled, and the LCD_EN gpio was
>>>> enabled after a 50 millisecond delay. This code has been removed and is not
>>>> taken care of in the generic panel driver. The impact of this needs to be
>>>> tested. The panel's gpios are also not exported any more. Hence, they can't be
>>>> accessed via sysfs interface.
>>>
>>> Indeed, there is an impact - the LCD no longer works.
>>> The reason for the LCD_EN gpio being pushed high after the 50ms delay,
>>> is to get the LCD out of reset, so the SPI transaction will succeed
>>> and initialize the LCD.
>>> Now, when you remove the gpio handling for the LCD_EN pin,
>>> the LCD no longer works.
>>
>> So between what is the sleep done? It's not clear from the code. LCD_EN
>> needs to be 0 for 50ms, or...?
>>
>> If the panel requires specific reset handling, does it work right even
>> currently when the panel is turned off and later turned on? The msleep
>> is only used at boot time.
> 
> Okay, so I just realized there's an spi backlight driver used here, and
> that backlight driver is actually handling the SPI transactions with the
> panel, instead of the panel driver. So this looks quite messed up.

Yep, it always was.
The whole DSS specific panel handling inside the
drivers/video/omap2/displays is a mess.
Those panels can be (and are) used not only with OMAP based boards.

> 
> For a quick solution, can we just set the LCD_EN at boot time (with the
> msleep), and not touch it after that?

That would be sensible for now, so this series can be merged.
As a more appropriate (and long term) solution,
I plan on moving the panel reset pin handling to the spi backlight
driver itself.


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHIqCAAoJEBDE8YO64Efamw0P/R2wt0tpCI1ecrnutVGMX4bF
Pyjk2B65uDWqoqZ/cpJUqnvmupXl5UdrA7eqKjTBh1A+g81UVFcNDMuJsbPIIiYI
1pimZieAq0T6Vag00PKImKlkhJYfC7JVBbESij/NONlzYtPkbZ91Y+Ik4DZXnyZf
1TS4GbHQ25tjl73PkwlzLUcJIDIogsimSrkM+aWXPE8LmvrBEQs0LhAObPsAFtgL
1An3hvA2Tkhh9QgerWQd9YiqX994tv1PGRLBEXTbjh1yihzKSNleuvw3NdM+wf9i
9Y5l9IV6L2dtYBMLCpzkiGQBDdOzoq+fObRnSgK6Kr1mfXot+MAlLrk9gCeWcq1b
c2oU/imKWB4sZys21pTnjIxAIzzRDoGW40qXuibTW4DoAYaVHuEBPtphjMVCBCcQ
sJaIVXpsChQ3vvtHOgllnInMjCnlXJ3Piqr4y5glTPxu9mZHdPr6VDpWdqRmvyr9
V7fRQztwXB3Td+SZVDD1yBqoXKlKCX4QPlLAqH3FI9s1WhDHcJePcoDJY0/QyXB1
IeQRlEwBBEZAYy/kr9/pwbZzXeh5V5dK6wAq8aT+thS22zl3nJbKjW//vN06+ib+
WAnHRSZ8iCbUX2cRVF1k+DCQOTi8QCbI6WTcLsgenLeSrbEuzilfgsrsvd6LHfjD
oTODiiD9QInP2sBfknUp
=tWsB
-----END PGP SIGNATURE-----
