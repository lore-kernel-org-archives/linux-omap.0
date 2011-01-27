From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [query] smartreflex: No PMIC hook to init smartreflex
Date: Thu, 27 Jan 2011 19:37:20 +0530
Message-ID: <AANLkTinUZEP4ATayaVh6X303WdfCOG=LmDmmjFTw1Nw9@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302485ADDFE@dbde02.ent.ti.com>
	<AANLkTinq5OxHo-X1Wd2EmAwb4LPtQNs5c6=xp4GSymvJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43263 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753141Ab1A0OHX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 09:07:23 -0500
Received: by pwj4 with SMTP id 4so461584pwj.10
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 06:07:22 -0800 (PST)
In-Reply-To: <AANLkTinq5OxHo-X1Wd2EmAwb4LPtQNs5c6=xp4GSymvJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sanjeev,
On Thu, Jan 27, 2011 at 3:05 PM, Menon, Nishanth <nm@ti.com> wrote:
> Sanjeev,
>
> On Tue, Jan 25, 2011 at 20:55, Premi, Sanjeev <premi@ti.com> wrote:
>> While building the kernel at 2.6.37, i see this warning for omap3evm=
 - with omap3630:
>>
>> Power Management for TI OMAP3.
>> sr_init: No PMIC hook to init smartreflex <-- THIS IS THE WARNING.
>> smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initial=
ized
>> smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initial=
ized
>> SmartReflex Class3 initialized
>>
>> In the code, i see this comment:
>> =A0/*
>> =A0* sr_init is a late init. If by then a pmic specific API is not
>> =A0* registered either there is no need for anything to be done on
>> =A0* the PMIC side or somebody has forgotten to register a PMIC
>> =A0* handler. Warn for the second condition.
>> =A0*/
>> =A0if (sr_pmic_data && sr_pmic_data->sr_pmic_init)
>> =A0sr_pmic_data->sr_pmic_init();
>> =A0else
>> =A0pr_warning("%s: No PMIC hook to init smartreflex\n", __func__);
>>
>> But, I couldn't find any place where PMIC is being registered.
>
> This is a harmless warning (ideally, we should remove the pr_warning)=
=2E
> =A0the intent here is to have hook for pmic_init which could be
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
>
> [1] http://marc.info/?l=3Dlinux-omap&m=3D129584746102725&w=3D2
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
I have tested on OMAP4 board also, Smart reflex works fine. It brings
down the nominal voltages to
optimum levels, the registration done by generic Pmic  framework to SR
wouldn't hamper SR woking
as the SR bit setting is done specifically in Triton specific file
'omap_twl.c' and thus, that warning is harmless.
The patch you should take for SR to work is:
https://patchwork.kernel.org/patch/510971/
--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
