From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 14 Feb 2013 15:51:00 +0200
Message-ID: <511CEBC4.6050400@compulab.co.il>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il> <511C8D8F.9060805@ti.com> <511CA247.80606@compulab.co.il> <511CA9B3.70401@ti.com> <511CB1B3.80605@compulab.co.il> <511CC37C.3020706@ti.com> <511CDA91.1050300@compulab.co.il> <511CDE12.60701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:47224 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965331Ab3BNNvH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 08:51:07 -0500
In-Reply-To: <511CDE12.60701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/14/13 14:52, Tomi Valkeinen wrote:
> On 2013-02-14 14:37, Igor Grinberg wrote:
>> On 02/14/13 12:59, Tomi Valkeinen wrote:
>>> On 2013-02-14 11:43, Igor Grinberg wrote:
>>
>>>>> True, it's generic, but does it work reliably? The panel hardware is now
>>>>> partly handled in the backlight driver, and partly in the omap's panel
>>>>> driver (and wherever on other platforms).
>>>>
>>>> It works reliably on other platforms, but not on OMAP - because
>>>> we need to cope with the OMAP specific framework...
>>
>>> How do you handle the gpios on other platform? Those are the ones
>>> causing the issues here, right?
>>
>> Well, I'm also talking about something that is a history already.
>> Remember, we had multiple panel drivers inside the
>> video/omap2/displays and then they were consolidated into the
>> "generic dpi/dsi/whatever".
> 
> Sorry, I miss the point. Was that a bad thing? Didn't it simplify the
> task for you with simple panels? It could've been taken even further,
> though (see below).

Yes it was a good thing (I have already told this below).

> 
>> And yes you are right, on the platforms I'm aware of, the GPIO is not
>> handled. Apparently its hardware default (pull resistor) is always on...
> 
> Ok, so the simple fix of setting the GPIOs only in the board file is
> acceptable for now.

Yep. I also told this already in one of the previous emails.

> 
> Can the LCD_BL_GPIO be handled by the omap panel driver? Otherwise the
> backlight will supposedly be always on. Is it just a simple switch for
> the BL power, which does not affect the SPI in any way?

Yes, it can for now.
Also, I think we should also take into account the backlight framework,
including PMW.

> 
>>> Or is there something else with OMAP DSS that you need to specifically
>>> cope with?
>>
>> The fact there is a need to create a OMAP specific driver.
>> I'm not talking about the generic driver which only needs to have the
>> controller specific data (e.g. porches, pixel clock, bus width).
>> The generic driver was one of the good ways to go.
> 
> Well, we could also have an even more generic driver that takes the
> video timings from the board file as platform data. Then all you would
> need to do is to define the timings in the board file, as I think is
> done for other platforms also.

Yep. That sounds reasonable also for cases where the bus width is the
hardware (board) property.

> 
> I'm not very fond of that idea, as I think hardcoded device specific
> data should not be given as parameters, but they should be handled by
> the device driver internally, as it should know that device specific
> data already.

Yes, that is why I think the generic driver for "simple" panels
was a good idea. There was some flexibility missing though.
For example the resolution setting which in turn drags another set
of timings and pixel clock.
There are panels that support more than one resolution.

> 
> But, in practice, making this kind of even more generic panel driver
> will probably make life easier for everyone, so I think we'll have one
> with CDF.

I'm looking forward to see it happening!

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHOvEAAoJEBDE8YO64EfaCZ0P/32SYC7MZRJMfUVrnzZtJZpn
9BKzrvO0h/GKZMbKoKKNFwmvlTxEocELLkljF35ipbc51C/dpD45ZmMBvu4s8owE
6bopGw6ssTahTKk0zY5PekTamZT7UlY86hI9ZcZBxSzY8xaj7UCSPnJ3qzY2ZGzA
4heJW01mlHr9i1qkOzxz0IHA2CdQmQltAsW12NFCWYBRpDfhrYtECwhlnvLXHEzy
nqXNpRHOnrL/hqvJwor1X+D/O1JlyxUiVr6+7sAZqXxvv/iMX8Nc1XeTObgGbse6
1bpipPD57etqISsN1g9ur1tU5f6KvoR4IA35RaCCkBFINIXMEBl7kr5X9Bcg3giE
3pz23k91KRloOcXJ0OvLHp7RnSrwswU/4C3Cse+95cY0wyChaVlwJtySEnfGALWV
aiuw89v6DXaC5WDQq55UtTc3qjc23Ehut8i184PAv5HKrDHLLjVg4HqgGjC9uGEn
JKOxOnfMTstqyKC2whW+Pep3g4npJAHsn/0QmpdSJQ/vEwm7CmXBZeR6DwcTSLAT
xR1SUWwHav2HqpYUz4y7TgIPuwsR+VNKn/mSOTbhbLB4s9bowPMxMiqz2AQn3ige
YyMTo7KnObivXZydrVrx0/e/DJC4ENGpE3macVQytr0BpjJhK1+XiNMHa17+Mymm
U45VDKrUgaYcYXW2L4JN
=xeSz
-----END PGP SIGNATURE-----
