From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Patches to bind the SGTL5000 chip to AM33XX McASP
Date: Fri, 20 Mar 2015 10:09:04 +0200
Message-ID: <550BD5A0.6080400@ti.com>
References: <1426741659.10003.9.camel@midgaarde>	<550AC783.8040304@ti.com>	 <CAAQQ3u=opRm3UzD+bG6aJvhQU2CFmzH4sXzuA=GxDp2d+MMiNg@mail.gmail.com>	 <550AF442.5040203@ti.com> <1426787288.13824.36.camel@symus-gk-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45636 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbbCTIJW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 04:09:22 -0400
In-Reply-To: <1426787288.13824.36.camel@symus-gk-mint>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Knight <g.knight@symetrica.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Greg,

On 03/19/2015 07:48 PM, Greg Knight wrote:
>> For a codec such as the SGTL5000 I would connect a clock, which is
> running all
>> the time. If you take a look at the driver, it enables the clock at
> probe and
>> leaves it running as long as the driver is loaded.
>=20
> Speaking briefly to my "electrical" colleague, he's a bit concerned
> about the extra power load that a crystal oscillator might incur, whi=
le
> I'm concerned about audio quality from a source like CLKOUT2.
>=20
> Is there a straightforward way we could enable the clock on-demand -
> when we're communicating with the codec/mixer or actually using the
> audio subsystem - while keeping it disabled when not in use? We don't
> expect to be using the audio subsystem frequently.
>=20
> Worst-case we can set up a GPIO and enable/disable it as needed in
> user-space - acceptable, if annoying, for our application.

See my reply to Nikolay.

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
