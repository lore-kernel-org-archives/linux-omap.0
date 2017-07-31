From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Mon, 31 Jul 2017 15:59:43 +0300
Message-ID: <1c44c560-a8f3-04e2-9558-1639441e3e32@ti.com>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <20170630085851.j5apctivufhmhp64@darkstar.musicnaut.iki.fi>
 <5bc9976e-228c-5cba-c2ae-bfc5135f17a0@ti.com>
 <20170704150902.GB10703@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2143186083=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170704150902.GB10703@localhost>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============2143186083==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lv8Dlu5MqJQeL2cIRFkQ1FgPRak2HQtDj"

--lv8Dlu5MqJQeL2cIRFkQ1FgPRak2HQtDj
Content-Type: multipart/mixed; boundary="3jOwMwUT5Jo5FEVgMPx5Waer6rP2FfrqW";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Message-ID: <1c44c560-a8f3-04e2-9558-1639441e3e32@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <20170630085851.j5apctivufhmhp64@darkstar.musicnaut.iki.fi>
 <5bc9976e-228c-5cba-c2ae-bfc5135f17a0@ti.com>
 <20170704150902.GB10703@localhost>
In-Reply-To: <20170704150902.GB10703@localhost>

--3jOwMwUT5Jo5FEVgMPx5Waer6rP2FfrqW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/07/17 18:09, Pavel Machek wrote:
> Hi!
>=20
>>>>>> Are you sure it doesn't probe? It fails the omapdss_stack_is_ready=
()
>>>>>> check?
>>>>>
>>>>> It appears the reason was that I didn't have
>>>>> CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled.
>>>>>
>>>>> I think that's wrong. I don't own an analog TV, so why should I ena=
ble
>>>>> such option to get device's built-in display working?
>>>>
>>>> Indeed. Unfortunately I don't have a solution for that.
>>>>
>>>> DRM doesn't support adding devices after probe. So at omapdrm probe =
time
>>>> we have to decide which displays to use. In the dts file, n900 defin=
es
>>>> the lcd and analog tv. omapdrm sees those, and, of course, must wait=

>>>> until their respective drivers have probed. If you don't have the
>>>> display driver enabled, it's never loaded and omapdrm never probes a=
s it
>>>> keeps waiting for those.
>>>
>>> Could you at least print some kind of message early in the boot ("oma=
pdrm
>>> is waiting for drivers for display x and y")?
>>
>> That could be quite spammy. omapdrm will defer probe if the displays a=
re
>> not present, and the deferred probing machinery will then cause a new
>> omapdrm probe later. That can happen a lot of times before the drivers=

>> are there.
>=20
> Well doing printk just once should not be a problem...?

I'm not sure if that would really help much... And you would practically
always see the print, even when everything works fine, which would be
useless and could raise false alarms.

 Tomi


--3jOwMwUT5Jo5FEVgMPx5Waer6rP2FfrqW--

--lv8Dlu5MqJQeL2cIRFkQ1FgPRak2HQtDj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZfym/AAoJEPo9qoy8lh71ja4QAIGer74qfoFCdW52GBliFdWq
jOC3mVREQOYmdHMENmIAPiGN8f/T0vEJqFdsprJes1IR7FNIb179AvV2AlCBQRSB
GbEXL87O7nP3PlUB6b9bQGOjoauUEgzy0d3QEtb7DZkg+6tBKbGuCit1eiyN4e/N
m18KjZrnFldMJuou4H6txILO7bTcU/odEiCQ7YhW0LMMKBpO4rew5HvH1C1cmGsU
k7OVkE4UdpyBWaiY6urpr2t0MHKfAbQdsDvLkpvGckcYEKyJUdTdZcCoYlQUyqCU
HHdxCRfLja86vGQvaPqNIairORwJGBEyGLvDKnD/WVNFZwGh8GVkJ2er7aovKNXi
Twt3xcFBHHbdANFqpO6ZM3c72sMZbmfwDzWz6RyF5YtH3vcCmLYeVhqvzt/XV4HW
l8HolqtOHAUwfHtiXx1n/kATI8ODUyO3iKgWWKo8/ecHtXCi04mPxkYzrNK9cnN8
xpC0n5ph9G+kBcV1oLilrhn/Vt9YHJkIvt3+Oy5sgpPIzXHlZXyFCRnR5KQMg1Oj
bZzEe1B4rpqVfaKGgW+tC4l8xvf81FhFMSoT8YqqQXSi1X3xd7R57AXR851SfDKZ
BzadUtJe+EtlRJfmCeEAjl6rD/bL3p+fbScmMnZYyhUYjWDHaUtco1rSLzECirJq
oJgLig0/Ob9WUlYTn4Or
=rYLb
-----END PGP SIGNATURE-----

--lv8Dlu5MqJQeL2cIRFkQ1FgPRak2HQtDj--

--===============2143186083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============2143186083==--
