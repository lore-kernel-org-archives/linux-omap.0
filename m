From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 10/10] ARM: dts: n950: add display support
Date: Fri, 24 Mar 2017 17:20:31 +0200
Message-ID: <38bb9030-5244-1751-1606-4d6598139bf0@ti.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-10-sre@kernel.org> <20170324142939.GY10760@atomide.com>
 <fe873378-a93f-5829-215c-fb4a3cc3f514@ti.com>
 <20170324151202.GZ10760@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2038953971=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170324151202.GZ10760@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============2038953971==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LFmXUCSMXLEdjUMosFeE3VMkDqeaiDmRX"

--LFmXUCSMXLEdjUMosFeE3VMkDqeaiDmRX
Content-Type: multipart/mixed; boundary="vhrkcaivDiHuohpROda6RHUUen0gcLQsq";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <38bb9030-5244-1751-1606-4d6598139bf0@ti.com>
Subject: Re: [PATCHv2 10/10] ARM: dts: n950: add display support
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-10-sre@kernel.org> <20170324142939.GY10760@atomide.com>
 <fe873378-a93f-5829-215c-fb4a3cc3f514@ti.com>
 <20170324151202.GZ10760@atomide.com>
In-Reply-To: <20170324151202.GZ10760@atomide.com>

--vhrkcaivDiHuohpROda6RHUUen0gcLQsq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24/03/17 17:12, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [170324 08:01]:
>> On 24/03/17 16:29, Tony Lindgren wrote:
>>> * Sebastian Reichel <sre@kernel.org> [170304 16:45]:
>>>> Add basic panel support for the Nokia N950. It must be tweaked a
>>>> little bit later, since the panel was built into the device
>>>> upside-down. Also the first 5 and the last 5 pixels are covered
>>>> by plastic.
>>>
>>> This one seems safe to apply separately to shrink the pending
>>> patches a bit. Please confirm if that's the case and I'll apply
>>> this one.
>>
>> No, I think there are too many open questions to apply this one. And w=
e
>> need to move to common DRM drivers at some point (hopefully soon) so t=
he
>> bindings must be aligned with those if and when possible.
>=20
> Hmm so what are the open questions and do you have in mind for
> the panel bindings?

Well, until we have driver that supports the panel without problems, we
can't be sure if we have everything in the binding. At least the TE was
missing or broken.

Normal videotimings don't really make sense for DSI command mode panels,
so I'm not overly enthusiastic in having them in the bindings. Possibly
that's the easy way to go, but I'm not sure yet.

There are the "TODO" parts in the bindings, that's a clear sign of open
questions.

I haven't looked at how the other DRM drivers handle DSI command mode
panels. That's something to study, before adding anything new to the
omap specific bindings.

> Naturally we still need to support the current bindings too.

Do the current bindings work? I guess they did work on omapfb... Do
these new bindings work with omapfb?

Generally speaking, I've been bitten badly enough with DT bindings that
weren't up to the task after all, and then changing the later was a
major pain (or working around it). So I'd rather not merge anything to
DT if there are any unclarities, and a driver not working which uses
those bindings is an unclarity. Especially if the only reason to merge
is to get a single patch out from a bigger patch series, without
actually enabling anything.

 Tomi


--vhrkcaivDiHuohpROda6RHUUen0gcLQsq--

--LFmXUCSMXLEdjUMosFeE3VMkDqeaiDmRX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY1TlAAAoJEPo9qoy8lh71jdcP/jpxtaNvv2tOfWLv2ZTbZcr1
iGjFJDO3eiumVSEHnCSQ/G8AsC1R1xi/LGwgkZFmPhw5CYkOwlRjaRB2LSrq/6hm
0GRdJXgP7oRbRhia9g1q/jGa2bu2DTnhZYGHIYdS172pV1ZEZMt6NE+0+aF0L1KQ
PCE1//Elg1u3xGCccNsUXm2+1Qdjj6MKFYhk131IrMiu1RyjOO6h5G23v9kedt85
6J0pirGbSza6poQcmoyczOGnlh97LlTevHcbqPjjf2lxI1qrYzFSD4zYb+xfWMsw
KWxvpOcRktBQAAvM+mfQyTB5RGmRvFKaAJ7weZj/9Zn9tR10lqq6qF1n76Mn7oug
IfFvkT+N/AM70aQ8sL/uE4JvVHs7IJiTSRPHCxARK7ssxTT+6lDX3VukvDUKqz5g
MavvCHjPEDpHJUMcHp6seTQs9O5QfvQTjgFgQ3zbeJGtG7j8k9kQeGaFy5GfucaZ
poXpoKz0LfuthHxCn3IC/6qYv7zsJkn5dbd9sgRBwTxhK8kxkrdG2+Gx763emFnn
iuwAFxocAi5jOwbRM8UkCdb+9v8XVjTgVCCxSAX+0YZ1zcBxG9NsJvIzdqYu7KXD
+gDxAUB/HaaXI6SSgFoRCMomVgs50/879252gT89d4qmA3QDzSudxlCwUmzufj/G
GsylcSbNV3eZk++KFumq
=3azz
-----END PGP SIGNATURE-----

--LFmXUCSMXLEdjUMosFeE3VMkDqeaiDmRX--

--===============2038953971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============2038953971==--
