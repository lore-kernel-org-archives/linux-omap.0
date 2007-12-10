From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 3/3] ARM: OMAP: Add MUSB support for OMAP34xx
Date: Mon, 10 Dec 2007 10:53:58 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804FE6936@dbde01.ent.ti.com>
References: <87ve7d3p2c.fsf@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <87ve7d3p2c.fsf@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> > +static void musb_do_idle(unsigned long _musb)
> > +{
> > +	struct musb	*musb =3D (void *)_musb;
> > +	unsigned long	flags;
> > +	u8	power;
> > +	u8	devctl;
> > +
> > +	devctl =3D musb_readb(musb->mregs, MUSB_DEVCTL);
> > +
> > +	spin_lock_irqsave(&musb->lock, flags);
>=20
> This lock is never unlocked.
>=20
> Might I recommend you turn on CONFIG_PREEMPT, and spinlock debugging
> when testing.  The various lock debugging features in the 'Kernel
> Hacking' menu are extremely useful for this kind of thing.

Thanks for the pointer. I'll start using this from now on.

Anand
