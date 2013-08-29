From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 19:01:01 +0100
Message-ID: <20130829180101.GO10783@sirena.org.uk>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <20130829110534.GV10783@sirena.org.uk>
 <CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4024107348387216128=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============4024107348387216128==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YRPL3RJyuON7wuhd"
Content-Disposition: inline


--YRPL3RJyuON7wuhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2013 at 08:42:11AM -0700, Russ Dill wrote:

> The path I'm taking in this patchset is to just put the board specific
> I2C sequences necessary for the CM3 coprocessor to write out into the
> devicetree. I've made it as generic as I can so that other platforms
> with similar issues can reuse the bindings. Because of the limitations
> of the firmware size and the desire not to have some sort of byte
> code, this is a write only sequence.

Making it write only seems to be a mistake - like I said in my other
mail I'd expect you'd want bitfield updates here.  The read and modify
could be done earlier by Linux though.

> Kevin Hilman is suggesting some way to query the regulator framework
> for this sequence. There would be some call to the regulator framework
> that would return a series of I2C commands that would be necessary to
> program a regulator to a specific voltage. It would be called twice,
> once for the suspend voltage, once for the resume voltage. The
> regulator framework would then call into the driver that sets that
> voltage, and by some method query the driver for the necessary I2C
> sequence, either by some special new call, or some regmap magic.

If it's just setting a single voltage then extracting the bitfield to
update shouldn't be too hard for regmap based regulators.  Off the top
of my head I'd expect either the driver for the M3 or the cpuidle driver
that talks to it to be a consumer of the regulator and then go from
there.

Just putting the sequence directly into the device tree doesn't feel
like the right abstraction.

--YRPL3RJyuON7wuhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSH4xaAAoJELSic+t+oim9lPsQAIabpXWiw4FqdXrPxiPgFI67
CASXGao/PcUkdtNQsVxbPQM5yL0dk6M1D4O1I97TSDkhUo/4PB9ATD+aw8WRLdb4
jr5Q+nFn3OBWgS7udn1ndcaKmCov6IMR/iHxyaiIHWzMqApJZslSGawuMMkoAJBA
/lxx07+Z6MUO8+ZWTlyoIXaJbWZcpYMT2HZTMt1bpvtaGc7tPA5IP2ewo5leijAS
t25oWVNC0tEdOTDEEFgM0wPVmCZIVkVZov9+vejnR8vLtttCgrLGQipqBoi084R4
h1NhM0/Hxsiin6hBMWxpmc65fa0qsI+Ut6h+QxEdyhpB206/ZxHqKUViO2cVc5iJ
ykEDAi2CCmyIZiXrrYKdZMJ/14BgcuBQUvz0qtskq8FyAuM8tbmIy6xSOfJneVWI
zf2WgB6DI31d3+sXTiqB8pXk8D8zPSmFu3hFqM8UbHSGpv14aBvbmGZ3WTOHlHO8
m3aEcCF6fCgJp550qLJtY8J4nEND4he0YPp3nCqByivViyS9Mo8UlynW0PasSlMg
G1p+E9GJuTFqhkntfBabmTwGNSnsPiDC1uK3gp/YXHsSJUINGUOGnvONoAKJXayq
Tar/AnDL2KNGJoqXrOC0g0KoxIz//LODf5yrKGKyEu3G19kWlfz8ORAauId08Qw7
R7nV3xAziF7MmRVF6LOO
=yg9z
-----END PGP SIGNATURE-----

--YRPL3RJyuON7wuhd--


--===============4024107348387216128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4024107348387216128==--
