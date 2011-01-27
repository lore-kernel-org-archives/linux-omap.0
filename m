From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [query] smartreflex: No PMIC hook to init smartreflex
Date: Thu, 27 Jan 2011 19:55:52 +0530
Message-ID: <2dcb8dc49945099cbbc5c4f725d845a5@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302485ADDFE@dbde02.ent.ti.com> <AANLkTinq5OxHo-X1Wd2EmAwb4LPtQNs5c6=xp4GSymvJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:36854 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752961Ab1A0OdL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 09:33:11 -0500
Received: by mail-fx0-f50.google.com with SMTP id 14so2355892fxm.9
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 06:33:10 -0800 (PST)
In-Reply-To: <AANLkTinq5OxHo-X1Wd2EmAwb4LPtQNs5c6=xp4GSymvJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Nishant,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, January 27, 2011 3:06 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [query] smartreflex: No PMIC hook to init smartreflex
>
> Sanjeev,
>
> On Tue, Jan 25, 2011 at 20:55, Premi, Sanjeev <premi@ti.com> wrote:
> > While building the kernel at 2.6.37, i see this warning for omap3ev=
m -
> with omap3630:
> >
> > Power Management for TI OMAP3.
> > sr_init: No PMIC hook to init smartreflex <-- THIS IS THE WARNING.
> > smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver
> initialized
> > smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver
> initialized
> > SmartReflex Class3 initialized
> >
> > In the code, i see this comment:
> > =A0/*
> > =A0* sr_init is a late init. If by then a pmic specific API is not
> > =A0* registered either there is no need for anything to be done on
> > =A0* the PMIC side or somebody has forgotten to register a PMIC
> > =A0* handler. Warn for the second condition.
> > =A0*/
> > =A0if (sr_pmic_data && sr_pmic_data->sr_pmic_init)
> > =A0sr_pmic_data->sr_pmic_init();
> > =A0else
> > =A0pr_warning("%s: No PMIC hook to init smartreflex\n", __func__);
> >
> > But, I couldn't find any place where PMIC is being registered.
>
> This is a harmless warning (ideally, we should remove the pr_warning)=
=2E
>  the intent here is to have hook for pmic_init which could be
> populated for custom PMICs which may need "something additional" for
> Smart reflex enablement. if you look at the sr_pmic_data - it just ha=
s
> a single api for pmic_init
>
> e.g. in the case of TWL4030/5030, we might need to set the bit to
> switch mode from I2C1 to I2C_SR - e.g. the patch from Shweta[1]
>
> if Smartreflex AVS was the *only* mechanism in the system, we could
> have hooked pmic_init to this bit setting. but since the system can d=
o
> voltage scaling (VP forceupdate/vc bypass) independent of SR AVS
> block, the patch in [1] does initialization independent of
> sr_pmic_data->pmic_init which makes sense.
>
> in short, my 2cents: the warning is probably something we should
> remove from the code.
As you mentioned, incase of TWL4030/5030, we do not need any hook. Howe=
ver
if some other PMIC is used that genuinely needs this hook, then shouldn=
't
SR throw up this warning? As SR module is independent of PMIC, it canno=
t
distinguish them. So I feel this warning should be present probably
reworded better like "No PMIC hook registered to init smartreflex. Eith=
er
this PM IC does not need SR init or PMIC hook is missing".

Vishwa
>
> [1] http://marc.info/?l=3Dlinux-omap&m=3D129584746102725&w=3D2
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
