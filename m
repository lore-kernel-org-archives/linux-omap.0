From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
Date: Thu, 19 Apr 2012 11:17:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204191050110.29048@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053654.16278.73632.stgit@dusk> <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com> <4F90001E.8060201@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-30094451-1334854280=:29048"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56000 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab2DSRRp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 13:17:45 -0400
In-Reply-To: <4F90001E.8060201@ti.com>
Content-ID: <alpine.DEB.2.00.1204191051240.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-30094451-1334854280=:29048
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1204191051241.29048@utopia.booyaka.com>

Hi Beno=EEt,

On Thu, 19 Apr 2012, Cousson, Benoit wrote:

> The concern of the people doing SW in these embedded processors was mainl=
y
> because we were releasing the reset of processor without loading any SW f=
irst
> and thus the processor was executing some random instructions.
>=20
> So if we consider a better hwmods definition, we can potentially fix the =
MMU
> case:
>=20
>     'mmu_ipu':
>         'rst_ipu_mmu_cache'
>=20
>     'mmu_dsp':
>         'rst_dsp_mmu_cache'
>=20
>     'iva_config':
>         'rst_logic'

Wouldn't these still be "pseudo-hwmods?"  Or do each of these actually=20
have address space, interconnect ports, etc.?

Another approach that might not require defining pseudo-hwmods is to=20
define a per-hard-reset-line flag that could be used to alter the way the=
=20
hwmod code handles the hardreset line.

> But then we do have the processor resets that have to be exposed somewher=
e.
>=20
>     'ipu':
>         'rst_cpu0'
>         'rst_cpu1'
>=20
>     'dsp':
>         'rst_dsp'
>=20
>     'iva':
>         'rst_seq1'
>         'rst_seq2'
>=20
> None of these one should be controlled automatically.

Don't we still want to put these IP blocks into reset until a driver for=20
these IP blocks is loaded?

> >   =09/*
> > -=09 * If an IP contains HW reset lines, then de-assert them in order
> > -=09 * to allow the module state transition. Otherwise the PRCM will
> > return
> > -=09 * Intransition status, and the init will failed.
> > +=09 * If an IP block contains HW reset lines and any of them are
> > +=09 * asserted, we let integration code associated with that
> > +=09 * block handle the enable.  We've received very little
> > +=09 * information on what those driver authors need, and until
> > +=09 * detailed information is provided and the driver code is
> > +=09 * posted to the public lists, this is probably the best we
> > +=09 * can do.
>=20
> Maybe we should keep that with some mechanism to prevent it for some IP l=
ike
> processors .
>=20
> I guess that with that patch, we cannot enable anymore IPU/DSP and IVA at=
 boot
> time.

I am probably misunderstanding your comment, but I don't think there's any=
=20
way at the moment to generically enable those IP blocks without driver=20
integration code assistance.

If we leave the hardreset lines asserted in _enable(), then the PRCM=20
status for those modules will be stuck in In-transition state, according=20
to the previous comments in the code.  I think this will block PM idle=20
transitions.  Also we have no way to restore the clockdomain idle settings=
=20
during the second part of the hwmod enable sequence, I think, since it=20
will need to be executed by driver integration code :-(

And I don't think we can deassert the hardreset lines in _enable() right=20
now, for the reason that you mentioned in your message: unless the driver=
=20
integration code implements a custom reset function, we don't have any way=
=20
to load code into the IP block before deasserting the hardreset.

So at this point I'd propose that we encourage these driver authors to=20
implement custom reset functions for their IP blocks that load firmware if=
=20
needed, and put them into idle, similar to what omap3_iva_idle() does in=20
mach-omap2/pm34xx.c.  If the custom reset function takes the IP block out=
=20
of hardreset, then the subsequent hwmod enable/idle/shutdown calls should=
=20
work, after this patch.

> Otherwise, it looks fine to me.

Thanks for the review.


- Paul
--155748971-30094451-1334854280=:29048--
