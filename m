From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 1/7] OMAP2: hwmod data: add mailbox data
Date: Sun, 7 Nov 2010 08:27:47 -0600
Message-ID: <AANLkTi=wx-Nr7S1iWK2K__XZtEmE2pKNkejtFbsae+X5@mail.gmail.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
	<1289006244-27147-2-git-send-email-omar.ramirez@ti.com>
	<4CD58BAA.8020909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58198 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752941Ab0KGO1s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Nov 2010 09:27:48 -0500
Received: by iwn41 with SMTP id 41so2915793iwn.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 06:27:47 -0800 (PST)
In-Reply-To: <4CD58BAA.8020909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

 Hi Benoit,

On Sat, Nov 6, 2010 at 12:08 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
>> +/* l4_core -> =A0mailbox */
>> +static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox =3D {
>> + =A0 =A0 =A0 .master =A0 =A0 =A0 =A0 =3D&omap2420_l4_core_hwmod,
>> + =A0 =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D&omap2420_mailbox_hwmod,
>> + =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap2420_mailbox_addrs,
>> + =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "mailboxes_ick",
>
> Could you try to be consistent with the omap4 format? it is easier to=
 diff
> between Soc version: .clk is before .addr

In all the randomness of how the data files look, I didn't now omap4
was the standard. For this one, I tried to follow the
"omap_hwmod_ocp_if" structure definition where 'clk' is the 4th member
of that structure.

I'll change it to mimic omap4 looks...

>> +static struct omap_hwmod omap2420_mailbox_hwmod =3D {
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mailbox",
>> + =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap2420_mailbox_hwmod_c=
lass,
>> + =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP24=
XX_EN_MAILBOXES_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_=
MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .idlest_idle_bit =3D O=
MAP24XX_ST_MAILBOXES_SHIFT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 =A0 },
>
> Same things with the format, put that after irqs_cnt and before slave=
s.

more or less the same, since 'prcm' was above in the definition order
I kept it a bit up of where it is supposed to be.

I'll change it too

>> @@ -569,6 +635,7 @@ static __initdata struct omap_hwmod *omap2420_hw=
mods[]
>> =3D {
>> =A0 =A0 =A0 =A0&omap2420_uart3_hwmod,
>> =A0 =A0 =A0 =A0&omap2420_i2c1_hwmod,
>> =A0 =A0 =A0 =A0&omap2420_i2c2_hwmod,
>
> Add a blank line between each class. OK it was not done for i2c, but =
it
> should.
>
> All the comments are applicable to the 2430 and 3430 data as well.

Will do.

Thanks for your comments,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
