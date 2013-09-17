From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/2] ARM: OMAP: Add secure function omap_smc3()
 which calling instruction smc #1
Date: Tue, 17 Sep 2013 08:43:31 -0700
Message-ID: <20130917154331.GA9994@atomide.com>
References: <20130916171023.GA17477@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130916171023.GA17477@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, "nm@ti.com" <nm@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>, "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Dave Martin <Dave.Martin@arm.com> [130916 10:18]:
> On Sat, Sep 14, 2013 at 10:37:12AM +0100, Pali Roh=C3=A1r wrote:
> > On Sunday 08 September 2013 09:43:29 Pali Roh=C3=A1r wrote:
> > > + */
> > > +ENTRY(omap_smc3)
> > > +	stmfd	sp!, {r4-r11, lr}
> > > +	mov	r12, r0		@ Copy the secure service ID
> > > +	mov	r6, #0xff	@ Indicate new Task call
> > > +	dsb			@ Memory Barrier (not sure if needed, copied from
> > > omap_smc2) +	smc	#1		@ Call PPA service
> > > +	ldmfd	sp!, {r4-r11, pc}
> > > +ENDPROC(omap_smc3)
> > > +
> > >  ENTRY(omap_modify_auxcoreboot0)
> > >  	stmfd   sp!, {r1-r12, lr}
> > >  	ldr	r12, =3D0x104
> >=20
> > Dave, it is ok now?
>=20
> Yes, that's sufficient to warn people to stop and think (at least, if
> someone copy-pastes it, they will likely highlight the possible error=
 by
> copy-pasting the comment too).  Thanks.
>=20
> Acked-by: Dave Martin <Dave.Martin@arm.com>

Have you guys checked how this works with the recently posted
"[PATCH v6 0/5] ARM: support for Trusted Foundations secure monitor"
series?

Regards,

Tony
=20
