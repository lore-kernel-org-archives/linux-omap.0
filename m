From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] To add OMAP 2430 Support
Date: Thu, 9 Nov 2006 09:01:28 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50884C5B8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7040F.F5A2C971"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7040F.F5A2C971
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Yes this in theory it is needed.  It is ARM implementation dependent on
whether it is needed or not.

I've included a small graphics (hope it makes it) to help clarify.  The
TRM also had a section on this.

- The ARM-CPU has 4 ports of interest here.  An instruction read (IR), a
data read (DR), a data write (DW), and the peripheral port (PP).

- There is a write-buffer between the ARM and the peripheral port (there
is also a familiar write buffer between the ARM and its data port).  A
write to the port does not necessarily happen immediately.
 =20
- The ARM internal pipeline is NOT synchronized with the peripheral port
but it is with the others.  This means dependencies are tracked with
register and CPSR accesses.  This means a write to the DR can cause the
pipeline to stall.  When you write to the PP the pipeline will never
stall. =20

** This means you can write to acknowledge an interrupt then enable
interrupts at the CPSR and the write to the CPSR can overtake the ACK to
the PP.  You now have a spurious interrupt.  There are a few some
combinations.

Interestingly, the L3 bus on the other side of the AHB2OCP bridge also
has multiple hardware threads and you can have times where accesses to
one port can overtake others.  This is all ok with ARM11 as it is
specified to have out of order operations as long as it can tell any
dependencies/hazards have been taken care of.  How much this happens in
practice depends on the memory system of the implementer.  There a lot
of ARM11 memory system optimizations which the standard ARM kernel does
not take advantage of today.  It takes the simple road with marking
things as strongly ordered.

Regards,
Richard W.

> Looks OK in general, just one comment below.
>=20
> > +#define sync_p_port_write()	\
> > +	({ int dv =3D 0;	\
> > +		 __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 4" : :
"r"
> (dv));	\
> > +	})
> > +
> > /*
> >  * OMAP2 has a number of different interrupt controllers, each
interrupt
> >  * controller is identified as its own "bank". Register definitions
are
> > @@ -48,6 +53,7 @@ static struct omap_irq_bank {
> > static void omap_ack_irq(unsigned int irq)
> > {
> > 	__raw_writel(0x1, irq_banks[0].base_reg + INTC_CONTROL);
> > +	sync_p_port_write();
> > }
> >
> > static void omap_mask_irq(unsigned int irq)
>=20
> I'd leave this out of the patch for now until we know if it's
> still needed. If it's needed, there should probably be arm generic
> function for it. Maybe dwb() or something like that? :)
>=20
> I think at some point Richard Woodruff said that he had to drain
> write buffer for timer writes because of some inaccuracy. Richard,
> could you please clarify it again? I don't think I've seen these
> issues on 2420 myself, but maybe some timer test code could expose
> it?
>=20
> Regards,
>=20
> Tony

------_=_NextPart_001_01C7040F.F5A2C971
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7040F.F5A2C971--
