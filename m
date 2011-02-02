From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v2] OMAP: fix fncpy API call
Date: Wed, 2 Feb 2011 15:48:44 +0100
Message-ID: <AANLkTimStM4TJhT9X460o3wOA-SPJrTV3Q87ZBDOPBT2@mail.gmail.com>
References: <1295977686-22765-1-git-send-email-j-pihet@ti.com>
	<AANLkTinU5Msop=Lg7iuSfNZXa+7NQCwcrN2hB1a1T9Ds@mail.gmail.com>
	<20110202000116.GM3358@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:39917 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab1BBOsp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 09:48:45 -0500
Received: by qyj19 with SMTP id 19so6150992qyj.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Feb 2011 06:48:44 -0800 (PST)
In-Reply-To: <20110202000116.GM3358@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Wed, Feb 2, 2011 at 1:01 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Dave Martin <dave.martin@linaro.org> [110201 08:34]:
>> On Tue, Jan 25, 2011 at 5:48 PM, =A0<jean.pihet@newoldbits.com> wrot=
e:
>> > From: Jean Pihet <j-pihet@ti.com>
>> >
>> > Fix a potential problem with function types when calling the
>> > fncpy API to copy the PM code functions to SRAM.
>> >
>> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> > ---
>> > =A0arch/arm/plat-omap/include/plat/sram.h | =A0 =A04 ++--
>> > =A01 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/pla=
t-omap/include/plat/sram.h
>> > index d673f2c..f500fc3 100644
>> > --- a/arch/arm/plat-omap/include/plat/sram.h
>> > +++ b/arch/arm/plat-omap/include/plat/sram.h
>> > @@ -18,10 +18,10 @@ extern void *omap_sram_push_address(unsigned l=
ong size);
>> >
>> > =A0/* Macro to push a function to the internal SRAM, using the fnc=
py API */
>> > =A0#define omap_sram_push(funcp, size) ({ =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
>> > - =A0 =A0 =A0 typeof(&funcp) _res =3D NULL; =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> > + =A0 =A0 =A0 typeof(&(funcp)) _res =3D NULL; =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> > =A0 =A0 =A0 =A0void *_sram_address =3D omap_sram_push_address(size=
); =A0 =A0 \
>> > =A0 =A0 =A0 =A0if (_sram_address) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 _res =3D fncpy(_sram_address, &funcp=
, size); =A0 =A0 =A0\
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _res =3D fncpy(_sram_address, &(func=
p), size); =A0 =A0\
>> > =A0 =A0 =A0 =A0_res; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> > =A0})
>>
>> I believe this is sound, though I'm not yet in a position to test it=
 fully.
>>
>> When I have the OMAP kernel building with Thumb-2 again I will follo=
w up.
>>
>> Cheers
>> ---Dave
>>
>>
>> Reviewed-by: Dave Martin <dave.martin@linaro.org>
>
> Looks good to me too:
>
> Acked-by: Tony Lindgren <tony@atomide.com>
Ok thanks!

>
> I'll add this to omap-testing branch, but as Russell has this queued,
> you'll have to send this to him on linux-arm-kernel list.
I have folded the 2 original patches code and acks into '[PATCH] omap:
use fncpy to copy the PM code functions to SRAM' and re-sent to l-a-k
and l-o MLs.

Also submitted to Russell's patch system.

>
> Regards,
>
> Tony
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
