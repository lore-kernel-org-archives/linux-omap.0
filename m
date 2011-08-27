From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [RFC 1/2] OMAP3+: voltage / oscillator parameter segregation
Date: Sat, 27 Aug 2011 14:59:22 +0530
Message-ID: <d74484cd55c8314a364af834fbbede0f@mail.gmail.com>
References: <1312385355-17029-1-git-send-email-t-kristo@ti.com><1312385355-17029-2-git-send-email-t-kristo@ti.com><CAOMWX4cTsoK_ejOq861wNMiUDJYjcvPtc+jLo3z398D-Y2e39w@mail.gmail.com>
 <87zkivwybn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:32879 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125Ab1H0J3W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Aug 2011 05:29:22 -0400
Received: by mail-gw0-f46.google.com with SMTP id a12so3518467gwa.19
        for <linux-omap@vger.kernel.org>; Sat, 27 Aug 2011 02:29:22 -0700 (PDT)
In-Reply-To: <87zkivwybn.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Saturday, August 27, 2011 4:55 AM
> To: Menon, Nishanth
> Cc: Tero Kristo; linux-omap@vger.kernel.org; Vishwanath Sripathy
> Subject: Re: [RFC 1/2] OMAP3+: voltage / oscillator parameter
> segregation
>
> Hi Nishanth,
>
> "Menon, Nishanth" <nm@ti.com> writes:
>
> > here is my quick feedback:
> >
> >
> > On Wed, Aug 3, 2011 at 10:29, Tero Kristo <t-kristo@ti.com> wrote:
> >>
> >> This patch separates board specific voltage and oscillator ramp /
> setup
> >> times from the core code. Things changed:
> >>
> >> - on/sleep/ret/off voltage setup moved from common twl code to
> >> =A0VC / VP data (oppxxxx_data.c files)
> >> - added board support for vdd ramp up / down times
> >> - added board support for oscillator setup time declaration
> >>
> >> Todo: split patch into more easily manageable parts.
> >>
> >> Applies on top of pm/wip/voltdm branch, based on work done by
> Vishwanath
> >> Sripathy.
> >>
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
>
> [...]
>
> >> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-
> omap2/opp3xxx_data.c
> >> index d95f3f9..b5d8294 100644
> >> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> >> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> >> @@ -26,6 +26,16 @@
> >> =A0#include "pm.h"
> >>
> >> =A0/* 34xx */
> >> +/* OMAP VP parameter values */
> >> +#define OMAP3430_VP1_VLIMITTO_VDDMIN =A0 0x14
> >> +#define OMAP3430_VP1_VLIMITTO_VDDMAX =A0 0x42
> >> +#define OMAP3430_VP2_VLIMITTO_VDDMIN =A0 0x18
> >> +#define OMAP3430_VP2_VLIMITTO_VDDMAX =A0 0x2c
> > NAK -> we should be using voltages here -> depending on the PMIC
> used,
> > the rounding factor may not map to TWL4030.
>
> Agreed.
>
> > I had posted patch for this earlier I believe in series
> > http://marc.info/?l=3Dlinux-omap&m=3D130741297821372&w=3D2
>
> I know you're a bit distracted currently ;) but is there any chance
> you
> can refresh at least this patch:
>
>     OMAP3+: PM: VP: use uV for max and min voltage limits
>
> from your series on top of my current pm-wip/voltdm branch?
>
> If not, maybe point us to an archived version and Tero can pick it
> up
> and add it to this series.  After a quick search, I couldn't find it
> in
> the marc.info archives.
Below link should help I suppose.
https://patchwork.kernel.org/patch/855172/

Vishwa

>
> Thanks,
>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
