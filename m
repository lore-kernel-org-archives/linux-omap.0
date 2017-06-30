From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Fri, 30 Jun 2017 09:41:35 +0300
Message-ID: <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1719294191=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============1719294191==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5dFrG342KQBUWtulI9vlF0vwwjTeujqlh"

--5dFrG342KQBUWtulI9vlF0vwwjTeujqlh
Content-Type: multipart/mixed; boundary="CB29ADuEFKGem6QQEwsSxweHRddhDi3Ox";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Message-ID: <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
In-Reply-To: <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>

--CB29ADuEFKGem6QQEwsSxweHRddhDi3Ox
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29/06/17 21:50, Aaro Koskinen wrote:
> Hi,
>=20
> On Thu, Jun 15, 2017 at 09:51:06AM +0300, Tomi Valkeinen wrote:
>> On 15/06/17 01:11, Aaro Koskinen wrote:
>>> When booting v4.12-rc5 on Nokia N900, omapdrm fails to probe and ther=
e
>>> is no display.
>>
>> Are you sure it doesn't probe? It fails the omapdss_stack_is_ready()
>> check?
>=20
> It appears the reason was that I didn't have
> CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled.
>=20
> I think that's wrong. I don't own an analog TV, so why should I enable
> such option to get device's built-in display working?

Indeed. Unfortunately I don't have a solution for that.

DRM doesn't support adding devices after probe. So at omapdrm probe time
we have to decide which displays to use. In the dts file, n900 defines
the lcd and analog tv. omapdrm sees those, and, of course, must wait
until their respective drivers have probed. If you don't have the
display driver enabled, it's never loaded and omapdrm never probes as it
keeps waiting for those.

omapdrm could start when some of the drivers are missing, but then the
question comes: when? omapdrm doesn't know if the driver will be probed
at some later time, or maybe it is a module, loaded later by the userspac=
e.

So, unless the DRM framework is modified to support adding displays
after probe, I don't see a solution for this.

>> If that's the case then this is easier to debug.
>=20
> Sure it's always easy... when users do all the testing and debugging.
>=20
> Is it just me or do other OMAP users fail to see omapdrm changes being
> posted to linux-omap for testing or review purposes?

I thought linux-omap was more for omap platform thingies. But sure, I
can start cc'ing linux-omap for all omapdrm patches.

> And now I face another issue. When I boot v4.12-rc7 with
> CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled and your "misc fixes"
> patches on N900, I get the error flood again, and the device is unusabl=
e:

Yes, I think there's still something wrong. I haven't been able to find
out what.

Somehow delays seem to help (like enabling debug prints), but I haven't
been able to find out where exactly the delay is needed.

And I'd rather not revert the patch, because there's nothing wrong with
that patch as such, and it fixes issues on all platforms.

So, I don't know... I guess I need to try to invent some horrible hacks
around the driver to somehow manage the omap3 problems. Perhaps
disabling/enabling the outputs when sync lost happens...

 Tomi


--CB29ADuEFKGem6QQEwsSxweHRddhDi3Ox--

--5dFrG342KQBUWtulI9vlF0vwwjTeujqlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZVfKfAAoJEPo9qoy8lh71OjwP/0iwQX0alhBiaFp3L28brJvo
8m41MevR3q24aaoQ9lEUizsheeIrjQqFv9hoG0ZEwWKAkYAqyToA+y8LcjOYAOxV
OmBkIyDBbAzxuhLXglvotQI8Sxw9nS7Xc05apLfwZktlfmp/ifFJOHqGy02dCu9I
SWVweI9I5WKETF9Rhd9muzm+QTAkel2X0rHo1CW799TsoKVOEailj8DPi+6sUAxv
+oKSGAHzWczSfYszYvTv20lQyGNPDaXXn3WoI5WMgcbdqg7nQnX1pArcppt/MnIC
Sz/V/2puW9wQSP6u2/m/RWDbO3m7WX7EvxaZ7FGbozfFv+c36vpJuC3P4JXNxumS
ejFhG5PKsDwRb+503UJ/PLWLWVoUty6KaT4OPAAu20cpzfmRBysMduXQ0vpRsUS/
sQQKdoKjCx5fiMG9LVIfNQENv4hG09TYGD1/6cuGqoQIrMlFzw6qFgq0gejqE6DK
IxNfDbj+Ru+VhDM9KIeIuwsOhb1sa77HLOkBAzp3ziXgBF5T6wW2nbmWrrzSCq4Z
R7x8deuH5c6ru8nf1oFz4X0IHmvPQ2H3OHSAoOmEyHH1RDuZjekjn5wwCZFX6IUA
S6xLllCWgVtkV73IZnvZAHLAChOLCvUNvaXe67SZ7G0uWzxx+2PoCsFxMBFQFf82
ZGUukuBj+ygm+j6OBRCQ
=LF4U
-----END PGP SIGNATURE-----

--5dFrG342KQBUWtulI9vlF0vwwjTeujqlh--

--===============1719294191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1719294191==--
