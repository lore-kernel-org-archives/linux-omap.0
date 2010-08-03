From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: RE: [PATCH 5/5] staging:ti dspbridge: replace simple_strtoul by
 	strict_strtoul
Date: Tue, 3 Aug 2010 12:33:51 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060094D17A30@dlee01.ent.ti.com>
References: <1280328052-31292-1-git-send-email-ernesto@ti.com>
	<1280328052-31292-2-git-send-email-ernesto@ti.com>
	<1280328052-31292-3-git-send-email-ernesto@ti.com>
	<1280328052-31292-4-git-send-email-ernesto@ti.com>
	<1280328052-31292-5-git-send-email-ernesto@ti.com>
	<1280328052-31292-6-git-send-email-ernesto@ti.com>
 <AANLkTin-2_JC0-18QWAdo9r36Jx0QdnDwnB2+2AdePyc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTin-2_JC0-18QWAdo9r36Jx0QdnDwnB2+2AdePyc@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "ohad@wizery.com" <ohad@wizery.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

>-----Original Message-----
>From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>Sent: Wednesday, July 28, 2010 1:44 PM
>To: Ramos Falcon, Ernesto
>Cc: gregkh@suse.de; Ramirez Luna, Omar; ohad@wizery.com;
>ameya.palande@nokia.com; felipe.contreras@nokia.com; Guzman Lugo, Fern=
ando;
>linux-kernel@vger.kernel.org; Menon, Nishanth; linux-omap@vger.kernel.=
org
>Subject: Re: [PATCH 5/5] staging:ti dspbridge: replace simple_strtoul =
by
>strict_strtoul
>
>On Wed, Jul 28, 2010 at 5:40 PM, Ernesto Ramos <ernesto@ti.com> wrote:
>> Replace simple_strtoul by strict_strtoul in atoi function.
>In general the question what is the purpose here to do the change?
>

It is recommended to use strict_strtoul instead of simple_strtoul since=
 ensures the string is really a valid unsigned long. This also removes =
checkpatch warning message.

>> @@ -1023,7 +1025,9 @@ static s32 atoi(char *psz_buf)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0base =3D 16;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 return simple_strtoul(pch, NULL, base);
>> + =A0 =A0 =A0 ret_val =3D strict_strtoul(pch, base, &res);
>> +
>> + =A0 =A0 =A0 return ret_val ? : res;
>May be better to use explicit values in condition?
>

I think this is ok as it is, I'm not sure but I think it maybe defined =
in any C ansi book, in this case if ret_val is unequal to 0 ret_val is =
returned.

>--
>With Best Regards,
>Andy Shevchenko
