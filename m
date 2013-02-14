From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 14 Feb 2013 11:43:15 +0200
Message-ID: <511CB1B3.80605@compulab.co.il>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il> <511C8D8F.9060805@ti.com> <511CA247.80606@compulab.co.il> <511CA9B3.70401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:57089 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540Ab3BNJnV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 04:43:21 -0500
In-Reply-To: <511CA9B3.70401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/14/13 11:09, Tomi Valkeinen wrote:
> On 2013-02-14 10:37, Igor Grinberg wrote:
>> On 02/14/13 09:09, Tomi Valkeinen wrote:
>>> On 2013-02-14 08:56, Igor Grinberg wrote:
>>>> On 02/13/13 17:59, Tomi Valkeinen wrote:
>>
>>>>> Okay, so I just realized there's an spi backlight driver used here, and
>>>>> that backlight driver is actually handling the SPI transactions with the
>>>>> panel, instead of the panel driver. So this looks quite messed up.
>>>>
>>>> Yep, it always was.
>>>> The whole DSS specific panel handling inside the
>>>> drivers/video/omap2/displays is a mess.
>>
>>> Well, that's not mess itself, it's just omap specific panel framework.
>>> But dividing single device handling into two separate places is a mess.
>>
>> Yes, you are right it is not the mess, but it prevents the panel to
>> be used on other systems and that is BAD.
>> At the very least, drivers/video/backlight is a generic place that can be
>> used not just on OMAP.
> 
> True, it's generic, but does it work reliably? The panel hardware is now
> partly handled in the backlight driver, and partly in the omap's panel
> driver (and wherever on other platforms).

It works reliably on other platforms, but not on OMAP - because
we need to cope with the OMAP specific framework...

> 
> At least currently there's a dependency between the two, as the LCD_EN
> gpio is handled by the panel driver, which affects the functioning of
> the backlight driver. Is it ensured that the panel driver does not
> disable the panel when the backlight driver does spi transactions?
> 
> That's what I meant with the mess, it's difficult to make it work
> reliably. I know that for some panels such a two-driver approach would
> not work at all. Although I guess it's working well enough for you for
> this panel.

Yep, that is correct - this is the mess.

> 
> Thinking about it, if you do move the gpio handling to the backlight
> driver, the panel driver will only handle the DPI video stream. Then it
> should not have any effect on the SPI side (presuming the panel doesn't
> use the pixel clock as func clock), although there's probably still
> possibility for display artifacts on enable and disable, if the order of
> operations goes the wrong way.

Yep, again, that is correct.

> 
>> And since the toppoly was and is used on other systems, why the hell
>> should anyone duplicate the driver just to please the OMAP specific
>> panel framework? The real problem is that this framework should not be
> 
> Not to please. To make it reliable.

Well, there are multiple ways to make it reliable.
And I don't think that the best would be: make it OMAP specific.

> 
>> OMAP specific...
>> Of course I'm aware of the fact that currently there is no generic
>> panel framework, but forging something OMAP specific which is obviously
>> used on most of the other architectures/platforms (and I mean
>> panel<->controller relations), is not a good way to go.
> 
> Well, if duplicating the code gives us reliable drivers, versus
> unreliable without duplicating, then... I don't see it as that bad.

Hmmm... I don't think this fits the mainline (upstream) philosophy.
This can be also extrapolated into: let's make our own Linux ARM fork
so it will be more reliable...
This is the way how vendor specific kernel releases work.

> 
>> Although, I'm also aware of the fact that most things are done this way:
>> do several specific drivers/frameworks, find the common stuff, and extract
>> it into a core driver/framework. So I don't want to blame anyone - that's
>> just the way how we do things, right?
> 
> If it was easy, somebody would've done it.

In fact this is done all the time on multiple drivers and frameworks.
Also, I don't say this is easy, but I also don't think this too hard.
It is also a function of resources (time/will/experience/etc.).

> 
>>>>> For a quick solution, can we just set the LCD_EN at boot time (with the
>>>>> msleep), and not touch it after that?
>>>>
>>>> That would be sensible for now, so this series can be merged.
>>>> As a more appropriate (and long term) solution,
>>>> I plan on moving the panel reset pin handling to the spi backlight
>>>> driver itself.
>>
>>> Well, if you must. But I suggest moving the whole panel handling into a
>>> (omap specific) panel driver, as it's done for other panels. That way
>>> you'll have a proper panel driver for it, for omap, and when CDF comes,
>>> you'll get a platform independent panel driver for it.
>>
>> You can't just move generic architecture/platform independent stuff
>> into OMAP specific framework... Just think about this... It's insane.
> 
> As I said, reliable vs unreliable. That's not insane.
> 
> But again, if you can handle this particular panel reliably with the
> two-driver approach, I'm fine with it.

Again, it works reliably on other platforms,
why would OMAP be an exception?

> 
>> In addition, AFAIR, the reset pin is the property of the toppoly panel
>> hardware, so that is why I think, we should let the toppoly driver
>> (currently spi backlight, later hopefully CDF) handle it correctly
>> along with the spi sequences.
> 
> Yes, that sounds ok.
> 
>  Tomi
> 

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHLGzAAoJEBDE8YO64EfaOJMP/AtR9IkN+eWwdbt0R1Vu9vKH
mFgSCENqErAjYi3zM0YScj+E2zSby4rfXCY14Goh46DBCBXjRWYms6P/nZgGSLYT
lIup5YljWxWJxM0nvrykok872Atx+TSJukx3nD5foWieu4tNRRvhqN7+ckBO7R4D
J1D5uy3wH8Ea3SZ/foPrzewTeajnOeZxzhprfodLdmKIuqxInVE0KrWqrcefspNI
TvWAjLCHtoM4LDCZRaiHs3mN03QMdcJc1BfWeJe1eVx6YXSBqNTTG6mSgUegQyOG
PnC1T3kzS5Vuhmk9NfUmL19LInAljPVDoQomUqG6N140M6jol4ru+A5yE/NZ/tSl
j/8vz5pE8JXp0ueQt1X1vkAGL+Lgzbyrf38xQTxnjSLggO3OFHOv6AzlY453Lfem
gz6Xpjq+2Kcqxghfndd4yXnOjdlyWDN6dvYBthBBixmt34c6nNtdoXmakAXyw8wW
qSyT3sO6WgE53ROZRh9W2FCiLXdJ1rHYMBRRY4nbKNhOhtC/vSF4UVsFBUuAaqul
a6QToMggpugY8n3lm/SZ6LFWJDaHjnkUAVXxq3/GiclJSFwBnHqsOT1bfjsF5OfC
YnaldNBbH0WvmFN89Ds/inW1MLcFc/yWirB0Utj7ysb5AL4vH4QLs1dokzjxnTyK
WJmOMyQi7Jk+ocUSBgu2
=G6lL
-----END PGP SIGNATURE-----
