From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
Date: Tue, 17 Nov 2009 14:24:10 -0800
Message-ID: <20091117222409.GH29266@atomide.com>
References: <20091116133237.14128.39687.stgit@localhost.localdomain>
 <20091116133654.14128.175.stgit@localhost.localdomain>
 <20091116140830.GA31522@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.0911171036430.27682@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA689E6A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55752 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbZKQWYa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 17:24:30 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA689E6A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Juha =?iso-8859-1?Q?Lepp=E4nen?= <juha_motorsportcom@luukku.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [091117 09:50]:
> Paul
>=20
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger=
=2Ekernel.org] On Behalf Of Paul
> >Walmsley
> >Sent: Tuesday, November 17, 2009 11:39 AM
> >To: Russell King - ARM Linux
> >Cc: linux-arm-kernel@lists.infradead.org; Juha Lepp=E4nen; linux-oma=
p@vger.kernel.org
> >Subject: Re: [PATCH 3/3] OMAP clock/hwmod: fix off-by-one errors
> <snip>
> >
> >+/**
> >+ * omap_test_timeout - busy-loop, testing a condition
> >+ * @cond: condition to test until it evaluates to true
> >+ * @timeout: maximum number of microseconds in the timeout
> >+ * @index: loop index (integer)
> >+ *
> >+ * Loop waiting for @cond to become true or until at least @timeout
> >+ * microseconds have passed.  To use, define some integer @index in=
 the
> >+ * calling code.  After running, if @index =3D=3D @timeout, then th=
e loop has
> >+ * timed out.
> >+ */
> >+#define omap_test_timeout(cond, timeout, index)			\
> >+({								\
> >+	for (index =3D 0; index < timeout; index++) {		\
> >+		if (cond)					\
> >+			break;					\
> >+		udelay(1);					\
> >+	}							\
> >+})
> >+
>=20
> There is a similar kind of function implemented in USB host, that ret=
urns -ETIMEDOUT
> Which makes more sense for failure case.
>=20
> Maybe such a generic function for all omaps is needed.
>=20
> Refer:
> drivers/usb/host/ehci-hcd.c
> static int handshake (struct ehci_hcd *ehci, void __iomem *ptr,
>                       u32 mask, u32 done, int usec)
> {
>         u32     result;
>=20
>         do {
>                 result =3D ehci_readl(ehci, ptr);
>                 if (result =3D=3D ~(u32)0)          /* card removed *=
/
>                         return -ENODEV;
>                 result &=3D mask;
>                 if (result =3D=3D done)
>                         return 0;
>                 udelay (1);
>                 usec--;
>         } while (usec > 0);
>         return -ETIMEDOUT;
> }
>=20
>=20
> > #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */

Well we need to stick to minimal changes if we plan to send this in as =
a fix.
Anything more complex we should do the next merge window.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
