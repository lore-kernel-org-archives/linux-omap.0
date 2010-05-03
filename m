From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 5/8] omap: mailbox: reorganize omap2 platform_device
Date: Mon, 3 May 2010 21:14:09 +0300
Message-ID: <h2t94a0d4531005031114u19241bb4ia814e31bdb31cbd4@mail.gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
	 <1272844967-25441-1-git-send-email-felipe.contreras@gmail.com>
	 <20100503181048.GW29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:36998 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954Ab0ECSOL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 14:14:11 -0400
Received: by ey-out-2122.google.com with SMTP id d26so155771eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 11:14:10 -0700 (PDT)
In-Reply-To: <20100503181048.GW29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Mon, May 3, 2010 at 9:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Felipe Contreras <felipe.contreras@gmail.com> [100502 16:58]:
>> Makes more sense to register in the mach file, plus it will allow mo=
re
>> functionality later on.
>>
>> Also, this probably enables multi-omap for real.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> <snip>
>
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>
> You still probably want to optimize kernel size and memory
> consumption for production kernels built for one omap:
>
> #ifdef CONFIG_ARCH_OMAP2

True.

>> +static struct resource omap2_mbox_resources[] =3D {
>> + =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D OMAP24XX_MAILBOX_BASE,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .end =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D IORESOURCE_MEM,
>> + =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D INT_24XX_MAIL_U0_MPU,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D IORESOURCE_IRQ,
>> + =C2=A0 =C2=A0 },
>> + =C2=A0 =C2=A0 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .start =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D INT_24XX_MAIL_U3_MPU,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D IORESOURCE_IRQ,
>> + =C2=A0 =C2=A0 },
>> +};
>
> #else
> #define omap2_mbox_resources =C2=A0 =C2=A0NULL
> #endif
>
> And then do the same for omap3 and omap4.
>
> BTW, looks like this could all be also set __initdata?

Yeah, I think so.

>> @@ -443,7 +479,46 @@ static struct platform_driver omap2_mbox_driver=
 =3D {
>>
>> =C2=A0static int __init omap2_mbox_init(void)
>> =C2=A0{
>> + =C2=A0 =C2=A0 int err;
>> + =C2=A0 =C2=A0 struct platform_device *pdev;
>> + =C2=A0 =C2=A0 struct resource *res;
>> + =C2=A0 =C2=A0 unsigned num;
>> +
>> + =C2=A0 =C2=A0 if (cpu_is_omap3430()) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D omap3_mbox_resou=
rces;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num =3D ARRAY_SIZE(omap3=
_mbox_resources);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 else if (cpu_is_omap2420()) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D omap2_mbox_resou=
rces;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num =3D ARRAY_SIZE(omap2=
_mbox_resources);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 else if (cpu_is_omap44xx()) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D omap4_mbox_resou=
rces;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num =3D ARRAY_SIZE(omap4=
_mbox_resources);
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("%s: platform not=
 supported\n", __func__);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> + =C2=A0 =C2=A0 }
>
> Note that these tests will fail when building for one omap only
> unless you have the #else statement for eacch omapX_mbox_resources[].

Indeed. I'll fix that although the current code is already wrong.

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
