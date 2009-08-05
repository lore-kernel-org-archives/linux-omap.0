From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]OMAP4: McSPI Support for OMAP_4430
Date: Wed, 5 Aug 2009 11:58:15 +0300
Message-ID: <20090805085815.GC7374@atomide.com>
References: <38905.192.168.10.89.1246280107.squirrel@dbdmail.itg.ti.com> <200907021727.12048.david-b@pacbell.net> <EAF47CD23C76F840A9E7FCE10091EFAB02B55019A3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57120 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674AbZHEI6U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 04:58:20 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B55019A3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090703 07:52]:
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org=20
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of David Browne=
ll
> > Sent: Friday, July 03, 2009 5:57 AM
> > To: Syed, Rafiuddin
> > Cc: spi-devel-general@lists.sourceforge.net;=20
> > linux-omap@vger.kernel.org
> > Subject: Re: [PATCH]OMAP4: McSPI Support for OMAP_4430
> >=20
> > On Monday 29 June 2009, Syed Rafiuddin wrote:
> > > This patch adds McSPI support for OMAP4430 SDP platform.=20
> > All the base addresses
> > > are changed between OMAP1/2/3 and OMAP4.The fields of the=20
> > resource structures
> > > are filled at runtime to have McSPI support on OMAP4.
> > >=20
> > > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> > > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> > > Acked-by: Tony Lindgren <tony@atomide.com>
> > > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >=20
> > I'd add my ack if this patch weren't mangled.  :)
> >=20
> > > ---
> > > =A0arch/arm/mach-omap2/devices.c | =A0 25 +++++++++++++++++++++--=
--
> >=20
> > Since *most* of this is arch/arm stuff, I think this patch
> > should go to mainine through Tony.  That's the best way to
> > make sure it doesn't cause conflicts with other patches he
> > sends.
>=20
> Tony suggested that this patch can be sent through SPI mailing list.
> Refer this thread.
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14011.html=20

Just to confirm, this is OK for me to merge via the SPI once the
mangling is removed.

Tony



> >=20
> > > =A0drivers/spi/omap2_mcspi.c =A0 =A0 | =A0 10 ++++++----
> > > =A02 files changed, 27 insertions(+), 8 deletions(-)
> >=20
> > None of this seemed particularly controversial.
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
