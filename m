From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] omap: dsp: fixes for 2.6.37-rc1
Date: Wed, 15 Dec 2010 15:04:58 +0200
Message-ID: <AANLkTimRepQwUW5R_GXN6Y0ot850iHM-cONwQ=ErwNLQ@mail.gmail.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com>
	<1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.2.00.1012142253320.15971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:38129 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab0LONFA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 08:05:00 -0500
Received: by bwz16 with SMTP id 16so2235612bwz.4
        for <linux-omap@vger.kernel.org>; Wed, 15 Dec 2010 05:04:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012142253320.15971@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

Hi,

On Wed, Dec 15, 2010 at 8:00 AM, Paul Walmsley <paul@pwsan.com> wrote:
> I am reviewing these patches for merging, and would appreciate your h=
elp.
>
> On Sun, 7 Nov 2010, Felipe Contreras wrote:
>
>> Paul already sent these, but I did some minor modifications, mostly =
to minimize
>> the amount of changes.
>>
>> Also, I'm re-sending my memblock patch so that the driver can actual=
ly be
>> compiled.
>
> It looks like the memblock change has been applied already.
>
>> With these, and reverting the iommu patches[1], the driver should be=
 working. I
>> don't see a more straight-forward way to achieve that.
>>
>> Paul Walmsley (4):
>> =C2=A0 omap: control: add functions for DSP boot
>> =C2=A0 omap: pm: use control functions in DSP reset code
>> =C2=A0 omap: dsp: add boot control functions
>> =C2=A0 staging: tidspbridge: use boot control functions
>
> It seems that we still need to apply these. =C2=A0Could you please re=
base these
> against the 'integration-2.6.38-20101214-013' tag available from
> git://git.pwsan.com/linux-integration?

Ok, will do.

> Also, a few changes are needed in the patches themselves. =C2=A0Here =
are two
> that I noticed:
>
> First, please add my Signed-off-by: on the first
> patch, "omap: control: add functions for DSP boot", as discussed
> previously.

Yes, I haven't got around to do so. I thought I still had time before
=2E38 merge window.

> Second, I notice that you wiped out almost my entire original commit
> message from "omap: dsp: add boot control functions", and did not add=
 a
> note in brackets explaining what you did or why. =C2=A0I strongly obj=
ect to
> this. =C2=A0The commit message is as much a part of that patch as the=
 code is
> and I would appreciate it if you would either add it back in, or add =
a
> bracketed note next to your Signed-off-by: explaining why the commit
> message needed to be removed.

Huh?

Before:
mach-omap2/control:
---
Add two functions for OMAP2430/OMAP3 IVA2 DSP boot control.  These
registers wound up in the System Control Module.  Other kernel code
that wishes to control the DSP's boot process should now use these
functions to do so; subsequent patches implement this in the two
in-tree users of these functions.

This patch is functionally untested; that is for the DSP/Bridge
programmers to do.
---

tidspbridge/core/tiomap3430.c:
tidspbridge/include/dspbridge/host_os.h:
---
DSPBridge currently tries to __raw_writel() to the System Control
Module to control the DSP boot process.  This is a layering violation;
this is SoC-specific code, and belongs in a file in
arch/arm/mach-omap2/*.  None of those CM and PRM register accesses
through struct platform_data belong under drivers/.  (Nor would they
belong in DSP platform init code in arch/arm/mach-omap2/* - such code
must use the clock, clockdomain, powerdomain, omap_device, and
omap_hwmod layers that are provided for this purpose.)

The immediate problem, however, is that after commit
346a5c890a55495c718394b74214be1de9303cf6, this code can no longer compi=
le.
So to fix this immediate problem, convert the DSP boot control code to
use platform_data function pointers.

The DSPBridge-on-OMAP3 people also need to implement a file in
arch/arm/mach-omap2/ to populate the platform_data function pointers.
Such a file does not yet exist in the mainline tree, so it's unlikely
that DSPBridge is usable in the mainline until this is done.
---

After:

mach-omap2/control:
---
Add two functions for OMAP2430/OMAP3 IVA2 DSP boot control.  These
registers wound up in the System Control Module.  Other kernel code tha=
t
wishes to control the DSP's boot process should now use these functions
to do so; subsequent patches implement this in the two in-tree users of
these functions.
---

mach-omap2/dsp:
---
Would be needed to avoid using SCM directly.
---

tidspbridge/core/tiomap3430.c:
---
Use the new functions from SCM layer instead of handling registers
directly with __raw_writel, as explained in:

http://marc.info/?l=3Dlinux-omap&m=3D128779652429922&w=3D2

This fixes the build on 2.6.37 since control.h is not available for
drivers any more.
---

I thought it was evident that patch 1 adds some functions, and says
those functions should be used to modify SCM registers, patch 2 adds
callbacks to them, and patch 3 uses those callbacks instead of
directly modifying the registers. I could add "Such access is a layer
violation; it should be handled by the platform control
(arch/arm/mach-omap2/control.c)".

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
