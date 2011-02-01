From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [query] smartreflex: No PMIC hook to init smartreflex
Date: Tue, 1 Feb 2011 10:20:03 +0530
Message-ID: <AANLkTim7ThQ3g4_RPcbMRFJKpsVPj8RDL1YjvJH2oTb8@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302485ADDFE@dbde02.ent.ti.com>
	<AANLkTinq5OxHo-X1Wd2EmAwb4LPtQNs5c6=xp4GSymvJ@mail.gmail.com>
	<2dcb8dc49945099cbbc5c4f725d845a5@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302486D6245@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:59570 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751789Ab1BAEuH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 23:50:07 -0500
Received: by mail-px0-f171.google.com with SMTP id 4so939996pxi.16
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 20:50:04 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302486D6245@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sanjeev,

On Mon, Jan 31, 2011 at 9:50 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: Vishwanath Sripathy [mailto:vishwanath.bs@ti.com]
>> Sent: Thursday, January 27, 2011 7:56 PM
>> To: Menon, Nishanth; Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: RE: [query] smartreflex: No PMIC hook to init smartreflex
>>
>> Nishant,
>>
>> > -----Original Message-----
>> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> > owner@vger.kernel.org] On Behalf Of Menon, Nishanth
>> > Sent: Thursday, January 27, 2011 3:06 PM
>> > To: Premi, Sanjeev
>> > Cc: linux-omap@vger.kernel.org
>> > Subject: Re: [query] smartreflex: No PMIC hook to init smartreflex
>> >
>> > Sanjeev,
>> >
>> > On Tue, Jan 25, 2011 at 20:55, Premi, Sanjeev <premi@ti.com> wrote=
:
>> > > While building the kernel at 2.6.37, i see this warning
>> for omap3evm -
>> > with omap3630:
>> > >
>> > > Power Management for TI OMAP3.
>> > > sr_init: No PMIC hook to init smartreflex <-- THIS IS THE WARNIN=
G.
>> > > smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver
>> > initialized
>> > > smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver
>> > initialized
>> > > SmartReflex Class3 initialized
>> > >
>> > > In the code, i see this comment:
>> > > =A0/*
>> > > =A0* sr_init is a late init. If by then a pmic specific API is n=
ot
>> > > =A0* registered either there is no need for anything to be done =
on
>> > > =A0* the PMIC side or somebody has forgotten to register a PMIC
>> > > =A0* handler. Warn for the second condition.
>> > > =A0*/
>> > > =A0if (sr_pmic_data && sr_pmic_data->sr_pmic_init)
>> > > =A0sr_pmic_data->sr_pmic_init();
>> > > =A0else
>> > > =A0pr_warning("%s: No PMIC hook to init smartreflex\n", __func__=
);
>> > >
>> > > But, I couldn't find any place where PMIC is being registered.
>> >
>> > This is a harmless warning (ideally, we should remove the
>> pr_warning).
>> > =A0the intent here is to have hook for pmic_init which could be
>> > populated for custom PMICs which may need "something additional" f=
or
>> > Smart reflex enablement. if you look at the sr_pmic_data -
>> it just has
>> > a single api for pmic_init
>> >
>> > e.g. in the case of TWL4030/5030, we might need to set the bit to
>> > switch mode from I2C1 to I2C_SR - e.g. the patch from Shweta[1]
>> >
>> > if Smartreflex AVS was the *only* mechanism in the system, we coul=
d
>> > have hooked pmic_init to this bit setting. but since the
>> system can do
>> > voltage scaling (VP forceupdate/vc bypass) independent of SR AVS
>> > block, the patch in [1] does initialization independent of
>> > sr_pmic_data->pmic_init which makes sense.
>> >
>> > in short, my 2cents: the warning is probably something we should
>> > remove from the code.
>> As you mentioned, incase of TWL4030/5030, we do not need any
>> hook. However
>> if some other PMIC is used that genuinely needs this hook,
>> then shouldn't
>> SR throw up this warning? As SR module is independent of
>> PMIC, it cannot
>
>
> I possibly see different arguments from your description:
> 1) This is hook is not needed for TWL4030/5030.
> =A0 But still, still hook is needed for another PMIC.
 True.
struct  'sr_pmic_data' is generic way of handling all Pmic.
The pmic needs to register to SR which it does  by API 'sr_pmic_init'.
Today this API just enables SR bit "CFG_ENABLE_SRFLX" in TWL
PM module registers which is redundant in case of TWL chips as SR bit
is already set in 'omap_twl_init' API in file omap_twl.c
But in future if this API 'sr_pmic_init' has some other functionality o=
r
in case when Pmic is not TWL family chip then the initialization done b=
y
'sr_pmic_init' is necessary.
> 2) It is okay to warn user for non-existent hook that is not
> =A0 really needed... in hope that there could be a different PMIC.
>
> 3) Despite saying that SR is independent of PMIC, we assume it as
> =A0 default and don't go thru the "plugin" route.
>
> Something seems to be missing in the argument. I haven't been able
> to spend more time on this since last mail (also reason for late
> response); but:
>
> 1) When user adds the hook - for different PMIC, this warning/info
> =A0 would go away. But not for current default systems.
If some other PMIC is registered then ideally this warning shouldn't co=
me
and if it comes it hampers SR role but for TWL4030/TWL5030 this warning
is harmless.
> 2) By keeping TWL4030 as default, we are possibly not telling the
> =A0 person keen on replacing the PMIC what should be done?
>
> If SR is really PMIC independent, then warning is right only if
> TWL4030 is also 'plugged-in' as any other PMIC is expected to be.
>
>> distinguish them. So I feel this warning should be present probably
>> reworded better like "No PMIC hook registered to init
>> smartreflex. Either
>> this PM IC does not need SR init or PMIC hook is missing".
>
> This wording - as is - would again be misleading.
>
> ~sanjeev
>
>> Vishwa
>> >
>> > [1] http://marc.info/?l=3Dlinux-omap&m=3D129584746102725&w=3D2
>> > Regards,
>> > Nishanth Menon
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>


--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
