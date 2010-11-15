From: "Nilofer, Samreen" <samreen@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: OMAPFB: Fix null pointer check
Date: Mon, 15 Nov 2010 18:15:11 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034C101C7D@dbde02.ent.ti.com>
References: <1289562435-8056-1-git-send-email-samreen@ti.com>
 <AANLkTik2WToLpQCK7zM+4xwwnbxY_PbRnZF-H40iYhuW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59242 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334Ab0KOMpU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 07:45:20 -0500
In-Reply-To: <AANLkTik2WToLpQCK7zM+4xwwnbxY_PbRnZF-H40iYhuW@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Belisko Marek wrote:
> On Fri, Nov 12, 2010 at 12:47 PM, Samreen <samreen@ti.com> wrote:
>> A null pointer check added.
>>=20
>> Signed-off-by: Samreen <samreen@ti.com>
>> ---
>> =A0drivers/video/omap2/omapfb/omapfb-main.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
>> b/drivers/video/omap2/omapfb/omapfb-main.c
>> index 6a704f1..55bed89 100644
>> --- a/drivers/video/omap2/omapfb/omapfb-main.c
>> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
>> @@ -2133,6 +2133,8 @@ static int omapfb_parse_def_modes(struct
>> omapfb2_device *fbdev) =A0 =A0 =A0 =A0int r =3D 0;
>>=20
>> =A0 =A0 =A0 =A0str =3D kmalloc(strlen(def_mode) + 1, GFP_KERNEL); + =
=A0 =A0 =A0 if (str =3D=3D
>> NULL) + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> Shouldn't be rerutn _ENNOMEM; instead to get correct error code?
[Samreen]
   Will fix this.
>> =A0 =A0 =A0 =A0strcpy(str, def_mode);
>> =A0 =A0 =A0 =A0options =3D str;
>>=20
>> --
>> 1.5.6.3
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at =A0http://vger.kernel.org/majordomo-info.html
>>=20
> thank,
>=20
> marek--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
