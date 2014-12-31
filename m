From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Wed, 31 Dec 2014 16:00:14 +0200
Message-ID: <54A4016E.3000300@ti.com>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk> <20141217172333.GE23854@atomide.com> <20141217185155.GI11502@n2100.arm.linux.org.uk> <5491F0B6.4090904@ti.com> <20141218101618.GJ11502@n2100.arm.linux.org.uk> <20141218114949.GY11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50052 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbaLaOA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Dec 2014 09:00:59 -0500
In-Reply-To: <20141218114949.GY11764@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jyri Sarha <jsarha@ti.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>

On 12/18/2014 01:49 PM, Mark Brown wrote:
> On Thu, Dec 18, 2014 at 10:16:18AM +0000, Russell King - ARM Linux wr=
ote:
>=20
>> So that doesn't work - but importantly, it does point towards a
>> possible culpret - snd_soc_of_parse_audio_routing().
>=20
>> This is obvious when you stop and think about what it's doing, this =
is
>> truely where this bug lies, and it /is/ in generic ASoC code.
>=20
>> The problem is that this function doesn't consider the implications =
of
>> deferred probing.  Let's see what happens if we defer, and re-do the
>> ABE initialisation, including calling this function:
>=20
> Right, spot on - I'll send a revert for that upstream.  Thanks for
> tracking this down.

Mark, can you send the e3b1e6a19e09877b91517dfe304a2b3f6b2138fc (found =
it in
linux-next) for 3.19 if it not yet done? With that applied mainline boo=
ts up
on my Blaze.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
