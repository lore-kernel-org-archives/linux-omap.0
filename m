From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] OMAP: control: add functions for DSP boot
 address/mode control
Date: Mon, 11 Oct 2010 14:16:16 -0700
Message-ID: <20101011211616.GE25462@atomide.com>
References: <20101011203659.24425.2381.stgit@twilight.localdomain>
 <20101011203710.24425.94685.stgit@twilight.localdomain>
 <AANLkTimnQJxS_6PrgECeQFwEkNU=4-f5=bStWS-AtDcs@mail.gmail.com>
 <alpine.DEB.2.00.1010111449240.16871@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60435 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab0JKVQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 17:16:22 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1010111449240.16871@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, fernando.lugo@ti.com, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [101011 13:45]:
> (adding Tony)
>=20
> On Mon, 11 Oct 2010, Felipe Contreras wrote:
>=20
> > On Mon, Oct 11, 2010 at 11:37 PM, Paul Walmsley <paul@pwsan.com> wr=
ote:
> > > Add two functions for OMAP2430/OMAP3 IVA2 DSP boot control. =C2=A0=
These
> > > registers wound up in the System Control Module. =C2=A0Other kern=
el code
> > > that wishes to control the DSP's boot process should now use thes=
e
> > > functions to do so; subsequent patches implement this in the two
> > > in-tree users of these functions.
> > >
> > > This patch is functionally untested; that is for the DSP/Bridge
> > > programmers to do.
> > >
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > ---
> > > =C2=A0arch/arm/mach-omap2/control.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 51 ++++++++++++++++++++++++++
> > > =C2=A0arch/arm/mach-omap2/control.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 16 +++++---
> > > =C2=A0arch/arm/plat-omap/include/plat/iva2_dsp.h | =C2=A0 56 ++++=
++++++++++++++++++++++++
> > > =C2=A03 files changed, 116 insertions(+), 7 deletions(-)
> > > =C2=A0create mode 100644 arch/arm/plat-omap/include/plat/iva2_dsp=
=2Eh
> >=20
> > This doesn't seem to be aligned with staging-next, that's where
> > tidspbridge is supposed to reside.
>=20
> The patch series is based on Tony's current tree.  It is not intended=
 to=20
> be applied as-is.  The series is meant for people working on DSPBridg=
e to=20
> know what the expectations are of the OMAP maintainers, and also to g=
ive=20
> them a quick way forward to getting their code to compile again.

This series seems like a sane way to sort out the dspbridge control
register tinkering.
=20
> > I proposed this patch to be applied to linux-omap, but I guess it d=
idn't=20
> > seem necessary at the time:=20
> > http://article.gmane.org/gmane.linux.kernel/1044209
>=20
> I doubt that that's the reason, but you'd have to ask Tony about the=20
> details.  But I'd NACK it due to the PRM/CM function pointers.  As I=20
> mentioned in the previous messages, no driver should be touching PRM/=
CM=20
> bits directly.

Hmm I acked that patch, but considering the above it should be updated
according to Paul's comments.

Would be nice to get the dspbridge into working shape. Sounds we still
need the following:

- memblock fixes
- this series to fix the control module related issues
- platform data for the boards

Is that all, or are we also missing something else?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
