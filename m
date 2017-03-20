From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: omap4-droid4: Add LCD
Date: Mon, 20 Mar 2017 09:52:20 +0200
Message-ID: <9c4a5d88-4d2a-2120-9fdf-f3fbba69147c@ti.com>
References: <20170305054359.8293-1-tony@atomide.com>
 <20170305054359.8293-7-tony@atomide.com>
 <20170319012927.kmyqngprpip7le4m@earth> <20170319161030.GA20572@atomide.com>
 <20170319225542.ts53qpwdhdrmy2ac@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="Vujr69NBkmhFA3CGvWht0f4LOfvwE5bFG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170319225542.ts53qpwdhdrmy2ac@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Vujr69NBkmhFA3CGvWht0f4LOfvwE5bFG
Content-Type: multipart/mixed; boundary="nritWwl2v88hfWSsnSBP1hk1PqwNTJsI6";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?=
 <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Message-ID: <9c4a5d88-4d2a-2120-9fdf-f3fbba69147c-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: omap4-droid4: Add LCD
References: <20170305054359.8293-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170305054359.8293-7-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170319012927.kmyqngprpip7le4m@earth> <20170319161030.GA20572-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
 <20170319225542.ts53qpwdhdrmy2ac@earth>
In-Reply-To: <20170319225542.ts53qpwdhdrmy2ac@earth>

--nritWwl2v88hfWSsnSBP1hk1PqwNTJsI6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/03/17 00:55, Sebastian Reichel wrote:
> Hi,
>=20
> On Sun, Mar 19, 2017 at 09:10:30AM -0700, Tony Lindgren wrote:
>> * Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170318 18:31]:
>>> Hi,
>>>
>>> On Sat, Mar 04, 2017 at 09:43:59PM -0800, Tony Lindgren wrote:
>>>> The LCD panel on droid 4 is a command mode LCD. The binding follows
>>>> the standard omapdrm binding and the changes needed for omapdrm comm=
and
>>>> mode panels are posted separately.
>>>>
>>>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
>>>> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
>>>> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>>
>>> Tested-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>
>>> With a non-modular kernel lcd is not working with omapdrm if HDMI
>>> is enabled. After dropping HDMI in droid4's dts file everything
>>> worked as expected. I assume both work properly with a modular
>>> kernel?
>>
>> Yes with loadable modules both work just fine. If things do not
>> work properly as built-in, chances are there's some unhandled
>> dependency that needs -EPROBE_DEFER somewhere for a regulator
>> or a clock.
>=20
> I think that would also result in problems with disabled HDMI.
> I guess the problem is, that omapdrm is initialized too early.
> AFAIK omapdrm is not hotplug-capable.

It shouldn't matter when omapdrm is initialized. omapdrm should wait
until it has all the displays.

 Tomi


--nritWwl2v88hfWSsnSBP1hk1PqwNTJsI6--

--Vujr69NBkmhFA3CGvWht0f4LOfvwE5bFG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYz4o0AAoJEPo9qoy8lh71RywP/1W0XVUmCrVb6oX9T1MLx6P9
GZ9pRfQi62wAsDr5jQNa6+FhDUxY2CrviHziOiy+nJLI5jXH1O2Yw68l6oFFxGpU
9KAj9urfkNKCwXI4IpYpAEmkpI5dm/CdW0+H31n8Co9qlelekDfXOQVupUP12dkx
AbyazDWxTiaEDflVmvpl/72ZZFI1/x72NhTvFcZ3o9u1gSvbH+2WcO0fbCcnHpb1
jpYl8LXUNxkJ68Ws/WjZASkKmdWaggV0ap1XxW4nH2sDvWUkNRX0UNByb3KXgajc
mUStm2+4RNLp7LhOcnSR+yJzjPfHt73h49oexz63thFGqnnwDgT/ZhMmjcw5Vp8q
VHUmjuIeMZfrMHF8q9bJijAfEYpJUCVLJYmrxkSSL/fKGY9txjGH4nULjtBG4y52
Mg8T0lfdCtEgDTwJhvJjm0YjE58cDVilwIPoVtcl274AXIV7380ZBiK20x/YV9Fj
U9ijqcF86ghX//w+cOdYRRvWwKCSe9dlIQQ7/WugtfB7FNjudGJDCyZ+ovs9wtpc
hs4Z8lF9bM7qag2P+42wmQVhCiNm3BA7bZ+OCmfR1oxZJqA1tY9/DbhXQdgrxanz
QHxK1Xwqj5YatnChRuFJwFngvPAOzwfhp/FL7LByt8tYUJWNIUik+VxCk4p/fgQp
pRrXWT1qo/vkLQvJ9Xze
=FKm9
-----END PGP SIGNATURE-----

--Vujr69NBkmhFA3CGvWht0f4LOfvwE5bFG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
