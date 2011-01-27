From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [query] smartreflex: No PMIC hook to init smartreflex
Date: Thu, 27 Jan 2011 15:05:52 +0530
Message-ID: <AANLkTinq5OxHo-X1Wd2EmAwb4LPtQNs5c6=xp4GSymvJ@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302485ADDFE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53014 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753522Ab1A0Jnj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 04:43:39 -0500
Received: by wwi17 with SMTP id 17so6288773wwi.3
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 01:43:37 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302485ADDFE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sanjeev,

On Tue, Jan 25, 2011 at 20:55, Premi, Sanjeev <premi@ti.com> wrote:
> While building the kernel at 2.6.37, i see this warning for omap3evm =
- with omap3630:
>
> Power Management for TI OMAP3.
> sr_init: No PMIC hook to init smartreflex <-- THIS IS THE WARNING.
> smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initiali=
zed
> smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initiali=
zed
> SmartReflex Class3 initialized
>
> In the code, i see this comment:
> =A0/*
> =A0* sr_init is a late init. If by then a pmic specific API is not
> =A0* registered either there is no need for anything to be done on
> =A0* the PMIC side or somebody has forgotten to register a PMIC
> =A0* handler. Warn for the second condition.
> =A0*/
> =A0if (sr_pmic_data && sr_pmic_data->sr_pmic_init)
> =A0sr_pmic_data->sr_pmic_init();
> =A0else
> =A0pr_warning("%s: No PMIC hook to init smartreflex\n", __func__);
>
> But, I couldn't find any place where PMIC is being registered.

This is a harmless warning (ideally, we should remove the pr_warning).
 the intent here is to have hook for pmic_init which could be
populated for custom PMICs which may need "something additional" for
Smart reflex enablement. if you look at the sr_pmic_data - it just has
a single api for pmic_init

e.g. in the case of TWL4030/5030, we might need to set the bit to
switch mode from I2C1 to I2C_SR - e.g. the patch from Shweta[1]

if Smartreflex AVS was the *only* mechanism in the system, we could
have hooked pmic_init to this bit setting. but since the system can do
voltage scaling (VP forceupdate/vc bypass) independent of SR AVS
block, the patch in [1] does initialization independent of
sr_pmic_data->pmic_init which makes sense.

in short, my 2cents: the warning is probably something we should
remove from the code.

[1] http://marc.info/?l=3Dlinux-omap&m=3D129584746102725&w=3D2
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
