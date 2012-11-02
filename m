From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Fri, 2 Nov 2012 13:28:57 +0200
Message-ID: <5093AE79.9010603@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com> <5093A3FB.1060806@ti.com> <5093A530.5050302@ti.com> <5093A9E8.70106@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig41B69E984FE764B38DE06375"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41138 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2KBL27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 07:28:59 -0400
In-Reply-To: <5093A9E8.70106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

--------------enig41B69E984FE764B38DE06375
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-02 13:09, Archit Taneja wrote:
> On Friday 02 November 2012 04:19 PM, Tomi Valkeinen wrote:
>> On 2012-11-02 12:44, Archit Taneja wrote:
>>
>>> Hmm, that makes sense. Anyway, I don't think it's really bad if we re=
fer
>>> to dssdev->channel for now.
>>
>> It is, because dssdev->channel doesn't exist with DT.
>>
>> With DT we either need to figure out the channel in omapdss at runtime=
,
>> or add a property to the DT data telling the channel. And adding such =
a
>> property is not correct, as DT should be about describing the HW.
>=20
> Ok.
>=20
> I don't totally agree with your idea of figuring out the manager in
> panel the panel's probe. If it's done in the panel driver's probe
> itself, then by this point of time we have already set
> mgr->output->device links. If omapdss only does this stuff, then

Hmm, I'm not sure I understand what's your point above? If figuring out
the mgr is done in panel's probe, the mgr->output link is not yet made
before that time.

> omapfb/omapdrm have just the job of connecting the overlays to the
> manager. Do you think that's okay?

Yes, that's how I think it should be. I don't see why omapfb/omapdrm
should care about which manager is being used for the output, it doesn't
really matter as long there is one and it works.

Then again, I don't have anything against omapfb/omapdrm choosing the
manager, but I don't see how they would have any better idea of which
manager to use than omapdss.

But as doing the connections at probe time is a bit problematic, perhaps
we should have a new step in this whole sequence. Something like
"connect" or whatever, which would lock the required blocks in the whole
pipeline, and acquire the required resources that couldn't be gotten at
probe time.

But even then, choosing the manager is not easy, as whoever chooses the
manager needs to observe all the possible displays used at the same time.=
=2E.

 Tomi



--------------enig41B69E984FE764B38DE06375
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQk655AAoJEPo9qoy8lh714NkP/16CSXwBfteeiv1h24+26q1W
qVKk+SRkUoOgTECdjllWHUfkXxE8LGmahBUvansr7eduReA9mOOq8n8Qqyo1gSYC
PjEHmqaIvgbqR1pI6AJHWxxVwOw53Kak312K3Ry+lfK/4k/xj2wuawZJ49rH7f8j
PcxZ8HEjjUAilAFG2MAsTttcVhCfzKl4jkYJ7nz+Yz3oCzHeiHqN4jBbs9+gKaBR
uia9dvb2nJfRoYXa7UyGuGu9fhEB28QvzSEvEGE0UJ6fBiPy9B1Voqh21swDZxKc
nd7mR6UwF/wxDcI64AP9d2d0yZeotbD9gEUrCFWAk5cLQPZL1+mwNoMf9akpUIKP
U8l0XIB2bHfwdkW83Lw0XQ1V9gZ1wDumT3YdR63fj4BvcOwLDA5iZczU6z8IpWab
x/Qg+waUlxZlvaCvCANpN+t+1bvduw5gXS+kcKd0Kh8PH5FUPbTFPI56Zv90IPtT
fO3uS6KuYuzvRvlKNbbD+0FfFVCLVFwAgixDZ/1bscdxzxEgfKJmQ/TmSlWrxZ6P
LQzfxnY8z8C1KvLpWQPh0xt9/vP4b00IoT4CIluurOmWBdhtBeDeFd9lQXRAXEpG
X/c7u3bM97DjTS+OxICa+dV8GChrEi6kweXG2rQcDwYWm/GpKkNrfEkTd0B+THLu
ZMu0BE//nwiBnorN97gJ
=JuhG
-----END PGP SIGNATURE-----

--------------enig41B69E984FE764B38DE06375--
