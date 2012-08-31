From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V5 0/6] OMAPDSS: Cleanup cpu_is checks
Date: Fri, 31 Aug 2012 14:23:40 +0300
Message-ID: <1346412220.16067.8.camel@deskari>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <cover.1345468541.git.cmahapatra@ti.com>
	 <20120830002039.GP1303@atomide.com> <1346312061.2327.27.camel@deskari>
	 <20120830171908.GQ1303@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-k2cUN0GXR2YpOqybHRZP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:58113 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752163Ab2HaLXq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 07:23:46 -0400
Received: by lbbgj3 with SMTP id gj3so1137672lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 04:23:43 -0700 (PDT)
In-Reply-To: <20120830171908.GQ1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chandrabhanu Mahapatra <cmahapatra@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-k2cUN0GXR2YpOqybHRZP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-30 at 10:19 -0700, Tony Lindgren wrote:
> Hi,
>=20
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120830 00:35]:
> > On Wed, 2012-08-29 at 17:20 -0700, Tony Lindgren wrote:
> > >=20
> > > Good to see this, we need this badly to avoid blocking
> > > single zImage effort on omaps. Can you also please take
> >=20
> > What is the issue with single zImage? How do cpu_is_ check affect it?
>=20
> The usage for that should only be limited to arch/arm/mach-omap2
> so we can make cpu.h local as we can't include mach and plat
> header files from the drivers with single zImage.

Ok.

> > $ git grep -E "<plat|<mach" drivers/video/omap*
> > drivers/video/omap/lcd_ams_delta.c:#include <plat/board-ams-delta.h>
> > * Needs to be moved
>=20
> Yes, that should be either mach/board-ams-delta.h, or separate driver
> specific headers in include/linux/platform_data. For omap1 we are not
> planning common zImage support, so let's just make sure we're not
> breaking anything there as people are still using it.

Hmm, so did I understand right, for omap1 stuff we can still include
from arch/arm/mach-omap1/include/mach?

If so, that makes things easier. I can manage the omap2+ stuff fine, but
I have no experience with omap1, nor do I have any omap1 devices. So I'd
rather keep the omap1 code as it is, in fear that I'd just break it
totally, and I'd rather spend my time on omap2+ code.

> > drivers/video/omap2/dss/dss.c:#include <plat/cpu.h>
> > * Uses cpu_is_* to find out the DSS version. dispc.c also uses cpu_is_*
> > functions, but doesn't include plat/cpu.h. I know cpu_is_* checks shoul=
d
> > be removed, but is there some other file to include for the time being
> > than plat/cpu.h?
>=20
> We could make it mach/cpu.h for omap1, but ideally we would just
> pass DSS_VERSION_XYZ type flag in platform data on omap1.

Ok. The omap1 fb driver seems to contain a few cpu_is_omap15xx() checks,
nothing else.

> > drivers/video/omap2/dss/dss_features.c:#include <plat/cpu.h>
> > * Uses cpu_is_* to find out the DSS version
>=20
> Here too.

Yep, for omap2+ I'll create a version ID that we'll pass via plat data.
=20
> > drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vrfb.h>
> > drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vram.h>
> > drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vram.h>
> > drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vrfb.h>
> > drivers/video/omap2/omapfb/omapfb-sysfs.c:#include <plat/vrfb.h>
> > drivers/video/omap2/vram.c:#include <plat/vram.h>
> > drivers/video/omap2/vram.c:#include <plat/dma.h>
> > drivers/video/omap2/vrfb.c:#include <plat/vrfb.h>
> > drivers/video/omap2/vrfb.c:#include <plat/sdrc.h>
> >=20
> > Of these, I'm not sure how to handle.
>=20
> These should eventually be in platform_data as driver specific headers.
> =20
> > Grep shows that vram.c is only used by (the newer) omapfb, so it could
> > be considered a part of that driver. It still needs to be built-in, as
> > it needs to reserve memory early in the boot process (done with a call
> > from arch/arm/plat-omap/common.c).
>=20
> Hmm it sounds like omap_vram_reserve_sdram_memblock() should be in
> plat-omap and just pass the pointer for later use for vram.c.
> =20
> > Also board files can use a func call to define the amount of memory to
> > allocate, but only rx51 seems to do this in the mainline.
> >=20
> > Anyway, I believe vram.c is going away when we start to use CMA.
>=20
> OK cool.=20
> =20
> > As for vrfb... I'm not really sure where it belongs. It is used by the
> > newer omapfb and OMAP V4L2 driver. VRFB is a part of the OMAP's memory
> > controller, so I'm not sure if it's really a normal driver.
>=20
> Maybe just split it to platform code for the memblock stuff and pass
> the necessary information to the driver in platform_data?

I'll try to figure out something for vrfb.

 Tomi


--=-k2cUN0GXR2YpOqybHRZP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQQJ68AAoJEPo9qoy8lh71gEkQAJ6S6Uvb6vkbc6dKO0yJXIHO
1EwZ1YOyAwpLGVCfTdz9h9fASEGy0D1ggQ4ImEqYrpZRIdBJcqDySdH/Pj7aAy3I
etiZZZpY/ib9cj1xc8ouhzd7kqSeKJ6FZeQV61UcNe8gcqKGpbDOK47c8k/mzP7/
Hwenz4u9cGM9QMSu78RX//WESdYMJ7+w6IsSpLcJBdMZ5xgecUV+QcmM1dxj6UiO
MGqi3diAZb66oiNmIkquohAO4az+TbGA9sNOYtpEnGK7WbhV4MQabgkJKhHXwe4K
gTCqvtFjMRBOY3c2aQ3ammkoxfSQG2HJ7/LelhAsd/37WBeVJ6XnQtBWVYSbA6PH
MrNPd5ZNQFAGuy5X5yr8U6MUnzJv5gIFjDoo79xm9DslUO7a/mXo4Lytr0Ptalkx
J1HtvOKcL1iIlyLXqLQ0CcVMEwsElBCKjWIf5gAC3NWnYCT9cLjW4iYbLObqi8Tt
kGj+6JX6Ocs9HGmbCxlC22gFzwCQiDD6i0w52t+xba6arD900Iqqn8X3TD9yXhw9
wpk20LFyO2GDZxZceT9dkQCRAzMYk1H5kupMhG3sx+C91Gv+rnaHYvv36lrnT6Ha
1uPhJI5BIBKq4TNJQt011kFzQSyNn7mzEi1LRoJk6BhUPEB4eY7siPa9R5pfj1Oa
cQKsd0uUMwSztX0M7BqC
=9UVy
-----END PGP SIGNATURE-----

--=-k2cUN0GXR2YpOqybHRZP--

