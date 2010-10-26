From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/4] tidspbridge: SCM layer violation fixes
Date: Tue, 26 Oct 2010 20:13:24 +0300
Message-ID: <AANLkTik2K+q-585Ap2QFTaOT+vGnz1+14R5ZeenV-2J0@mail.gmail.com>
References: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64649 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359Ab0JZRN0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 13:13:26 -0400
Received: by gwj21 with SMTP id 21so3477481gwj.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Oct 2010 10:13:25 -0700 (PDT)
In-Reply-To: <1288109763-9446-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <tero.kristo@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>, Rene Sapiens <rene.sapiens@ti.com>, Ernesto Ramos <ernesto@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 26, 2010 at 7:15 PM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> This is the patch series shared by Paul, for a short term fix to
> a compile break due SCM layer layer violations from tidspbridge
> driver, where the latter is used to write directly into registers
> and use SCM layer macros, among other layer bypassing.
>
> patch: "staging: tidspbridge: use new SCM DSP boot control fns"
> was split from its original version, it is meant to be on hold until
> the rest of the series gets upstreamed and can be found in the
> staging tree (unless best advice is given).
>
> Paul Walmsley (4):
> =C2=A0OMAP: control: add functions for DSP boot address/mode control
> =C2=A0OMAP3: PM: update DSP reset code to use new SCM DSP boot contro=
l
> =C2=A0 =C2=A0functions
> =C2=A0OMAP: dsp: convert OMAP3430 adaptation layer to use new SCM DSP=
 boot
> =C2=A0 =C2=A0control fns
> =C2=A0staging: tidspbridge: use new SCM DSP boot control fns
>
> =C2=A0arch/arm/mach-omap2/control.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 51 ++++++++++++++++++++++
> =C2=A0arch/arm/mach-omap2/control.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 16 ++++---
> =C2=A0arch/arm/mach-omap2/dsp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 ++
> =C2=A0arch/arm/mach-omap2/pm34xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 +-
> =C2=A0arch/arm/plat-omap/include/plat/dsp.h =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A04 ++
> =C2=A0arch/arm/plat-omap/include/plat/iva2_dsp.h =C2=A0 =C2=A0| =C2=A0=
 56 +++++++++++++++++++++++++

Why not use the already existing dsp.h?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
