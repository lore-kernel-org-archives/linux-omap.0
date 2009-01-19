From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/10] omap mailbox: add save_/restore_ctx() for PM
Date: Mon, 19 Jan 2009 22:00:12 +0000
Message-ID: <20090119220012.GB31848@n2100.arm.linux.org.uk>
References: <20090116082737.17571.53738.stgit@oreo.research.nokia.com> <20090117171044.GE12341@n2100.arm.linux.org.uk> <20090117172037.GF12341@n2100.arm.linux.org.uk> <20090119.123612.153133347.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42560 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103AbZASWA2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 17:00:28 -0500
Content-Disposition: inline
In-Reply-To: <20090119.123612.153133347.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, Jan 19, 2009 at 12:36:12PM +0200, Hiroshi DOYU wrote:
> Hi Russell, Thank you for your review.
>=20
> From: "ext Russell King - ARM Linux" <linux@arm.linux.org.uk>
> Subject: Re: [PATCH 07/10] omap mailbox: add save_/restore_ctx() for =
PM
> Date: Sat, 17 Jan 2009 17:20:37 +0000
>=20
> > On Sat, Jan 17, 2009 at 05:10:44PM +0000, Russell King - ARM Linux =
wrote:
> > > On Fri, Jan 16, 2009 at 10:27:37AM +0200, Hiroshi DOYU wrote:
> > > > diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap=
2/mailbox.c
> > > > index a877305..544dde9 100644
> > > > --- a/arch/arm/mach-omap2/mailbox.c
> > > > +++ b/arch/arm/mach-omap2/mailbox.c
>=20
> [...]
>=20
> > Hmm, don't forget 'i' is an offset not an index, so...
> >=20
> > =A3define MBOX_NR_REGS (MBOX_REG_SIZE / sizeof(u32))
> >=20
> > 	for (i =3D 0; i < MBOX_NR_REGS; i++) {
> > 		p->ctx[i] =3D mbox_read_reg(i * sizeof(u32));
>=20
> The updated one is attached.

=2E.. which looks much better, thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
