From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Thu, 14 Feb 2013 10:37:27 +0200
Message-ID: <511CA247.80606@compulab.co.il>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il> <511C8D8F.9060805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:38275 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932238Ab3BNIhd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 03:37:33 -0500
In-Reply-To: <511C8D8F.9060805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/14/13 09:09, Tomi Valkeinen wrote:
> On 2013-02-14 08:56, Igor Grinberg wrote:
>> On 02/13/13 17:59, Tomi Valkeinen wrote:
> 
>>> Okay, so I just realized there's an spi backlight driver used here, and
>>> that backlight driver is actually handling the SPI transactions with the
>>> panel, instead of the panel driver. So this looks quite messed up.
>>
>> Yep, it always was.
>> The whole DSS specific panel handling inside the
>> drivers/video/omap2/displays is a mess.
> 
> Well, that's not mess itself, it's just omap specific panel framework.
> But dividing single device handling into two separate places is a mess.

Yes, you are right it is not the mess, but it prevents the panel to
be used on other systems and that is BAD.
At the very least, drivers/video/backlight is a generic place that can be
used not just on OMAP.
And since the toppoly was and is used on other systems, why the hell
should anyone duplicate the driver just to please the OMAP specific
panel framework? The real problem is that this framework should not be
OMAP specific...
Of course I'm aware of the fact that currently there is no generic
panel framework, but forging something OMAP specific which is obviously
used on most of the other architectures/platforms (and I mean
panel<->controller relations), is not a good way to go.
Although, I'm also aware of the fact that most things are done this way:
do several specific drivers/frameworks, find the common stuff, and extract
it into a core driver/framework. So I don't want to blame anyone - that's
just the way how we do things, right?

> 
>> Those panels can be (and are) used not only with OMAP based boards.
> 
> True, but as there's no generic panel framework, that's the best we can
> do. But see CDF (common display framework) discussions if you're
> interested in what's hopefully coming soon.

Yep, I've seen the CDF discussion and I think this is a good way to go.

> 
>>> For a quick solution, can we just set the LCD_EN at boot time (with the
>>> msleep), and not touch it after that?
>>
>> That would be sensible for now, so this series can be merged.
>> As a more appropriate (and long term) solution,
>> I plan on moving the panel reset pin handling to the spi backlight
>> driver itself.
> 
> Well, if you must. But I suggest moving the whole panel handling into a
> (omap specific) panel driver, as it's done for other panels. That way
> you'll have a proper panel driver for it, for omap, and when CDF comes,
> you'll get a platform independent panel driver for it.

You can't just move generic architecture/platform independent stuff
into OMAP specific framework... Just think about this... It's insane.

> 
> Of course, if you have multiple platforms already using that backlight
> driver, the omap specific approach may not be enticing. So perhaps it's
> easier to just do the quick fix and wait for CDF.

That is exactly what I am talking about.
In addition, AFAIR, the reset pin is the property of the toppoly panel
hardware, so that is why I think, we should let the toppoly driver
(currently spi backlight, later hopefully CDF) handle it correctly
along with the spi sequences.

 

- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRHKJGAAoJEBDE8YO64EfacksP/j79jaDbnXpFcwT9KlInp8OE
e+XNi5Vt8zbqhj4gHtxZlN/eIQsVRfuivm9CTp5aJSZHBDAJlPNKobmwjFrDLO9V
RtYTwLAcuWyOdnutIQ52xNwXSntQknd8yxm1qJZMEBjEP+mcQxISWXXMsdxlQEiT
emNtU42W16ZOR34kHUoVfYLkV0v02/JVygt3oaU71+mrNBOt+5L6cHcXaQZPKSes
LUOcyz0qJfzKbnmmZnP/+clTIids83u8rVCNZ1/JoIIlR4rvtNcxRM8Apa8KFJx/
PVT38ds62F0L0qbxL3UmI1uJS2KuEHuJyjYo0uDeQqeeSyz7Q3ZG4TwAJYkWZdWQ
TdFbVrsXbK408FT33VIP4rOzDjqO93IK6f5ld0tZoIvL59NLwgXIejJn6jTNNcU4
p25mUXGSDnaZrNU5cC7d/MzSMt60XQx3UiHjEXD3eJAT33yb+DdBaQwloMCXJQOx
vnseFqhuAzgFHd9LEl47LBg7eXudjaSvWYfJOV0SoB9s7QM8m/YUhnmqmtvdCqZL
fKMJcAjCgm0BG2P6ss79sl6P4XDoBF1LOwSwz4dRmocA3TP7vBNkuRoK08vQe6gv
Qi7hJ05ioa8THt77FxMHtf+ZrO34/L6gHxZqrOD++OgPPdL6qtegemyp4IaKKbUg
q3Mpgsr4ODyStdjEXxTC
=lIHm
-----END PGP SIGNATURE-----
