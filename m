From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv4 6/14] OMAP4: dmtimer: add hwmod database
Date: Mon, 22 Nov 2010 11:41:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0372E3FF34@dbde02.ent.ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <AANLkTikvUzdo9XN-WxoLoyimDi+j6wwTh+T9veF7_H9P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55814 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab0KVGMB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 01:12:01 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAM6Bw1x005312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 00:12:00 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAM6BvSF008514
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 11:41:57 +0530 (IST)
In-Reply-To: <AANLkTikvUzdo9XN-WxoLoyimDi+j6wwTh+T9veF7_H9P@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Monday, November 22, 2010 11:32 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit
> Subject: Re: [PATCHv4 6/14] OMAP4: dmtimer: add hwmod database
>=20
> These comments are from other hwmod reviews.
>=20
> On Sat, Nov 20, 2010 at 08:09, Tarun Kanti DebBarma <tarun.kanti@ti.c=
om>
> wrote:
> > From: Cousson, Benoit <b-cousson@ti.com>
>=20
> Subject should be something like: ( See [1] )
> OMAP4: hwmod data: add dmtimer
>=20
> Same is applicable to other hwmod DB patches for OMAP2420, OMAP2430
> & OMAP3 to add dmtimer data
Ok.

>=20
> >
> > Add hwmod database for OMAP4.
> >
> > Signed-off-by: Cousson, Benoit <b-cousson@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0622
> ++++++++++++++++++++++++++++
>=20
> <<snip>>
>=20
> > + =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
> > +};
> > +
> > +/*
> > =A0* 'wd_timer' class
> > =A0* 32-bit watchdog upward counter that generates a pulse on the r=
eset
> pin on
> > =A0* overflow condition
> > @@ -1068,6 +1678,18 @@ static __initdata struct omap_hwmod
> *omap44xx_hwmods[] =3D {
> >
> > =A0 =A0 =A0 =A0/* mpu class */
> > =A0 =A0 =A0 =A0&omap44xx_mpu_hwmod,
> > + =A0 =A0 =A0 /* timer class */
> > + =A0 =A0 =A0 &omap44xx_timer1_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer2_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer3_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer4_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer5_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer6_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer7_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer8_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer9_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer10_hwmod,
> > + =A0 =A0 =A0 &omap44xx_timer11_hwmod,
>=20
> Add a blank line between each class. See [2]
> Same is applicable to other hwmod DB patches for OMAP2420, OMAP2430
> & OMAP3 to add dmtimer data
Hmm... this is really funny! In fact in earlier patches I gave a blank =
line.
This time I saw other implementations which does not have blank lines l=
ike these and thought that I should remove the blank line:
        /* dmm class */
        &omap44xx_dmm_hwmod,
        /* emif_fw class */
        &omap44xx_emif_fw_hwmod,
        /* l3 class */
        &omap44xx_l3_instr_hwmod,
        &omap44xx_l3_main_1_hwmod,
        &omap44xx_l3_main_2_hwmod,
        &omap44xx_l3_main_3_hwmod,
        /* l4 class */
        &omap44xx_l4_abe_hwmod,
        &omap44xx_l4_cfg_hwmod,
        &omap44xx_l4_per_hwmod,
        &omap44xx_l4_wkup_hwmod,
Well, I can add blank lines with the hope that someone does not ask me =
to remove them again ;)
--
Tarun

>=20
> [1] https://patchwork.kernel.org/patch/282472/
> [2] https://patchwork.kernel.org/patch/308422/
>=20
> > =A0 =A0 =A0 =A0/* wd_timer class */
> > =A0 =A0 =A0 =A0&omap44xx_wd_timer2_hwmod,
> > =A0 =A0 =A0 =A0&omap44xx_wd_timer3_hwmod,
> > --
> > 1.6.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
