From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Thu, 20 Jan 2011 18:44:05 +0530
Message-ID: <AANLkTimOD+wzybZigMOkLm56hU-=rq4fUrErTDpD0H3f@mail.gmail.com>
References: <1295428078-7822-1-git-send-email-shweta.gulati@ti.com>
	<4D36ADB7.3050807@ti.com>
	<AANLkTinRh+4eBf_Pu8DCAMyc+9D-bMVuV8kxwL5rOsXg@mail.gmail.com>
	<4D36D7E6.9060605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:51952 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755539Ab1ATNOH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 08:14:07 -0500
Received: by mail-pv0-f174.google.com with SMTP id 4so107662pva.33
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 05:14:06 -0800 (PST)
In-Reply-To: <4D36D7E6.9060605@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

On Wed, Jan 19, 2011 at 5:54 PM, Nishanth Menon <nm@ti.com> wrote:
> Gulati, Shweta wrote, on 01/19/2011 02:10 PM:
>>
>> =A0 =A0 >I cant see how disable_sr is usable, further as discussed i=
n
>> =A0 =A0http://marc.info/?l=3Dlinux->omap&m=3D129424774929498&w=3D2
>> =A0 =A0<http://marc.info/?l=3Dlinux-omap&m=3D129424774929498&w=3D2> =
we decided to
>> =A0 =A0introduce api *if needed*. does any one need it?
>>
>> =A0 =A0There might be some OMAP3xxx chips where for DVFS VMODE or VS=
EL
>> =A0 =A0method is used, for those boards this disable API could be ca=
lled
>> =A0 =A0from Board File, =A0to make sure the sequence of execution =A0=
of
>>
>> =A0 =A0 late_init_call of twl_init from omap2_common_pm_late_init do=
es not
>> hamper clearing of this bit I would add a global variable to keep tr=
ack
>> if Resetting is required or not, will submit V2 with changes.
>
> Apologies, but a Dumb question:
>
> late_initcall(omap2_common_pm_late_init)
> board files(arch/arm/include/asm/mach/arch.h machine_desc) tend to ha=
ve the
> following hooks:
>
> void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*fixup)(struct machine_d=
esc *,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t tag *, char **,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t meminfo *);
> void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*reserve)(void);/* reser=
ve mem blocks =A0*/
> void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*map_io)(void);/* IO map=
ping function =A0*/
> void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*init_early)(void);
> void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*init_irq)(void);
> struct sys_timer =A0 =A0 =A0 =A0*timer; =A0 =A0 =A0 =A0 /* system tic=
k timer =A0 =A0*/
> void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*init_machine (void);
> void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*handle_irq)(struct pt_r=
egs *);
>
> So if i wanted to disable the SR setting, where should I do it?
>
> --
> Regards,
> Nishanth Menon

Nishanth,

I think i could not make my point clear in my previous reply.

There are two APIs added 'omap3_twl_disable_sr' and
'omap3_twl_enable_sr'. omap3_twl_enable_sr sets SR bit in TWL4030
registers to make sure VPforceupdate method of voltage scaling works
properly but there could be some OMAP3xxx chips where VMODE or VSEL
method of voltage scaling is used (though today these voltage scaling
methods are not recommended by HW folks). For the boards where
Vpforceupdate method is used this  'omap3_twl_disable_sr' would not be
called.  For possible case of platforms where VMODE or VSEL methods
are used the API 'omap3_twl_disable_sr' will reset this bit.
The API 'omap3_twl_disable_sr' can be called from board file, to make
sure the resetting of this bit is not
overwritten in late_init call of omap3_twl_init(where
'omap3_twl_enable_sr' is called) I suggested adding a
global flag which will keep track whether this bit is cleared from
board file or not.
Would make these changes in V2.

Regards,
Shweta
> PS: could you please fix your mailer when replying on l-o for netetiq=
uette
> reasons?
>



--
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
