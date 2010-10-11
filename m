From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] OMAP: control: add functions for DSP boot address/mode
 control
Date: Mon, 11 Oct 2010 14:53:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010111449240.16871@utopia.booyaka.com>
References: <20101011203659.24425.2381.stgit@twilight.localdomain> <20101011203710.24425.94685.stgit@twilight.localdomain> <AANLkTimnQJxS_6PrgECeQFwEkNU=4-f5=bStWS-AtDcs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1871606051-1286830423=:16871"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60807 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705Ab0JKUxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 16:53:44 -0400
In-Reply-To: <AANLkTimnQJxS_6PrgECeQFwEkNU=4-f5=bStWS-AtDcs@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, Felipe Contreras <felipe.contreras@gmail.com>
Cc: fernando.lugo@ti.com, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1871606051-1286830423=:16871
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

(adding Tony)

On Mon, 11 Oct 2010, Felipe Contreras wrote:

> On Mon, Oct 11, 2010 at 11:37 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > Add two functions for OMAP2430/OMAP3 IVA2 DSP boot control. =C2=A0These
> > registers wound up in the System Control Module. =C2=A0Other kernel cod=
e
> > that wishes to control the DSP's boot process should now use these
> > functions to do so; subsequent patches implement this in the two
> > in-tree users of these functions.
> >
> > This patch is functionally untested; that is for the DSP/Bridge
> > programmers to do.
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > ---
> > =C2=A0arch/arm/mach-omap2/control.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 51 ++++++++++++++++++++++++++
> > =C2=A0arch/arm/mach-omap2/control.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 16 +++++---
> > =C2=A0arch/arm/plat-omap/include/plat/iva2_dsp.h | =C2=A0 56 ++++++++++=
++++++++++++++++++
> > =C2=A03 files changed, 116 insertions(+), 7 deletions(-)
> > =C2=A0create mode 100644 arch/arm/plat-omap/include/plat/iva2_dsp.h
>=20
> This doesn't seem to be aligned with staging-next, that's where
> tidspbridge is supposed to reside.

The patch series is based on Tony's current tree.  It is not intended to=20
be applied as-is.  The series is meant for people working on DSPBridge to=
=20
know what the expectations are of the OMAP maintainers, and also to give=20
them a quick way forward to getting their code to compile again.

> I proposed this patch to be applied to linux-omap, but I guess it didn't=
=20
> seem necessary at the time:=20
> http://article.gmane.org/gmane.linux.kernel/1044209

I doubt that that's the reason, but you'd have to ask Tony about the=20
details.  But I'd NACK it due to the PRM/CM function pointers.  As I=20
mentioned in the previous messages, no driver should be touching PRM/CM=20
bits directly.


- Paul
--155748971-1871606051-1286830423=:16871--
