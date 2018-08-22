From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] drm: omapdrm: displays: fix port_num for opa362 output
Date: Wed, 22 Aug 2018 09:46:30 +0200
Message-ID: <A1123AD2-C238-4F19-8AF7-3FB8F60BF62D@goldelico.com>
References: <dccf0cafc194743cd037513ef19e889fb880892d.1532701471.git.hns@goldelico.com> <6854891.0j5LuaEH9O@avalon>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6854891.0j5LuaEH9O@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

Hi Laurent,

> Am 19.08.2018 um 16:07 schrieb Laurent Pinchart =
<laurent.pinchart@ideasonboard.com>:
>=20
> Hi Nikolaus,
>=20
> Thank you for the patch.
>=20
> On Friday, 27 July 2018 17:24:32 EEST H. Nikolaus Schaller wrote:
>> The opa362 amplifier has two ports, an input (usually connected
>> to the OMAP3 VENC) and an output port connected to the external
>> connector.
>>=20
>> These are usually defined as input port@0 and outpt port@1 in
>> the DT and really distinguished by the reg =3D <port_num> property
>> of these nodes.
>>=20
>> But we are missing to define the output port as number 1 so
>> it does not match the DT entry.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>=20
> I think this patch is superseded by "[PATCH v3 36/61] drm/omap: dss: =
Replace=20
> omap_dss_device port number with bitmask"

looks good and from cursory review it seems to resolve the opa362
bug as a side-effect. Maybe this can be noted in the commit description.

What I am not sure how this magically defines the output as
reg=3D<1> or if we have to swap reg number definitions in the DT.
But encoder-tfp410.c and encoder-tpd12s015.c seem to do it the
same way, so it is very likely that it works as defined.

> which should get merged in v4.20.

Well, I had hoped our bug fix makes it into v4.19 and can be
potentially backported to stable.

Do you plan to backport you patch? It seems to be quite independent
and should apply to older releases.

BR,
Nikolaus
