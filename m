From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/6 v2] OMAP4: Fix cpu detection
Date: Fri, 11 Dec 2009 10:37:02 -0600
Message-ID: <782515bb0912110837i732250f2m4f50246594973b67@mail.gmail.com>
References: <1260426156-1820-1-git-send-email-santosh.shilimkar@ti.com>
	 <4B2156B6.8090403@ti.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02BC1415B4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:44349 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbZLKQg5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 11:36:57 -0500
Received: by pxi4 with SMTP id 4so299420pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 08:37:04 -0800 (PST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC1415B4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

On Thu, Dec 10, 2009 at 10:43 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> >
>> > +void __init omap4_check_revision(void)
>> > +{
>> > + =A0 u32 idcode;
>> > + =A0 u16 hawkeye;
>> > + =A0 u8 rev;
>> > + =A0 char *rev_name =3D "ES1.0";
>> should'nt you decide this inside the rev check path?
>
> This is initialized value by default. Since the chip is ES1.0 additio=
naly I am not doing it.
> e.g. for ES2.0, it would be done inside. > > +
ok, no strong opinions about this, but I think it might be nice if
ES2.0 addition will modify less code.

>> > + =A0 /*
>> > + =A0 =A0* The IC rev detection is done with hawkeye and rev.
>> > + =A0 =A0* Note that rev does not map directly to defined processo=
r
>> > + =A0 =A0* revision numbers as ES1.0 uses value 0.
>> > + =A0 =A0*/
>> > + =A0 idcode =3D read_tap_reg(OMAP_TAP_IDCODE);
>> > + =A0 hawkeye =3D (idcode >> 12) & 0xffff;
>> > + =A0 rev =3D (idcode >> 28) & 0xff;
>> > +
>> > + =A0 if ((hawkeye =3D=3D 0xb852) && (rev =3D=3D 0x0)) {
>> > + =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP4430_REV_ES1_0;
>> > + =A0 =A0 =A0 =A0 =A0 pr_info("OMAP%04x %s\n", omap_rev() >> 16, r=
ev_name);
>> wondering about the >>16 part.
> Why ?
omap_rev() >>16 means that you are using higher word of this and I
think we have CLASS() macro for that? if that is not enough, should'nt
we add adequate macro to do that?

[...]

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
