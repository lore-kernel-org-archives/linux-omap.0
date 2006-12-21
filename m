From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for apollon
Date: Thu, 21 Dec 2006 16:19:35 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4708E6E0@dlee13.ent.ti.com>
References: <20061221215755.GE10399@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20061221215755.GE10399@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> AFAIK we _should_ be able to use level GPIO interrupts on all omap2
> systems. I wonder why that does not work on apollon?=20

> Is there some
> difference in hardware, or maybe some GPIO lines don't support level
> interrupts on omap2?

All GPIO lines on OMAP2 have similar kind of attributes. SMC can operate
on both edge and level sensitive interrupts. On few boards they route
this interrupt through FPGA or some logic that expects this sort of
changes to GPIO interrupt line. Overall it is a board related than OMAP2
or SMC.

In future we can expect more changes to this particular IRQ depending on
the board design (definitely not for 3430SDP :).

Regards,
Khasim


> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Tony Lindgren
> Sent: Thursday, December 21, 2006 3:58 PM
> To: Dirk Behme
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: [PATCH] ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for
apollon
>=20
> * Dirk Behme <dirk.behme@googlemail.com> [061221 01:43]:
> >
> > ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for apollon
> >
> > As reported by Kyungmin Park, ethernet IRQF_TRIGGER flag for
> > apollon has to be IRQF_TRIGGER_RISING instead of
> > IRQF_TRIGGER_HIGH.
> >
> > Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> >
>=20
> > Index: linux-osk/drivers/net/smc91x.h
> > =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-osk.orig/drivers/net/smc91x.h
> > +++ linux-osk/drivers/net/smc91x.h
> > @@ -198,7 +198,7 @@ SMC_outw(u16 val, void __iomem *ioaddr,
> >  				? IRQF_TRIGGER_RISING :
IRQF_TRIGGER_FALLING)
> >  #else
> >  #define SMC_IRQ_FLAGS		(machine_is_omap_apollon()
\
> > -				? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW)
> > +				? IRQF_TRIGGER_RISING :
IRQF_TRIGGER_LOW)
> >  #endif
> >
> >  #elif	defined(CONFIG_SH_SH4202_MICRODEV)
> >
>=20
> AFAIK we _should_ be able to use level GPIO interrupts on all omap2
> systems. I wonder why that does not work on apollon? Is there some
> difference in hardware, or maybe some GPIO lines don't support level
> interrupts on omap2?
>=20
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
