From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Fri, 30 Jun 2017 12:02:48 +0300
Message-ID: <5bc9976e-228c-5cba-c2ae-bfc5135f17a0@ti.com>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <20170630085851.j5apctivufhmhp64@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2138600577=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170630085851.j5apctivufhmhp64@darkstar.musicnaut.iki.fi>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============2138600577==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SP3tQL17KfaAoru5RkgA9tlUnEBc9q09U"

--SP3tQL17KfaAoru5RkgA9tlUnEBc9q09U
Content-Type: multipart/mixed; boundary="r1DQ2L6cLDM9jwXxTswNAbg0oHv2OMa8P";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Message-ID: <5bc9976e-228c-5cba-c2ae-bfc5135f17a0@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <20170630085851.j5apctivufhmhp64@darkstar.musicnaut.iki.fi>
In-Reply-To: <20170630085851.j5apctivufhmhp64@darkstar.musicnaut.iki.fi>

--r1DQ2L6cLDM9jwXxTswNAbg0oHv2OMa8P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30/06/17 11:58, Aaro Koskinen wrote:
> Hi,
>=20
> On Fri, Jun 30, 2017 at 09:41:35AM +0300, Tomi Valkeinen wrote:
>> On 29/06/17 21:50, Aaro Koskinen wrote:
>>> On Thu, Jun 15, 2017 at 09:51:06AM +0300, Tomi Valkeinen wrote:
>>>> On 15/06/17 01:11, Aaro Koskinen wrote:
>>>>> When booting v4.12-rc5 on Nokia N900, omapdrm fails to probe and th=
ere
>>>>> is no display.
>>>>
>>>> Are you sure it doesn't probe? It fails the omapdss_stack_is_ready()=

>>>> check?
>>>
>>> It appears the reason was that I didn't have
>>> CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled.
>>>
>>> I think that's wrong. I don't own an analog TV, so why should I enabl=
e
>>> such option to get device's built-in display working?
>>
>> Indeed. Unfortunately I don't have a solution for that.
>>
>> DRM doesn't support adding devices after probe. So at omapdrm probe ti=
me
>> we have to decide which displays to use. In the dts file, n900 defines=

>> the lcd and analog tv. omapdrm sees those, and, of course, must wait
>> until their respective drivers have probed. If you don't have the
>> display driver enabled, it's never loaded and omapdrm never probes as =
it
>> keeps waiting for those.
>=20
> Could you at least print some kind of message early in the boot ("omapd=
rm
> is waiting for drivers for display x and y")?

That could be quite spammy. omapdrm will defer probe if the displays are
not present, and the deferred probing machinery will then cause a new
omapdrm probe later. That can happen a lot of times before the drivers
are there.

 Tomi


--r1DQ2L6cLDM9jwXxTswNAbg0oHv2OMa8P--

--SP3tQL17KfaAoru5RkgA9tlUnEBc9q09U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZVhO4AAoJEPo9qoy8lh71SwAP/AzenYHX4vY19wJUq+O0EH1c
34uMQZmLGmfbzp5pSOkccx2zjeWCcfIMsHwtWaVZEd9iBJj4XcNezovo5d/uXudG
Q9iLDLi2m451aPfS3CfC9yeVVIoUgofogMB5S06c4SsyAYCHbfWcxeXSB4T/A8Lg
N+YoJnPf7GC4YUqTItosDKW5jwvHz2UqsxbXEidayZJwMkqBfnXAgnpQ6EjUFLzV
gp7ljLnp8aR4o1/Nm7+etdfaYhizO6YWW2G4MDWibv1uzpSu7ROQPCNRUuISPJMK
7lg+P9WI0v2ItG2Epj7JeKKKzopjxaY6rkfXPcAkTfPWtkHP3Pl6KPxnnD+5YkMI
NwP73ztkCAQ0NvI2MU1N0sdK9XeBTpDGKfitMWQ1TcIxfosOf66lSJlWSXf4PyfT
oboik0J341GcxfFSSesdEcglYSKb9T/wH6ECWDBfa1qRVmgt+apoSDbM/+Je7owQ
OxklfY02//WJ6ePYyJJk4bSAFr5HBrqJGloAMpuIe+UCB5Xg+xS4VxybdhXOqSEz
4imQJf4Y1IwkX0fRNbhEo/CYFwwdHy6BUxhwjswNbXSJzEF2ezQTyzxW8wHVU5eh
N1t+37WCJi3tT6T+jwLWyxjMdL7Uw3UESO9GDBeQe3krIfgcwGZoVKRvEWJu6daH
fvqci6ZTOKOsDonfoDfZ
=Mnka
-----END PGP SIGNATURE-----

--SP3tQL17KfaAoru5RkgA9tlUnEBc9q09U--

--===============2138600577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============2138600577==--
