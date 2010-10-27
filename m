From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/5] omap: mailbox: fix detection for previously supported chips
Date: Wed, 27 Oct 2010 10:28:06 +0300
Message-ID: <AANLkTimvapU3w6BzM4MLawEjkohAT+yOrg6kdGj8fLkg@mail.gmail.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
	<1288129984-22957-5-git-send-email-omar.ramirez@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D3105B2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49929 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab0J0H2I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 03:28:08 -0400
Received: by fxm16 with SMTP id 16so397238fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Oct 2010 00:28:06 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D3105B2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 27, 2010 at 8:06 AM, Varadarajan, Charulatha <charu@ti.com>=
 wrote:
>> Fix the mailbox detection for OMAP3630 and 2430, also minor
>> cleanup on conditional ifdef's that could affect it.
>>
>> Given that 2430 has an iva too include it, as the same steps
>> for omap3 apply.
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/mailbox.c | =C2=A0 16 ++++++++++------
>> =C2=A01 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mailbox.c
>> b/arch/arm/mach-omap2/mailbox.c
>> index 61f2149..b8fd120 100644
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -277,7 +277,7 @@ static struct omap_mbox_ops omap2_mbox_ops =3D {
>>
>> =C2=A0/* FIXME: the following structs should be filled
>> automatically by the user id */
>>
>> -#if defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_ARCH_OMAP2420)
>> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP2)
>> =C2=A0/* DSP */
>> =C2=A0static struct omap_mbox2_priv omap2_mbox_dsp_priv =3D {
>> =C2=A0 =C2=A0 =C2=A0 .tx_fifo =3D {
>> @@ -302,7 +302,7 @@ struct omap_mbox mbox_dsp_info =3D {
>> =C2=A0};
>> =C2=A0#endif
>>
>> -#if defined(CONFIG_ARCH_OMAP3430)
>> +#if defined(CONFIG_ARCH_OMAP3)
>> =C2=A0struct omap_mbox *omap3_mboxes[] =3D { &mbox_dsp_info, NULL };
>> =C2=A0#endif
>>
>> @@ -390,15 +390,19 @@ static int __devinit
>> omap2_mbox_probe(struct platform_device *pdev)
>>
>> =C2=A0 =C2=A0 =C2=A0 if (false)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;
>> -#if defined(CONFIG_ARCH_OMAP3430)
>> - =C2=A0 =C2=A0 else if (cpu_is_omap3430()) {
>> +#if defined(CONFIG_ARCH_OMAP3)
>> + =C2=A0 =C2=A0 else if (cpu_is_omap34xx()) {
>
> Use cpu_is_* check only. No need to have #if CONFIG_ARCH_* checks.

Some people conditionally compile only for one architecture, like in
consumer devices. There's no point in wasting space for that.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
