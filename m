From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] staging: ti dspbridge: fix compilation error
Date: Sat, 10 Jul 2010 02:37:26 +0300
Message-ID: <AANLkTinL95vKeDgceG-CbyjjrMlVZkoIkP3qsDJBHN1w@mail.gmail.com>
References: <1278715732-21167-1-git-send-email-rene.sapiens@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278715732-21167-1-git-send-email-rene.sapiens@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Sapiens <rene.sapiens@ti.com>
Cc: greg@kroah.com, gregkh@suse.de, omar.ramirez@ti.com, ohad@wizery.com, ameya.palande@nokia.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jul 10, 2010 at 1:48 AM, Rene Sapiens <rene.sapiens@ti.com> wro=
te:
> This patch fix a compilation error in uuid_hex_to_bin
> due to the patch "simplify and clean up"
>
> Signed-off-by: Rene Sapiens <rene.sapiens@ti.com>
Oh, previous version of patch was sent. Thanks for fix.

ACK.

> ---
> =C2=A0drivers/staging/tidspbridge/gen/uuidutil.c | =C2=A0 =C2=A01 +
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
> =C2=A0mode change 100644 =3D> 100755 drivers/staging/tidspbridge/gen/=
uuidutil.c
>
> diff --git a/drivers/staging/tidspbridge/gen/uuidutil.c b/drivers/sta=
ging/tidspbridge/gen/uuidutil.c
> index eb09bc3..070761b
> --- a/drivers/staging/tidspbridge/gen/uuidutil.c
> +++ b/drivers/staging/tidspbridge/gen/uuidutil.c
> @@ -58,6 +58,7 @@ static s32 uuid_hex_to_bin(char *buf, s32 len)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0s32 i;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0s32 result =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int value;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < len; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D hex_=
to_bin(*buf++);
> --
> 1.6.3.3
>
>



--=20
With Best Regards,
Andy Shevchenko
