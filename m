From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RESEND][PATCH v2 2/6] OMAP1: Add support for SoC camera interface
Date: Fri, 24 Sep 2010 01:44:45 +0200
Message-ID: <201009240144.47422.jkrzyszt@tis.icnet.pl>
References: <201009110317.54899.jkrzyszt@tis.icnet.pl> <201009110334.03905.jkrzyszt@tis.icnet.pl> <20100923232309.GV4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:40914 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747Ab0IWXpP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 19:45:15 -0400
In-Reply-To: <20100923232309.GV4211@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-media@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

=46riday 24 September 2010 01:23:10 Tony Lindgren napisa=C5=82(a):
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [100910 18:26]:
> > This patch adds support for SoC camera interface to OMAP1 devices.
> >
> > Created and tested against linux-2.6.36-rc3 on Amstrad Delta.
> >
> > For successfull compilation, requires a header file provided by PAT=
CH 1/6
> > from this series, "SoC Camera: add driver for OMAP1 camera interfac=
e".
>
> <snip>
>
> > diff -upr linux-2.6.36-rc3.orig/arch/arm/mach-omap1/include/mach/ca=
mera.h
> > linux-2.6.36-rc3/arch/arm/mach-omap1/include/mach/camera.h
> > ---
> > linux-2.6.36-rc3.orig/arch/arm/mach-omap1/include/mach/camera.h	201=
0-09-0
> >3 22:34:03.000000000 +0200 +++
> > linux-2.6.36-rc3/arch/arm/mach-omap1/include/mach/camera.h	2010-09-=
09
> > 18:42:30.000000000 +0200 @@ -0,0 +1,8 @@
> > +#ifndef __ASM_ARCH_CAMERA_H_
> > +#define __ASM_ARCH_CAMERA_H_
> > +
> > +#include <media/omap1_camera.h>
> > +
> > +extern void omap1_set_camera_info(struct omap1_cam_platform_data *=
);
> > +
> > +#endif /* __ASM_ARCH_CAMERA_H_ */
>
> Care to refresh this patch so it does not include media/omap1_camera.=
h?
>
> That way things keep building if I merge this one along with the omap
> patches and the drivers/media patches can get merged their via media.
>
> I think you can just move the OMAP1_CAMERA_IOSIZE to the devices.c or
> someplace like that?

Tony,
Not exactly. I use the OMAP1_CAMERA_IOSIZE inside the driver when reser=
ving=20
space for register cache.

I think that I could just duplicate its definition in the devices.c for=
 now,=20
than clean things up with a folloup patch when both parts already get m=
erged.=20
Would this be acceptable?

Thanks,
Janusz

>
> Regards,
>
> Tony
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
