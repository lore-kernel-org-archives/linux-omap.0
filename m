From: "Ryazantsev, Volodymyr" <v.riazantsev@ti.com>
Subject: Re: [PATCH] OMAP4: Adding ID for OMAP4460 ES1.1
Date: Tue, 15 May 2012 14:34:00 +0300
Message-ID: <CALxnyLDMpxsX2qZmJrb_oF+qLd_-DaApEGA0u+EiWEVX6Y1xmg@mail.gmail.com>
References: <1333357197-6354-1-git-send-email-rogerq@ti.com>
 <4F7AC721.4020205@ti.com> <20120418165008.GI21106@atomide.com> <4F8FBD6D.1040400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:53414 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757553Ab2EOLed convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 07:34:33 -0400
Received: by ggnv5 with SMTP id v5so2032639ggn.26
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 04:34:30 -0700 (PDT)
In-Reply-To: <4F8FBD6D.1040400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, Chris Lalancette <clalancette@gmail.com>

Hi Tony,

=A0 Could you please take this patch.
=A0 Its absence raises some issues like Errata maintenance.

Thanks,
=A0 _vr

On Thu, Apr 19, 2012 at 10:23 AM, Roger Quadros <rogerq@ti.com> wrote:
>
> Hi,
>
> On 04/18/2012 07:50 PM, Tony Lindgren wrote:
> > Hi,
> >
> > * Roger Quadros <rogerq@ti.com> [120403 02:50]:
> >> Hi Tony,
> >>
> >> Could you please take this patch for the next merge? Thanks.
> >
> > Yes, it seems that this is not needed as a fix for the -rc cycle?
>
> Right, it is not needed for this -rc cycle.
> >
> > If it's needed as a fix, please let me know and also describe
> > what breaks.
>
> It does not fix anything but is just for the sake of correctness.
>
> regards,
> -roger
>
> >
> >> On 04/02/2012 11:59 AM, Roger Quadros wrote:
> >>> From: Chris Lalancette <clalancette@gmail.com>
> >>>
> >>> Signed-off-by: Chris Lalancette <clalancette@gmail.com>
> >>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >>> ---
> >>> =A0arch/arm/mach-omap2/id.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05=
 ++++-
> >>> =A0arch/arm/plat-omap/include/plat/cpu.h | =A0 =A01 +
> >>> =A02 files changed, 5 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> >>> index 0e79b7b..f139817 100644
> >>> --- a/arch/arm/mach-omap2/id.c
> >>> +++ b/arch/arm/mach-omap2/id.c
> >>> @@ -478,9 +478,12 @@ void __init omap4xxx_check_revision(void)
> >>> =A0 =A0 case 0xb94e:
> >>> =A0 =A0 =A0 =A0 =A0 =A0 switch (rev) {
> >>> =A0 =A0 =A0 =A0 =A0 =A0 case 0:
> >>> - =A0 =A0 =A0 =A0 =A0 default:
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP446=
0_REV_ES1_0;
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >>> + =A0 =A0 =A0 =A0 =A0 case 2:
> >>> + =A0 =A0 =A0 =A0 =A0 default:
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP4460_=
REV_ES1_1;
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >>> =A0 =A0 =A0 =A0 =A0 =A0 }
> >>> =A0 =A0 =A0 =A0 =A0 =A0 break;
> >>> =A0 =A0 case 0xb975:
> >>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/pla=
t-omap/include/plat/cpu.h
> >>> index dc6a86b..4bdf14e 100644
> >>> --- a/arch/arm/plat-omap/include/plat/cpu.h
> >>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> >>> @@ -445,6 +445,7 @@ IS_OMAP_TYPE(3517, 0x3517)
> >>>
> >>> =A0#define OMAP446X_CLASS =A0 =A0 =A0 =A0 =A0 =A0 0x44600044
> >>> =A0#define OMAP4460_REV_ES1_0 (OMAP446X_CLASS | (0x10 << 8))
> >>> +#define OMAP4460_REV_ES1_1 (OMAP446X_CLASS | (0x11 << 8))
> >>>
> >>> =A0#define OMAP447X_CLASS =A0 =A0 =A0 =A0 =A0 =A0 0x44700044
> >>> =A0#define OMAP4470_REV_ES1_0 (OMAP447X_CLASS | (0x10 << 8))
> >>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html




--
~~~~~~~~~~~~~~~~~~~
Best regards,
Riazantsev Volodymyr | OMAP4 Platform | GlobalLogic Ukr.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
