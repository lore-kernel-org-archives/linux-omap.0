From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Mon, 12 May 2014 15:11:46 +0300
Message-ID: <5370BA82.8030703@ti.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com> <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com> <20140424182914.GD4659@saruman.home> <20140424184457.GH22987@atomide.com> <20140429155111.GC633@saruman.home> <535FD2E0.1050806@ti.com> <alpine.DEB.2.02.1405072210360.23579@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="7pg1Oo8I5pbRoKUF8aGBjauIFXLXMMqS2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52460 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723AbaELMMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 08:12:14 -0400
In-Reply-To: <alpine.DEB.2.02.1405072210360.23579@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, nm@ti.com, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>

--7pg1Oo8I5pbRoKUF8aGBjauIFXLXMMqS2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/05/14 01:16, Paul Walmsley wrote:

>> It's true that the original patch changes the dpll behavior when an
>> exact match is not found. However, I think our drivers always request =
an
>> exact match, and in that case the original patch doesn't change the
>> behavior in practice.
>>
>> In theory it's possible that a driver requests a non-exact clock from
>> the dpll, and when it gets an error, it does something else.
>=20
> The path that worries me at the moment is the set-rate path.  That call=
s=20
> __clk_round_rate() (if the user hasn't called it already) and silently =

> tries to set the clock to the altered rate.

Hmm, so you mean a driver could call set_rate, and presume it only uses
exact rates the dpll can produce, and presumes that set_rate returns an
error if the dpll cannot produce the requested rate?

Isn't that what I said? If a driver has such behavior, I think it still
doesn't work, as (correct me if I'm wrong) we always have the
clk-divider after a dpll. And the clk-divider doesn't handle the error,
so neither can the driver.

Or what kind of scenario do you have in mind?

 Tomi



--7pg1Oo8I5pbRoKUF8aGBjauIFXLXMMqS2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcLqCAAoJEPo9qoy8lh71jvkP/3tf74UzYJ7bBB2eticLUPjq
jbsZPfBhV4WSvpW3GbrVrU9jTDiD7PVUbyYWHu2jLaSIJF+Ddq/tHfTVROqzuBkA
HMWIGHmQXsv4DvOV7cMjlZD4tSHsk1DgYLFcbx4GXoWD2PkHjRZyLkZ0pe1Eg2XF
tLpJaftFKbqSp83FEj7TwTWVkwFdtStPbNRI4iyp4jgu3dbOyz/Zupq6LN5ecdYd
NabtMlVMvVKCuvv9osP3I6A2s8fgJCyQVqztBN9fXrtRsuAUBt8ZbJi8+gynIms6
jWMQ4KY4FJ3mb5yM2jv5+X4euIKlTSmKERZX4KAeChwZDCbtHiaMvm0kh+Yfus6B
F7miehrj0FQ+R+M0Kkrl8wG3L3emZezuZFag1oy/jqiBdzt/WzafDsCl+TtyBEzk
T7+gVH3HagHJXM+c9RZGc5ULkN8dHvwq3OKxhquCOznKnS8IKydRYfXnkJoEf+PC
low1NB5chRybR5Dk0iTJWhNZsOoRhNjf2REVxb8bHwcaSZiPVhrIOIGPoOHtbsrS
pWZlgFB/MwLkAmk8forTf0uADwcyqNGQ7GrBQn9mzmasAkMbwAvL0fscJnH7vH06
5r5BzELBGMZUnCo014rgB28hWOGrBcqTOS3nXMhY1BPQy4a8SFxu0XNyVd2oJJsd
rKuCVhSgINX2ZwtfWdNf
=CDxT
-----END PGP SIGNATURE-----

--7pg1Oo8I5pbRoKUF8aGBjauIFXLXMMqS2--
