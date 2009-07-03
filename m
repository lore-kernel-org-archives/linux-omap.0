From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH]OMAP4: McSPI Support for OMAP_4430
Date: Fri, 3 Jul 2009 10:21:52 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B55019A3@dbde02.ent.ti.com>
References: <38905.192.168.10.89.1246280107.squirrel@dbdmail.itg.ti.com>
 <200907021727.12048.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46432 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbZGCEwD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jul 2009 00:52:03 -0400
In-Reply-To: <200907021727.12048.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>
Cc: "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of David Brownell
> Sent: Friday, July 03, 2009 5:57 AM
> To: Syed, Rafiuddin
> Cc: spi-devel-general@lists.sourceforge.net;=20
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH]OMAP4: McSPI Support for OMAP_4430
>=20
> On Monday 29 June 2009, Syed Rafiuddin wrote:
> > This patch adds McSPI support for OMAP4430 SDP platform.=20
> All the base addresses
> > are changed between OMAP1/2/3 and OMAP4.The fields of the=20
> resource structures
> > are filled at runtime to have McSPI support on OMAP4.
> >=20
> > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>=20
> I'd add my ack if this patch weren't mangled.  :)
>=20
> > ---
> > =A0arch/arm/mach-omap2/devices.c | =A0 25 +++++++++++++++++++++----
>=20
> Since *most* of this is arch/arm stuff, I think this patch
> should go to mainine through Tony.  That's the best way to
> make sure it doesn't cause conflicts with other patches he
> sends.

Tony suggested that this patch can be sent through SPI mailing list.
Refer this thread.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14011.html=20
>=20
> > =A0drivers/spi/omap2_mcspi.c =A0 =A0 | =A0 10 ++++++----
> > =A02 files changed, 27 insertions(+), 8 deletions(-)
>=20
> None of this seemed particularly controversial.
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
