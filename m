From: David Weinehall <tao@acc.umu.se>
Subject: Re: OMAP: Update OMAP keypad driver
Date: Fri, 17 Feb 2006 17:30:52 +0100
Message-ID: <20060217163052.GC20494@vasa.acc.umu.se>
References: <1139821011.5208.11.camel@two.research.nokia.com>
	<20060217151207.48903.qmail@web32904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060217151207.48903.qmail@web32904.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 17, 2006 at 07:12:07AM -0800, Komal Shah wrote:
> --- Juha Yrj=F6l=E4 <juha.yrjola@nokia.com> wrote:
>=20
> >=20
> > I was the one who removed that, since it breaks keypad support on all
> > OMAP24xx boards (except H4, I presume) that have Menelaus on them.=20
> > And
> > there are quite a few of those.
> >=20
> > Please submit a patch that moves the stuff above into board-h4.c.
> >=20
>=20
> I will submit that patch soon, having some problem in H4 setup right
> now.
>=20
> Before that can't we convert the code below in keypad to
>=20
> 253 down(&kp_enable_mutex);
> 254 	if (state !=3D kp_enable) {
> 255 	if (state)
> 256 		enable_irq(INT_KEYBOARD);
> 257 	else
> 258 		disable_irq(INT_KEYBOARD);
> 259 		kp_enable =3D state;
> 260 }
> 261 up(&kp_enable_mutex);

Either you've indented incorrectly here, or you have a bug.

[snip]


Regards: David Weinehall
--=20
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
