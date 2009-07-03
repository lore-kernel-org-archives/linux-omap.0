From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH]OMAP4: McSPI Support for OMAP_4430
Date: Thu, 2 Jul 2009 17:27:11 -0700
Message-ID: <200907021727.12048.david-b@pacbell.net>
References: <38905.192.168.10.89.1246280107.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n16.bullet.mail.mud.yahoo.com ([68.142.206.43]:29722 "HELO
	n16.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751628AbZGCAuh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 20:50:37 -0400
In-Reply-To: <38905.192.168.10.89.1246280107.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Syed Rafiuddin <rafiuddin.syed@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On Monday 29 June 2009, Syed Rafiuddin wrote:
> This patch adds McSPI support for OMAP4430 SDP platform. All the base=
 addresses
> are changed between OMAP1/2/3 and OMAP4.The fields of the resource st=
ructures
> are filled at runtime to have McSPI support on OMAP4.
>=20
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

I'd add my ack if this patch weren't mangled.  :)


> ---
> =A0arch/arm/mach-omap2/devices.c | =A0 25 +++++++++++++++++++++----

Since *most* of this is arch/arm stuff, I think this patch
should go to mainine through Tony.  That's the best way to
make sure it doesn't cause conflicts with other patches he
sends.


> =A0drivers/spi/omap2_mcspi.c =A0 =A0 | =A0 10 ++++++----
> =A02 files changed, 27 insertions(+), 8 deletions(-)

None of this seemed particularly controversial.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
