From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/32] OMAPDSS: fix dss_get_ctx_loss_count for DT
Date: Thu, 30 May 2013 20:21:37 +0300
Message-ID: <51A78AA1.2000100@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-6-git-send-email-tomi.valkeinen@ti.com> <874ndk5sse.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2LRIIESTJWCEBWQSBUDLH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37398 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757312Ab3E3RVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 13:21:40 -0400
In-Reply-To: <874ndk5sse.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

------enig2LRIIESTJWCEBWQSBUDLH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/05/13 19:36, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>=20
>> When using DT, dss device does not have platform data. However,
>> dss_get_ctx_loss_count() uses dss device's platform data to find the
>> get_ctx_loss_count function pointer.
>>
>> To fix this, dss_get_ctx_loss_count() needs to be changed to get the
>> platform data from the omapdss device, which is a "virtual" device and=

>> always has platform data.
>=20
> Dumb question (since the DSS device model has always been beyond my
> grasp): how/why does the virtual device still have platform_data on a D=
T
> boot?

The virtual device will be created in generic omap arch code for DT boot
also.

The omapdss virtual device is an old relic. Originally we only had the
omapdss device, not the sub-devices for HW block like we have now. After
adding the sub-devices, omapdss device was still left, as it provided
useful functionality. It wasn't strictly needed anymore, but I've just
never had time to start refactoring code to remove it.

Now, with DT, it was just an easy way around to pass the func pointers.
Note that we also pass set_min_bus_tput, and a version identifier for
the DSS HW. The PM funcs could perhaps be handled some other way, but
I'm not sure how I could pass the DSS HW version.

> Also, this context_loss_count and DT boot is starting to get cumbersome=
,
> and there's currently no (good) way of handling the context loss in a
> generic way without pdata function pointers.
>=20
> I'm starting to think we should move towards dropping this OMAP-specifi=
c
> context loss counting, and just assume context is always lost.  If ther=
e
> are performance problems, runtime PM autosuspend timeouts can be used t=
o
> avoid the transitions.
>=20
> Or, on some devices, I suspect comparing a few registers against their
> power-on reset values might be a quicker way of detecting lost context
> and would avoid having to call into platform code all together.

Hmm, true. I'll look at this. Maybe I won't need get_ctx_loss in omapdss
at all.

How about omap_pm_set_min_bus_tput(), can that be handled in some
generic manner? Although, we currently use that in a bit hacky case.
What we're doing is not really setting min bus tput, but we're just
preventing OPP50.

The DSS clocks have different maximums on OPP50 than on OPP100, and we
need to keep the core in OPP100 to keep DSS working. So what I'd rather
use is "prevent_opp50()" than setting arbitrarily high min bus tput.

 Tomi



------enig2LRIIESTJWCEBWQSBUDLH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRp4qhAAoJEPo9qoy8lh71C7gP/RNsQH0+/yCr0qJHypXQY2yH
qej4vwBA6APUr0LszluICvMxhjqeStpL8Q3yD9Xx9GlBNuuwRIQwP+sIkeWFO/XP
+pkexV25tybGgfAitC8yPpNyPoaY5E9ulx/JaEplptGBeVLsrxDcYzybHmSSsQTM
NwACz9Z/32k6INL9iTnucMIo/wA2JruKmqON4TKh8HIlzn3jSdpnUYQqSY8lO1A7
yk8bNPdRVeKwnDcv3FxKSlt8SMC6h9ZHxNPpdkTyEWLnsQHc5IGMY/pC0qCpCFHu
UfVQhDSO7yxjI7XucojYjcvzV8GfLWa2k/iOPkEIeRJ8ApV5esTBY45xGvhzQ6sc
zn3/o8YrCdX4VuDhO0OPiArjbptHBsZZQlEV6rZLtXSziNXITUTJ7khsvWi1NUsR
amvviPAUKvi6OXI/LctVZLt/pQRaZgRvoSt7cwB38k9n+Boxc9HFN87aN9Uk4E/Y
aAixvPuJOUGbeLt6z/sPITIQ++qO+SEqM0T5fIuZC5K3k4xAHKa8Ow5kq8iz4nIm
Hpdq2407XFhjQbbjvBJlUbQGmN6nbLTFyFRP+wX0CcI7M4VzJ/TaXdaUPnjvfaXj
2WYqU5wQN/NQdwsDd4V35wxs8zah+Qbf8r8GDZdHngTKIPlwbQNwBlsVBMeav6hg
nuOpDm/huWYG4ZssP076
=24LL
-----END PGP SIGNATURE-----

------enig2LRIIESTJWCEBWQSBUDLH--
