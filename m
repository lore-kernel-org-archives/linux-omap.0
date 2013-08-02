From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: dss-common: fix Panda's DVI DDC channel
Date: Fri, 2 Aug 2013 16:00:20 +0300
Message-ID: <51FBAD64.5090600@ti.com>
References: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com> <1374570405-8301-2-git-send-email-tomi.valkeinen@ti.com> <51FBAC21.2040609@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lltjpSplSCVKqBnQ5hTSV8NhpPOXEgAXK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59040 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab3HBNAo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 09:00:44 -0400
In-Reply-To: <51FBAC21.2040609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--lltjpSplSCVKqBnQ5hTSV8NhpPOXEgAXK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/08/13 15:54, Nishanth Menon wrote:
> On 07/23/2013 04:06 AM, Tomi Valkeinen wrote:
>> Panda's DVI connector's DDC pins are connected to OMAP's third i2c bus=
=2E
>> With non-DT, the bus number was 3, and that is what is used in the
>> dss-common.c which contains the platform data for Panda's DVI.
>>
>> However, with DT, the bus number is 2. As we now only have DT boot for=

>> Panda, we have to change the bus number to make DVI EDID read
>> operational.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>   arch/arm/mach-omap2/dss-common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-omap2/dss-common.c
>> b/arch/arm/mach-omap2/dss-common.c
>> index 393aeef..043e570 100644
>> --- a/arch/arm/mach-omap2/dss-common.c
>> +++ b/arch/arm/mach-omap2/dss-common.c
>> @@ -42,7 +42,7 @@
>>
>>   /* Using generic display panel */
>>   static struct tfp410_platform_data omap4_dvi_panel =3D {
>> -    .i2c_bus_num        =3D 3,
>> +    .i2c_bus_num        =3D 2,
>>       .power_down_gpio    =3D PANDA_DVI_TFP410_POWER_DOWN_GPIO,
>>   };
>>
>>
> completely dumb question :) :
> why cant we have dts support for this instead of having to renumber
> every time?

What do you mean "every time"?

Feel free to help me develop the DT support for DSS =3D). When that's
done, we can remove all this code.

> Example: if -EPROBEDEFER is incurred due to some unexpected dependency,=

> we'd have to redo the numbering in the kernel yet again.

Hmm, sorry? Do you mean that the i2c bus numbers can change "randomly"?

With board files they were numbered 1, 2, 3, 4, but with DT boot they
seem to be 0, 1, 2, 3. And as we have the current situation where omap4
boots with DT, but DSS does not have DT support, we add the DSS related
devices in a board-file-like-fashion.

 Tomi



--lltjpSplSCVKqBnQ5hTSV8NhpPOXEgAXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR+61kAAoJEPo9qoy8lh71XycQAIbTDm0XHdLiaoWi8fh47KA8
kWqxk7m/t+pYg0HmwvWAEm//Evl7WvlcAMs7u5S4aZETz7QSCIcPsik/LC0K0Z3B
vntaAAUsCS69UBypDIlT7dHLP0U0o9WCenaSpHF45XtMfsYdXfdQxp0POw6lZQPp
Oz/70FBtu36wwQLR+NwDbA2JUQyWglwRQ6MVWl67wMoI8hZYs1cSmKAOj47ybdXd
m9Co0nM/Sh4hmPnmr2gCkE5PLw4dDmpmJL6u/D7aZ0CtqLM51DzKeSMVrs85/wVg
n3JwOAAhnqKNwcR9/J6DdUOrKpFjBdhJE+5yDhQu0EY9LFRAlyPQiFWwEe6M/5Iz
aEnxR2OLQWu3DOAud8ag8TxMQDR7+2jQ54PmrdxHtUA7WUoLx4eJw3fiDx1qs/qf
jJhkOOXEpgB0AiNumAHSedk8k8O/i8WQp2khtiCeiQvu0WH1SWXLjZK41BlEROMs
KMAtFh8ZYrFbnr3h5D4WxRtdX/Xm8fLBuWDv+BFc0SlmAUpVvYvk9E50Wg8T7BCy
EY+SsCqgOVXyOfKJ1bnXmmqi4Hqt8sQKcFC2iyKL2ij2LTzQB8qT2xfdm+uuCECa
wGlyopF422GBwk0aSvgMB+XPMvz6OZvQGBLZodoUBDoCWKc6EcnUFDVSWav0Rf8v
0R07cxbRp5D5/LgB7OSF
=svrI
-----END PGP SIGNATURE-----

--lltjpSplSCVKqBnQ5hTSV8NhpPOXEgAXK--
