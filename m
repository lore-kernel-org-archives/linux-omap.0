From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/23] drm: omapdrm: plane: update fifo size on atomic
 update
Date: Wed, 14 Dec 2016 11:14:32 +0200
Message-ID: <a60e0657-e0cd-839c-20ea-d29a73e198ff@ti.com>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <8209536.SBuD0B7HP3@avalon> <4c863692-d6d4-3940-b78e-3e7b9d114cad@ti.com>
 <9003662.GMTnJkJbn3@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="keDLla7SkA8wOlDeDGeQcMRFECifriQ4h"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9003662.GMTnJkJbn3@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--keDLla7SkA8wOlDeDGeQcMRFECifriQ4h
Content-Type: multipart/mixed; boundary="x1cIc4ll3AhQdJJj1BPmhjNMpvVvTw0J9";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <a60e0657-e0cd-839c-20ea-d29a73e198ff@ti.com>
Subject: Re: [PATCH 12/23] drm: omapdrm: plane: update fifo size on atomic
 update
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <8209536.SBuD0B7HP3@avalon> <4c863692-d6d4-3940-b78e-3e7b9d114cad@ti.com>
 <9003662.GMTnJkJbn3@avalon>
In-Reply-To: <9003662.GMTnJkJbn3@avalon>

--x1cIc4ll3AhQdJJj1BPmhjNMpvVvTw0J9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/12/16 11:10, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Wednesday 14 Dec 2016 10:43:18 Tomi Valkeinen wrote:
>> On 13/12/16 19:35, Laurent Pinchart wrote:
>>> On Tuesday 08 Mar 2016 17:39:44 Sebastian Reichel wrote:
>>>> This is a workaround for a hardware bug occuring
>>>> on OMAP3 with manually updated panels.
>>>
>>> Could you please explain what the bug is and how the workaround opera=
tes ?
>>> Do you have a reference to an errata document ?
>>
>> I don't think I ever found out exactly why the problem happens. But on=

>> OMAP3 DSI, the fifo thresholds had to be tuned slightly, otherwise DIS=
PC
>> would stop. dispc_ovl_compute_fifo_thresholds() does that tuning if
>> "manual_update" parameter is set on OMAP3.
>=20
> I've had a look at dispc_ovl_compute_fifo_thresholds() and the patch ma=
kes=20
> sense to me. If Sebastian could address the small issues I pointed out,=
 we=20
> could then merge this. Alternatively I can take care of addressing them=
=2E

It's only needed with the rest of the DSI manual update series, so I'd
rather keep it as part of that series.

 Tomi


--x1cIc4ll3AhQdJJj1BPmhjNMpvVvTw0J9--

--keDLla7SkA8wOlDeDGeQcMRFECifriQ4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUQ14AAoJEPo9qoy8lh71ZHIP/0xj0fKvVGxqsBJAyizlHSRO
RWlNbGahcj8+xRb84b4mwihbEyXTMgditTrc673L3G2AVACrJYRQRgwHcnx3gp8E
Tj8q0PBtRLPK3GaeWU/8sp9AhvTSgd0EdZNlWlmMw26dpy1YFStke+ql5Dx5V1aQ
dHl4PkTYyiXj0UPknI9r7ZEnjtMNYaU2/QJ4S+MMJgh/4cydkb5kU7HWCwTxa3S6
jdUfpr6owjvX6T03qWvo6AyKatM6e8IIE4fC261bK4F8CXP417qs6hGLxbRDIYxm
oKWDSYfpsp7K+wc84qtIXvcnCpGSTZUk/tTtpy7Be6f/x3/JgMKvCi658KQEAFBk
TY9t2lfL4r9BwJP8PCjePaZWR5uaizjlIEu02MXZk4fIGTTQg7ISOK0vtjfkCRWJ
CdpAhpfdrm3jjDkpPnXARR7BXkLDr/BUSCYYHuA++C7hKRw7Ce7ltPqaO5NFo0FA
wTx44vZnUd6Fo6D8PmZV8fRYqBqlZ21ucAcpQscrlErH5zPN4BXbEnX5ME1Nig69
pyJOQG4qRwPOpV2d5ttimYCH7OuoizHafH/++WMPhqHMMcOoUh+Iv2yEM3S+T+U8
RR2CysKzslKzv0aZhdL7oAxtSz2nbEH1JkZgW5vWGFD+DedDu9MhcZJCZMVTuhyj
pkAMnwpfxCZBdWnLUfVG
=YQo7
-----END PGP SIGNATURE-----

--keDLla7SkA8wOlDeDGeQcMRFECifriQ4h--
