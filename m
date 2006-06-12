From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add minimal OMAP2430 support
Date: Mon, 12 Jun 2006 09:07:46 -0700
Message-ID: <20060612160745.GA5942@atomide.com>
References: <448C208F.4020102@solidboot.com>
	<20060612064309.71669.qmail@web37904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060612064309.71669.qmail@web37904.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060611 23:45]:
> --- Juha Yrj=F6l=E4 <juha.yrjola@solidboot.com> wrote:
>=20
> >=20
> > Exactly.  That's why I keep my read_reg/write_reg functions static.=20
> > Usually I put even the register definitions to the .c file, since
> > other=20
> > drivers shouldn't have any business modifying them directly anyway.
> >=20
>=20
> Have them static prcm_read/write_reg means, that clock.c and prcm.c
> should be merged, as clock.c is the heaviest user of PRCM/CM_*
> registers as of now, and only having static prcm_read/write_reg
> functions in prcm.c doesn't solve usage PRCM_* registers from clock.c?

Or put clock related PRCM registers to clock.c, power domain related
registers to pm-domain.c and so on. I have pm-domain.c somewhat ready
here and will push it as soon as I can.

Regards,

Tony
