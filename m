From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
Date: Thu, 19 Apr 2012 13:46:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204191338370.29048@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053654.16278.73632.stgit@dusk> <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com> <4F90001E.8060201@ti.com> <alpine.DEB.2.00.1204191050110.29048@utopia.booyaka.com>
 <4F90641D.3090208@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1599479799-1334864800=:29048"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56362 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255Ab2DSTql (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 15:46:41 -0400
In-Reply-To: <4F90641D.3090208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1599479799-1334864800=:29048
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Beno=EEt,

On Thu, 19 Apr 2012, Cousson, Benoit wrote:

> On 4/19/2012 7:17 PM, Paul Walmsley wrote:
> > On Thu, 19 Apr 2012, Cousson, Benoit wrote:
> >=20
> > > The concern of the people doing SW in these embedded processors was m=
ainly
> > > because we were releasing the reset of processor without loading any =
SW
> > > first
> > > and thus the processor was executing some random instructions.
> > >=20
> > > So if we consider a better hwmods definition, we can potentially fix =
the
> > > MMU
> > > case:
> > >=20
> > >      'mmu_ipu':
> > >          'rst_ipu_mmu_cache'
> > >=20
> > >      'mmu_dsp':
> > >          'rst_dsp_mmu_cache'
> > >=20
> > >      'iva_config':
> > >          'rst_logic'
> >=20
> > Wouldn't these still be "pseudo-hwmods?"  Or do each of these actually
> > have address space, interconnect ports, etc.?
>=20
> Yes, these ones are the only real IPs for MPU stand point, with interconn=
ect
> port and configuration registers.

These are the MMUs documented in Chapter 20 of the OMAP4430 TRM=20
vX, right? =20

I don't really understand the interaction of the hardreset lines with=20
these IPs.  Chapter 20 doesn't seem to mention the PRCM-controllable=20
hardreset lines at all.  It only mentions the OCP_SYSCONFIG registers=20
associated with them.

Meanwhile Table 3-375 "RM_DSP_RSTCTRL" mentions a DSP MMU, cache, and=20
slave interface reset line.  Is that referring to the same MMU that is=20
mentioned in Chapter 20?  The end of Section 20.2 "MMU Integration"=20
mentions two different DSP MMUs, a "shared cache MMU" and an "L2 MMU" -=20
maybe the hardreset line only pertains to the first MMU?

> > > But then we do have the processor resets that have to be exposed
> > > somewhere.
> > >=20
> > >      'ipu':
> > >          'rst_cpu0'
> > >          'rst_cpu1'
> > >=20
> > >      'dsp':
> > >          'rst_dsp'
> > >=20
> > >      'iva':
> > >          'rst_seq1'
> > >          'rst_seq2'
> > >=20
> > > None of these one should be controlled automatically.
> >=20
> > Don't we still want to put these IP blocks into reset until a driver fo=
r
> > these IP blocks is loaded?
>=20
> Yes, indeed, my point is where are we going to declare these reset lines =
if we
> do not have any fake hwmods to store them.

Wouldn't we associate them with the processor hwmods?  e.g.,=20
omap44xx_iva_hwmod, omap44xx_dsp_hwmod ?

> Well, for the MMU we can, these are regular IPs (almost). The real issues=
 was
> for the processors.

Omar, do you know  how these hardreset lines interact with the MMUs=20
described in the TRM Chapter 20?

> First they will have to release their driver :-)

Hehe, indeed.


- Paul
--155748971-1599479799-1334864800=:29048--
