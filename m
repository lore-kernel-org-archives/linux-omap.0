From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 14 Feb 2013 14:37:37 +0200
Message-ID: <511CDA91.1050300@compulab.co.il>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il> <511C8D8F.9060805@ti.com> <511CA247.80606@compulab.co.il> <511CA9B3.70401@ti.com> <511CB1B3.80605@compulab.co.il> <511CC37C.3020706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:49021 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759579Ab3BNMho (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 07:37:44 -0500
In-Reply-To: <511CC37C.3020706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/14/13 12:59, Tomi Valkeinen wrote:
> On 2013-02-14 11:43, Igor Grinberg wrote:
> 
>>> True, it's generic, but does it work reliably? The panel hardware is now
>>> partly handled in the backlight driver, and partly in the omap's panel
>>> driver (and wherever on other platforms).
>>
>> It works reliably on other platforms, but not on OMAP - because
>> we need to cope with the OMAP specific framework...
> 
> How do you handle the gpios on other platform? Those are the ones
> causing the issues here, right?

Well, I'm also talking about something that is a history already.
Remember, we had multiple panel drivers inside the
video/omap2/displays and then they were consolidated into the
"generic dpi/dsi/whatever".

And yes you are right, on the platforms I'm aware of, the GPIO is not
handled. Apparently its hardware default (pull resistor) is always on...

> 
> Or is there something else with OMAP DSS that you need to specifically
> cope with?

The fact there is a need to create a OMAP specific driver.
I'm not talking about the generic driver which only needs to have the
controller specific data (e.g. porches, pixel clock, bus width).
The generic driver was one of the good ways to go.

> 
>>> Thinking about it, if you do move the gpio handling to the backlight
>>> driver, the panel driver will only handle the DPI video stream. Then it
>>> should not have any effect on the SPI side (presuming the panel doesn't
>>> use the pixel clock as func clock), although there's probably still
>>> possibility for display artifacts on enable and disable, if the order of
>>> operations goes the wrong way.
>>
>> Yep, again, that is correct.
> 
> It's correct that there may be artifacts? How do you manage the ordering
> of the operations on other platforms?

Yep, there might be artifacts if the ordering is incorrect.
The ordering is something that should be solved by the CDF.

> 
>>>> And since the toppoly was and is used on other systems, why the hell
>>>> should anyone duplicate the driver just to please the OMAP specific
>>>> panel framework? The real problem is that this framework should not be
>>
>>> Not to please. To make it reliable.
>>
>> Well, there are multiple ways to make it reliable.
>> And I don't think that the best would be: make it OMAP specific.
> 
> I'm not saying it's the best option. I'm saying it's a realistic option
> to get it working.
> 
>>> Well, if duplicating the code gives us reliable drivers, versus
>>> unreliable without duplicating, then... I don't see it as that bad.
>>
>> Hmmm... I don't think this fits the mainline (upstream) philosophy.
>> This can be also extrapolated into: let's make our own Linux ARM fork
>> so it will be more reliable...
>> This is the way how vendor specific kernel releases work.
> 
> Well, we are talking about a smallish driver here. Not an arch fork. If
> the options are a) platform specific driver that works, or b) generic
> driver that's not reliable, or c) no driver at all, I can't really see
> why a) would be such a horrible option for the time being.

I think there is b.5) where the driver is both generic and reliable,
but I haven't looked into this deep enough.

> 
> But this discussion is getting a bit out of hand. It sounds to me that
> for this panel in question we can manage with the current approach, so
> this whole line of discussion doesn't matter for this specific problem.
> 
>>> If it was easy, somebody would've done it.
>>
>> In fact this is done all the time on multiple drivers and frameworks.
>> Also, I don't say this is easy, but I also don't think this too hard.
>> It is also a function of resources (time/will/experience/etc.).
> 
> I think the CDF discussions have already proven that it is quite hard.
> But feel free to contribute.

I will contribute as much as I can in terms of my paid work.
I always do...

> 
> And I've talked about a common display framework already years ago, and
> I've tried to design OMAP DSS panels from start in such a way that they
> try to depend on OMAP DSS features as little as possible, to make it
> easier to generalize them. Just to prove I'm not indifferent about the
> issue =).

Yep, your work was fruitful and no one can take it from you!
That's why I said that I'm not trying to blame or accuse anyone.
That is more of a wish that the CDF will come as quickly as it can.
Because currently it is clear that there are cases where we don't
have a proper support...


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHNqRAAoJEBDE8YO64Efac08QAKBgU7xFkdBHU0ekAgRIafhO
kd0EgPXwPZDvuAaoj5pzdMI65alRSuoQxp5ohHyz0aFfGRk0Q66f6/zXzTsGXPLP
pRTkqGGTHD5Qtv2IvhHPvLMRGW+87QiuK0NU0BJqV/1JRPz1UyKMJrwc5U3Acf4J
B7bQnWLlIcPftIt2zHwuvZZMYZUL8f5/dXGWMhxmTF7rse7YcTjCwQO4eabTIX5r
/GUanF+qlwKJzk7nxQR1DFQdN+7Vv8vdumJi38sq9fouLgXlhmzOgXvxMgT7lq8T
l+7Bg7l+E9yrHaXmWf3zjZBAk6/wBnzzrmmK5V6Gjg2PiEh6Rs5ARWPrdc/FQCpt
4bXTKEktLonHj2rya8intrPLw7lP4AQN81QsQOLeRIPGoSCcDsi4RGAFrWdXR0Xt
Du9ea/liAD3+qiNIErQcTlR5zDKAIhMvWycG+ZFj0kVFUFb6p/F1TKcqVy0O7HAG
SLSsrCyO8jA/UxAKQifhiUU2Hoq9a3VhQi507lbXiN0NTsk686mp/W8YJPB/di+v
44wayaE5Kyw5iawLj9WUyTpw29sOysiewp+z7XuaF3fM5lWeMy2e0/mNbe4iCcCG
LYMl0NWcQn0S7okkQz5HHmCJp3L3/Se5sMfGKJRzpG0vK1DR+m8nJh0MGbEu/14C
B9+3VrImRZS8te/wnPqE
=BAnK
-----END PGP SIGNATURE-----
