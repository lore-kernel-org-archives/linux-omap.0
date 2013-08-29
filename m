From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 20:10:51 +0100
Message-ID: <20130829191051.GT10783@sirena.org.uk>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
 <20130829110534.GV10783@sirena.org.uk>
 <CA+Bv8XaX6v7wH0d1c2S7RzFDx6rAueHi1ZkmkGMpvcNDypXvzQ@mail.gmail.com>
 <20130829180101.GO10783@sirena.org.uk>
 <CA+Bv8XavoekzHM6DU3BFdq8W+XK6aGr7bvW60W3L6gR2Cu2p4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3882026844987464049=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Bv8XavoekzHM6DU3BFdq8W+XK6aGr7bvW60W3L6gR2Cu2p4Q@mail.gmail.com>
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
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============3882026844987464049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ElEgulhWJDonIdTi"
Content-Disposition: inline


--ElEgulhWJDonIdTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2013 at 11:25:43AM -0700, Russ Dill wrote:
> On Thu, Aug 29, 2013 at 11:01 AM, Mark Brown <broonie@kernel.org> wrote:

> > Making it write only seems to be a mistake - like I said in my other
> > mail I'd expect you'd want bitfield updates here.  The read and modify
> > could be done earlier by Linux though.

> Updating bitfields in memory is pretty basic, but with I2C, each
> device has its own register sizes and methods of accessing registers.
> The first byte of an I2C sequence being a register address is pretty
> common though. You'd need a method of defining in the device tree
> piece how to modify bitfields.

I'd not assume byte based addressing for a PMIC, it's very common but
not universal.  The difficulties here assume putting this in the device
tree as explicit register I/O - I do tend to agree with Kevin that this
doesn't seem like the right abstraction.

> > If it's just setting a single voltage then extracting the bitfield to
> > update shouldn't be too hard for regmap based regulators.  Off the top
> > of my head I'd expect either the driver for the M3 or the cpuidle driver
> > that talks to it to be a consumer of the regulator and then go from
> > there.

> It'd be a list of bitfields. So are you suggesting a regulator_ops
> call that would return a list of bitfield updates along with an I2C
> controller, an I2C device address, I2C register addressing scheme (8
> bit, 16 bit, or other) and the info for each bitfield (register size)?
> And then each regulator driver would be updated as needed with this
> code. Would this be a way forward? Would regmap actually tie into this
> at all?

I was thinking about the majority of regulators where setting a voltage
would be a single bitfield update (plus ramp delay, which is going to
need to be accounted for in the power on case).  If we need to do longer
sequences things get a bit more tricky in terms of interface but it
seems doable.

regmap would tie in in that it already has a way of describing the
format for interactions with the device so we could just reuse the same
description, and with some work we can probably reuse the code that
generates the bitstreams for sending to the devices too (though I don't
immediately see a nice way of doing that).

Not sure if this is worth the effort or not though, but then there's the
whole DT as ABI thing to worry about...

> This is VDD core, so its not related to cpuidle or the M3.

It's related to the M3 if the M3 is managing it; you can have multiple
consumers for a regulator so it doesn't need to be one or the other.

--ElEgulhWJDonIdTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSH5y4AAoJELSic+t+oim9ZqoQAJoyB/+8lmvSY2bM/5ESw+vA
/cXnklrs/2qSYcD4pFvD6CFn/UVoQQuPwFA1uYnGgMS6vexM58HyxlPXIJy4fUhY
Ooze7Jepr5UTq51XfqIBevOcZBAv5N+ASGZEOE6eBN8uH/ZPasUXzYYFUYqL80+k
tDRXT/yKH72/UJpqwbcqpBC6lEE9YLlM6a/BvAbwgxPpfdW0lxw5+cjXeCD/TqsQ
NUAv+NPylTETgOooCSe4o4n2U2lwWP7ZnrmGgf12p82zl2fX+9OlssJZ1HNvKhM1
NNJZr/E9rnG+l8DlA7gfb2VmG82zqndMJe+QaDiKfalEpj/1NDL/V8/rPhFVqY86
YMWJV0Q6ccDy5eUN01Vd/iY4NSoVel5W3z/qht6kE9piua5SNe8+tQJYZ4OMcqRq
1CE9EhVCCKLpX0TDrK/MoiQuWKC/NlDc7BLlvBl79DxS0974xYCZcVaNdZYH6oxF
IbQTJxVV3M8i2orcT31pMUgLZPVaP4H39nFaj0iVbpnPTI2+Qh6wJzZyK+lJOb0e
y6CEgJ47O54zHsRhWEH0GenHuasI0PhLyH33LZMDI3I3s8rxw56PcHZ/LhokpDJf
B264+wskp02etUHrM9t+QcEP833EBlwMsQQvsc7dgF4l40CL13AFna5sF44xRS8Y
WEecpYmXQtmCSxcMm/Mx
=f1Pa
-----END PGP SIGNATURE-----

--ElEgulhWJDonIdTi--


--===============3882026844987464049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3882026844987464049==--
