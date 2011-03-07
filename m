From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v11 2/8] OMAP4: hwmod data: add dmtimer version
 information
Date: Mon, 7 Mar 2011 16:49:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A360A1B@dbde02.ent.ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-3-git-send-email-tarun.kanti@ti.com>
 <871v2npwb8.fsf@ti.com> <4D70CA22.8040001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38506 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492Ab1CGLTS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 06:19:18 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p27BJEYD031569
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 05:19:17 -0600
In-Reply-To: <4D70CA22.8040001@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Friday, March 04, 2011 4:47 PM
> To: Hilman, Kevin; DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v11 2/8] OMAP4: hwmod data: add dmtimer version
> information
>=20
> On 3/4/2011 1:24 AM, Hilman, Kevin wrote:
> > Tarun Kanti DebBarma<tarun.kanti@ti.com>  writes:
> >
> >> OMAP4 has two groups of timers: version 1 timers are 1, 2, 10,
> >> while the rest of the timers, 3-9, 11 are version 2 timers.
> >> The version information is required by the driver so that they
> >> could be handled correctly by it.
> >>
> >> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> >
> > Minor comment below, also needs an ack from Beno=EEt...
>=20
> Oops, I missed that one.
>=20
> Tarun,
> I will be good to add me in Cc in order to avoid that.
> In general it is always good to Cc the maintainers.
>=20
> Once the tabs are fixed;
> Acked-by: Benoit Cousson <b-cousson@ti.com>
I will Cc. Thanks.
--
Tarun
>=20
> >
> >> ---
> >>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +++
> >>   arch/arm/plat-omap/include/plat/dmtimer.h  |    2 ++
> >>   2 files changed, 5 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> index 79a8601..ee57742 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> @@ -25,6 +25,7 @@
> >>   #include<plat/gpio.h>
> >>   #include<plat/dma.h>
> >>   #include<plat/mcspi.h>
> >> +#include<plat/dmtimer.h>
> >>
> >>   #include "omap_hwmod_common_data.h"
> >>
> >> @@ -3940,6 +3941,7 @@ static struct omap_hwmod_class_sysconfig
> omap44xx_timer_1ms_sysc =3D {
> >>   static struct omap_hwmod_class omap44xx_timer_1ms_hwmod_class =3D=
 {
> >>   	.name	=3D "timer",
> >>   	.sysc	=3D&omap44xx_timer_1ms_sysc,
> >> +	.rev =3D OMAP_TIMER_IP_VERSION_1,
> >
> > Please use tab and align '=3D' with above lines.
> >
> >>   };
> >>
> >>   static struct omap_hwmod_class_sysconfig omap44xx_timer_sysc =3D=
 {
> >> @@ -3955,6 +3957,7 @@ static struct omap_hwmod_class_sysconfig
> omap44xx_timer_sysc =3D {
> >>   static struct omap_hwmod_class omap44xx_timer_hwmod_class =3D {
> >>   	.name	=3D "timer",
> >>   	.sysc	=3D&omap44xx_timer_sysc,
> >> +	.rev =3D OMAP_TIMER_IP_VERSION_2,
> >
> > ditto
> >
> >>   };
> >>
> >>   /* timer1 */
> >> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/=
plat-
> omap/include/plat/dmtimer.h
> >> index d6c70d2..05a967e 100644
> >> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> >> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> >> @@ -55,6 +55,8 @@
> >>    * in OMAP4 can be distinguished.
> >>    */
> >>   #define OMAP_TIMER_IP_VERSION_1                        0x1
> >> +#define OMAP_TIMER_IP_VERSION_2                        0x2
> >> +
> >>   struct omap_dm_timer;
> >>   extern struct omap_dm_timer *gptimer_wakeup;
> >>   extern struct sys_timer omap_timer;
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
