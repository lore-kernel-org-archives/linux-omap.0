From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/10] omap mailbox: add save_/restore_ctx() for PM
Date: Sat, 17 Jan 2009 17:20:37 +0000
Message-ID: <20090117172037.GF12341@n2100.arm.linux.org.uk>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com> <20090116082737.17571.53738.stgit@oreo.research.nokia.com> <20090117171044.GE12341@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54137 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338AbZAQRUv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2009 12:20:51 -0500
Content-Disposition: inline
In-Reply-To: <20090117171044.GE12341@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sat, Jan 17, 2009 at 05:10:44PM +0000, Russell King - ARM Linux wrot=
e:
> On Fri, Jan 16, 2009 at 10:27:37AM +0200, Hiroshi DOYU wrote:
> > diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/ma=
ilbox.c
> > index a877305..544dde9 100644
> > --- a/arch/arm/mach-omap2/mailbox.c
> > +++ b/arch/arm/mach-omap2/mailbox.c
> > @@ -32,6 +32,8 @@
> >  #define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
> >  #define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
> > =20
> > +#define MBOX_REG_SIZE			0x120
> > +
> >  static void __iomem *mbox_base;
> > =20
> >  struct omap_mbox2_fifo {
> > @@ -47,6 +49,7 @@ struct omap_mbox2_priv {
> >  	unsigned long irqstatus;
> >  	u32 newmsg_bit;
> >  	u32 notfull_bit;
> > +	char ctx[MBOX_REG_SIZE];
>=20
> 	u32 ctx[MOX_REG_SIZE / sizeof(u32)];
>=20
> ?
>=20
> >  };
> > =20
> >  static struct clk *mbox_ick_handle;
> > @@ -167,6 +170,36 @@ static int omap2_mbox_is_irq(struct omap_mbox =
*mbox,
> >  	return (enable & status & bit);
> >  }
> > =20
> > +static void omap2_mbox_save_ctx(struct omap_mbox *mbox)
> > +{
> > +	int i;
> > +	struct omap_mbox2_priv *p =3D mbox->priv;
> > +
> > +	for (i =3D 0; i < MBOX_REG_SIZE; i +=3D sizeof(u32)) {
> > +		u32 val;
> > +
> > +		val =3D mbox_read_reg(i);
> > +		*(u32 *)(p->ctx + i) =3D val;
>=20
> 		p->ctx[i] =3D mbox_read_reg(i);

Hmm, don't forget 'i' is an offset not an index, so...

=A3define MBOX_NR_REGS (MBOX_REG_SIZE / sizeof(u32))

	for (i =3D 0; i < MBOX_NR_REGS; i++) {
		p->ctx[i] =3D mbox_read_reg(i * sizeof(u32));

(you'll have to excuse the '=A3' there - my keyboard currently does not=
 have
a 'hash' key for some Fedora 9 post upgrade silly reason.)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
