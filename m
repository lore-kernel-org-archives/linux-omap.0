From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 3/7] OMAP4: hwmod data: add mailbox data
Date: Sun, 7 Nov 2010 09:07:45 -0600
Message-ID: <AANLkTi=mkBROke+4Yf25QndYB=0pE+k0tE2NKxUM5xU_@mail.gmail.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
	<1289006244-27147-4-git-send-email-omar.ramirez@ti.com>
	<4CD58DF6.6040600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47438 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938Ab0KGPHs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Nov 2010 10:07:48 -0500
Received: by mail-iw0-f180.google.com with SMTP id 37so4651219iwn.39
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 07:07:46 -0800 (PST)
In-Reply-To: <4CD58DF6.6040600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Nov 6, 2010 at 12:18 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> I don't know why, but this patch has nothing to do with my original o=
ne.
> Can you stick to the original code?

no, apart from the ordering of structure members, that I will change,
since keeping the order of the original structure doesn't fly, I don't
see anything that needs to be changed.

- The magic numbers replaced for the defines, afaik it gives more clari=
ty.
- mailbox irq has a name.
- overall defining block was improved:

        class
        ocp_if
        slave ports
        hwmod

If you see, each dependent reference is right before the structure
that is using it, which at least to me establishes some order, as of
today this ordering doesn't exists.

e.g. you are defining some hwmod and some how you are populating all
the members, if you are looking at your omap_hwmod struct and want to
see the irqs defined you need to scroll beyond the supposed first
reference in omap_hwmod (right now above ocp_if)

>
> On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
>> +/* mailbox */
>
> The original comment is missing.

<quote>
/*
 * 'mailbox' class
 * mailbox module allowing communication between the on-chip processors
 * useusing a queued mailbox-interrupt mechanism.
 */
</quote>

I don't think it adds anything to the patch, should we start
commenting on the functionality of the drivers for each hwmod?

>> +
>> +static struct omap_hwmod omap44xx_mailbox_hwmod;
>> +
>> +static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] =3D {
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D OMAP44XX_MAI=
LBOX_BASE,
>
> If that physical address is not used elsewhere, and it should be the =
case,
> there is no need to create a define for it. That's why the physical a=
ddress
> was directly used here.
> There is no added value to create a define for that.

yes there is, apart from readability where '0x4a0f4000' doesn't say muc=
h

for me at least, if reviewing I need to open the TRM check if that is
the address and move on, with the define you know that someone have
checked the address before (when creating the define)

besides the define was already there

>> +static struct omap_hwmod omap44xx_mailbox_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mailbox",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap44xx_mailbox_hwmod_c=
lass,
>> + =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OMAP4=
430_CM_L4CFG_MAILBOX_CLKCTRL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_mailbox_irqs,
>> + =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_mailbox_irqs=
),
>
> The order is different than the previous one.

as the order is given by omap4 data, and not the definition of the
structure, I'll keep the consistency with omap4 then.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
