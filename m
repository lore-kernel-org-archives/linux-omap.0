From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Wed, 19 Nov 2014 20:01:01 +0200
Message-ID: <546CDADD.3080003@iki.fi>
References: <20141116075928.GA9763@amd> <20141117101553.GA21151@amd> <20141117145545.GC7046@atomide.com> <201411171601.32311@pali> <20141117150617.GD7046@atomide.com> <20141118183545.GA16999@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141118183545.GA16999@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

Pavel Machek wrote:
> On Mon 2014-11-17 07:06:17, Tony Lindgren wrote:
>> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141117 07:03]:
>>> On Monday 17 November 2014 15:55:46 Tony Lindgren wrote:
>>>>
>>>> There's nothing stopping us from initializing the camera code
>>>> from pdata-quirks.c for now to keep it working. Certainly the
>>>> binding should be added to the driver, but that removes a
>>>> dependency to the legacy booting mode if things are otherwise
>>>> working.
>>>
>>> Tony, legacy board code for n900 is not in mainline tree. And=20
>>> that omap3 camera subsystem for n900 is broken since 3.5=20
>>> kernel... (both Front and Back camera on n900 show only green=20
>>> picture).
>>
>> I'm still seeing the legacy board code for n900 in mainline tree :)
>> It's deprecated, but still there.
>>
>> Are you maybe talking about some other piece of platform_data that's
>> no longer in the mainline kernel?
>>
>> No idea what might be wrong with the camera though.
>=20
> Camera support for main and secondary cameras was never mainline, AFA=
ICT.
>=20
> Merging it will not be easy, as it lacks DT support... and was broken
> for long time.

I have a smiapp patchset for DT support that I posted a while ago, here=
:

<URL:http://www.spinics.net/lists/linux-media/msg83285.html>

What's missing on top of that is the omap3isp support, plus something t=
o
toggle the sysctl registers based on the chosen receiver. I have a
preliminary, not RFC yet but functional set here:

<URL:http://vihersipuli.retiisi.org.uk/cgi-bin/gitweb.cgi?p=3D~sailus/l=
inux.git;a=3Dshortlog;h=3Drefs/heads/rm696-045-dt>

The main camera support requires et8ek8 driver as well, and resolving
the breakage with the image capture on 3430.

N9/N950 will be first, though. Lens controllers are another matter, but
nothing too difficult on that side either.

> Anyway, flash is kind of important for me, since it makes phone usefu=
l
> as backup light; and it is simple piece of hw, so I intend to keep it
> useful.

Me, too. :-)

--=20
Kind regards,

Sakari Ailus
sakari.ailus@iki.fi
