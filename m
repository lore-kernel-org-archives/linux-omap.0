From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Mon, 4 Mar 2013 10:58:06 -0800
Message-ID: <20130304185806.GS11806@atomide.com>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
 <CAGo_u6omQdSzpfthHNAU1UvgSvkgq3ZC6g1Ha9oi0nc9QJ71nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGo_u6omQdSzpfthHNAU1UvgSvkgq3ZC6g1Ha9oi0nc9QJ71nA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon@abv.bg>, pali.rohar@gmail.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [130301 06:42]:
> On Fri, Mar 1, 2013 at 1:47 AM, =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE =
=D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2 <freemangordon@abv.bg>=
 wrote:
> >
> > They look similar, but they are not equivalent :). The first major =
difference is here (code taken from omap-smc.S)
> >
> >> ENTRY(omap_smc2)
> >>          stmfd   sp!, {r4-r12, lr}
> >>          mov     r3, r2
> >>          mov     r2, r1
> >>          mov     r1, #0x0        @ Process ID
> >>          mov     r6, #0xff
> >>          mov     r12, #0x00      @ Secure Service ID
> >
> > Always zero, while RX51 PPA expects a real value. I wonder if it is=
 a bug, but anyway I don't see the id parameter (R0) used.
> >
> >>          mov     r7, #0
> >>          mcr     p15, 0, r7, c7, c5, 6
> >
> > According to ARM TRM, this is "Invalidate entire branch predictor a=
rray"(IIUC). NFC why it is needed here, but this will not work on RX-51=
 until IBE bit in ACR is set.
> >
> >>          dsb
> >>          dmb
> >>          smc     #0
> >
> > RX-51 needs smc #1 ;)
> >
> >>          ldmfd   sp!, {r4-r12, pc}
> >
> >
> > The next major difference is that RX-51 expects parameter count pas=
sed in R3[0] to be the count of the remaining parameters +1, but omap_s=
ecure_dispatcher (in omap-secure.c) is passing the exact count of the r=
emaining parameters.
> >
> > I guess all of the above problems can be fixed/workarounded, but I =
wonder does it worth. Not to say that I don't have BB around to test if=
 the code still works if I make changes to omap2-secure.c/omap-smc.S :)
> >
> >
>=20
> Yep, that was my point - instead of introducing new functions,
> extending the existing functions to handle new requirements is better
> solution, IMHO.

I think there have been patches posted for ARM generic SMC
handling. Might be worth looking at those a bit and see if
this can be made generic. I think only the SMC call numbering
is different for various SoCs?

Regards,

Tony
