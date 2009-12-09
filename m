From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 1/6] OMAP4: Fix cpu detection
Date: Wed, 9 Dec 2009 13:53:57 -0600
Message-ID: <782515bb0912091153j78f4fc4am51858c0f680198ad@mail.gmail.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
	 <782515bb0912091130r2fabec47v5c48057592edb070@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A826E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:43171 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757308AbZLITxu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 14:53:50 -0500
Received: by pwj9 with SMTP id 9so2581822pwj.21
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 11:53:57 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A826E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

On Wed, Dec 9, 2009 at 1:50 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> Thanks Nishant !!
>
>> > + =A0 =A0 =A0 if ((hawkeye =3D=3D 0xb852) && (rev =3D=3D 0x0)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP4430_REV_ES1_0=
;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("OMAP%04x %s\n", omap_rev() =
>> 16, rev_name);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 printk(KERN_ERR "Unknown OMAP CPU id\n");
>> a) Do you want to state unknown OMAP4 CPU id?
>> b) why not use pr_err?
> OK
>
>> > @@ -280,7 +280,7 @@ void __init omap2_set_globals_343x(void)
>> > =A0#if defined(CONFIG_ARCH_OMAP4)
>> > =A0static struct omap_globals omap4_globals =3D {
>> > =A0 =A0 =A0 =A0.class =A0=3D OMAP443X_CLASS,
>> > - =A0 =A0 =A0 .tap =A0 =A0=3D OMAP2_L4_IO_ADDRESS(0x4830a000),
>> > + =A0 =A0 =A0 .tap =A0 =A0=3D OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BAS=
E),
>>
>> What does this have to do with the subject of the patch? I agree it =
is
>> a good thing to have, but probably belongs elsewhere.
> This is everything to do with subject. ID_CODE reg is in SCM and you
> Need a right base to read that reg, Isn't it ?

Gotcha.. thanks, could be an info useful in your rev2 commit message.

>>
>> > =A0 =A0 =A0 =A0.ctrl =A0 =3D OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BAS=
E),
>> > =A0 =A0 =A0 =A0.prm =A0 =A0=3D OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BA=
SE),
>> > =A0 =A0 =A0 =A0.cm =A0 =A0 =3D OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BAS=
E),
>> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat=
-omap/include/plat/cpu.h
>> > index 2e17890..2a141ba 100644
>> > --- a/arch/arm/plat-omap/include/plat/cpu.h
>> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
>> > @@ -443,7 +443,8 @@ IS_OMAP_TYPE(3517, 0x3517)
>> > =A0#define OMAP3505_REV(v) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP35X=
X_CLASS | (0x3505 << 16) | (v << 12))
>> > =A0#define OMAP3517_REV(v) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(OMAP35X=
X_CLASS | (0x3517 << 16) | (v << 12))
>> >
>> > -#define OMAP443X_CLASS =A0 =A0 =A0 =A0 0x44300034
>> > +#define OMAP443X_CLASS =A0 =A0 =A0 =A0 0x44300044
>> > +#define OMAP4430_REV_ES1_0 =A0 =A0 0x44300044
>> Errr.. why? I suspect this might be to get the class and subclass ri=
ght..
>>
>> Dont we need an cpu_is_omap_4430() to use it correctly? (unless I
>> missed a pending patch series as I am checking l-o kernel codebase).=
=2E
>> do we need the following?
>> IS_OMAP_CLASS(44xx, 0x44)
>> IS_OMAP_SUBCLASS(443x, 0x443)
>>
>> then you will have is_omap_443x() and you can now:
>> #define cpu_is_omap4430 is_omap443x()
> This has to be done and I planning to do this in next series. This se=
ries just
> enables the basic boot on ES1.0.

not sure, but might be good to do this in this patch as the CLASS and
ES1 value change dont make much sense without it.. it should not
change your basic boot behavior.

>
> Regards,
> Santosh
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
