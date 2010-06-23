From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 06/11] staging: ti dspbridge: add generic utilities
Date: Wed, 23 Jun 2010 18:43:31 +0300
Message-ID: <AANLkTinNSUXZkFhEhf5nRzlNGDkm_-OsOGtqfgs32717@mail.gmail.com>
References: <1277298125-17991-1-git-send-email-ohad@wizery.com>
	<1277298125-17991-7-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277298125-17991-7-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Hebbar Shivananda <x0hebbar@ti.com>, Ramos Falcon Ernesto <ernesto@ti.com>, Anna Suman <s-anna@ti.com>, Kanigeri Hari <h-kanigeri2@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Felipe Balbi <felipe.balbi@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Gupta Ramesh <grgupta@ti.com>, Guzman Lugo Fernando <fernando.lugo@ti.com>, Tony Lindgren <tony@atomide.com>, Ameya Palande <ameya.palande@nokia.com>, Gomez Castellanos Ivan <ivan.gomez@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Armando Uribe De Leon <x0095078@ti.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Menon Nishanth <nm@ti.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Pitney Gilbert <gpitney@ti.com>, Bhavin Shah <bshah@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 23, 2010 at 4:02 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Add TI's DSP Bridge generic utilities driver sources
> Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>


> +++ b/drivers/staging/tidspbridge/gen/uuidutil.c

=46ollowing part could be significantly simplified

> +/*
> + * =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D htoi =3D=3D=3D=3D=3D=3D=3D=3D
> + * =C2=A0Purpose:
> + * =C2=A0 =C2=A0 =C2=A0Converts a hex value to a decimal integer.
> + */

> +/*
> + * =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D uuid_uuid_from_string =3D=3D=3D=3D=
=3D=3D=3D=3D
> + * =C2=A0Purpose:
> + * =C2=A0 =C2=A0 =C2=A0Converts a string to a struct dsp_uuid.
> + */


There is a code (because I am already in s-o-b list I just put here
the excerpts, however, I could prepare patch in standard form, if you
want to)

static s32 uuid_hex_to_bin(char *buf, s32 len)
{
        s32 i;
        s32 result =3D 0;

        for (i =3D 0; i < len; i++) {
                value =3D hex_to_bin(*buf++);
                result *=3D 16;
                if (value > 0)
                        result +=3D value;
        }

        return result;
}

void uuid_uuid_from_string(IN char *pszUuid, OUT struct dsp_uuid *uuid_=
obj)
{
        s32 j;

        uuid_obj->ul_data1 =3D uuid_hex_to_bin(pszUuid, 8);
        pszUuid +=3D 8;

        /* Step over underscore */
        pszUuid++;

        uuid_obj->us_data2 =3D (u16) uuid_hex_to_bin(pszUuid, 4);
        pszUuid +=3D 4;

        /* Step over underscore */
        pszUuid++;

        uuid_obj->us_data3 =3D (u16) uuid_hex_to_bin(pszUuid, 4);
        pszUuid +=3D 4;

        /* Step over underscore */
        pszUuid++;

        uuid_obj->uc_data4 =3D (u8) uuid_hex_to_bin(pszUuid, 2);
        pszUuid +=3D 2;

        uuid_obj->uc_data5 =3D (u8) uuid_hex_to_bin(pszUuid, 2);
        pszUuid +=3D 2;

        /* Step over underscore */
        pszUuid++;

        for (j =3D 0; j < 6; j++) {
                uuid_obj->uc_data6[j] =3D (u8) uuid_hex_to_bin(pszUuid,=
 2);
                pszUuid +=3D 2;
        }
}



--=20
With Best Regards,
Andy Shevchenko
