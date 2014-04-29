From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Tue, 29 Apr 2014 19:27:12 +0300
Message-ID: <535FD2E0.1050806@ti.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com> <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com> <20140424182914.GD4659@saruman.home> <20140424184457.GH22987@atomide.com> <20140429155111.GC633@saruman.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="iCTPQqg5OR42olfkhqNx3tCStoGlTQFuQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32980 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbaD2Q1k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 12:27:40 -0400
In-Reply-To: <20140429155111.GC633@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>

--iCTPQqg5OR42olfkhqNx3tCStoGlTQFuQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/04/14 18:51, Felipe Balbi wrote:
> On Thu, Apr 24, 2014 at 11:44:58AM -0700, Tony Lindgren wrote:
>> * Felipe Balbi <balbi@ti.com> [140424 11:29]:
>>> Hi,
>>>
>>> On Fri, Jan 17, 2014 at 09:44:59AM +0200, Tomi Valkeinen wrote:
>>>> omap2_dpll_round_rate() doesn't actually round the given rate, even =
if
>>>> the name and the description so hints. Instead it only tries to find=
 an
>>>> exact rate match, or if that fails, return ~0 as an error.
>>>>
>>>> What this basically means is that the user of the clock needs to kno=
w
>>>> what rates the dpll can support, which obviously isn't right.
>>>>
>>>> This patch adds a simple method of rounding: during the iteration, t=
he
>>>> code keeps track of the closest rate match. If no exact match is fou=
nd,
>>>> the closest is returned.
>>>>
>>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>>
>>> Tony, looks like this patch was lost. Are you taking it during the -r=
c ?
>>
>> Would like to hear what Paul thinks of the updated patch suggested
>> by Tomi first.
>=20
> Paul, any chance you can review Tomi's v2 ? It'd be very nice to get
> display working on BBB.

Btw, I'm fine with my v2 patch, but I think the original one is fine also=
=2E

It's true that the original patch changes the dpll behavior when an
exact match is not found. However, I think our drivers always request an
exact match, and in that case the original patch doesn't change the
behavior in practice.

In theory it's possible that a driver requests a non-exact clock from
the dpll, and when it gets an error, it does something else. But, if I'm
not mistaken, all our dplls have a clk-divider after them. And as
clk-divider doesn't handle the error from dpll in any way, and instead
returns bogus rates, I presume all our drivers use exact clocks.

So v2 is perhaps slightly safer option, but I'm not sure if the added
complexity (even if quite small) is worth it.

 Tomi



--iCTPQqg5OR42olfkhqNx3tCStoGlTQFuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTX9LgAAoJEPo9qoy8lh71qB0P+gOe4yqQrmX8O9kOc7D7oF/2
1BVMMvI1C5wis3DIpka7xuwD8Bvym0vRKYNNDudVNnPFVC8yYcRkJ6s+oTRksfhB
Rd+aWjE+qo9nM3U/f9wi7n4vnijc2wP5hJC9Jw050ONaAiaTT1Ecs6P8vveMlQa7
Ds1WhmA6UkRlCgJm0dU9z6O+BUxePsUmwqE3vFqCCcmem2z2BDlM/uf3yXbmtlzL
1lvTqpOwPpN1QIpTfTzPDUtNherTngOO7yKyyamNJNRx7XF63paNKCMbwIoLJDR0
eJidoXHGw9QTfd+haGiYzZG1BsknFZZUXrg/8ax9tp2UWYnZdOX/rhoCHo//O1kZ
W56+4CT04hci3rWEo4W4ya2FdvVk7i/vdriV9YTpVAKKA40mveSL/Nr4x6uVAtRE
MnW2b+XXfQFuc+sTvJW8iYyaT9trBV2Kai2gj6BAygNKWaH5n/ba+HWAM/hkTWti
zmT+QUv/20VG/TCxKaed2lg/g95cvJEDXHuE3cMnN5i9KpwUHMCjNqOu8b7oLLKr
DIxX/TrbSVClFPSO5tvW3VziF6ntWmcYLpqV/wc/9v4MkYi+8oZTfp5zoGAc4Yvt
9fl6MNF6aZuyvsp1ZPQZBx6DNBVoU20YXMhvoYN0ZluXMBlZQXMG8hC+1o5874YH
mjjUPbULDUwyTzaTt8cN
=2Y/y
-----END PGP SIGNATURE-----

--iCTPQqg5OR42olfkhqNx3tCStoGlTQFuQ--
