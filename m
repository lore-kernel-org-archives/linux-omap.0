From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
Date: Sun, 27 Mar 2011 20:49:48 -0500
Message-ID: <AANLkTikcV_NSYz+zSRRMA=dQMxB7AS1tKsau95mxbCka@mail.gmail.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
	<4D8E5CD3.8010007@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:55382 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752569Ab1C1Btt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Mar 2011 21:49:49 -0400
Received: by mail-ww0-f52.google.com with SMTP id 15so2378480wwe.21
        for <linux-omap@vger.kernel.org>; Sun, 27 Mar 2011 18:49:48 -0700 (PDT)
In-Reply-To: <4D8E5CD3.8010007@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

On Sat, Mar 26, 2011 at 4:38 PM, Sergei Shtylyov <sshtylyov@mvista.com>=
 wrote:
> Hello.
>
> On 26-03-2011 3:29, Omar Ramirez Luna wrote:
>
>> If an error occurs in the L3 on any other initiator than MPU,
>> the interrupt goes unhandled given that the 'base' register
>> was calculated with the initialized err_base value (which
>> coincidentally points to MPU) and not with the actual source
>> of the error.
>
>> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_l3_smx.c | =A0 =A05 +++--
>> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
>> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c
>> b/arch/arm/mach-omap2/omap_l3_smx.c
>> index 5f2da75..da917c2 100644
>> --- a/arch/arm/mach-omap2/omap_l3_smx.c
>> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
>> @@ -196,11 +196,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, v=
oid
>> *_l3)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* No timeout error for debug sources=
 */
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 base =3D ((l3->rt) + (*(omap3_l3_bases[int_type] + err=
_source)));
>> -
>> =A0 =A0 =A0 =A0/* identify the error source */
>> =A0 =A0 =A0 =A0for (err_source =3D 0; !(status& =A0(1<< =A0err_sourc=
e)); err_source++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0;
>> +
>> + =A0 =A0 =A0 base =3D ((l3->rt) + (*(omap3_l3_bases[int_type] + err=
_source)));
>> +
>
> =A0 What's the point of having () around rvalue? You could drop them,=
 while at
> it...

You're right, will do.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
