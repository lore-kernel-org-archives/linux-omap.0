From: Felipe Balbi <balbi@ti.com>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Thu, 9 Oct 2014 16:07:15 -0500
Message-ID: <20141009210715.GH25729@saruman>
References: <20140904192535.GJ13421@saruman.home>
 <20140904200403.GL13421@saruman.home>
 <20140905213216.GD5001@linux.vnet.ibm.com>
 <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman>
 <20141008212938.GP22688@saruman>
 <20141009160138.GA2396@cmpxchg.org>
 <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian>
 <20141009204637.GE25729@saruman>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5507607834493297389=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141009204637.GE25729@saruman>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Rik van Riel <riel@redhat.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, josh@joshtriplett.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rabin Vincent <rabin@rab.in>, Alan Stern <stern@rowland.harvard.edu>, Johannes Weiner <hannes@cmpxchg.org>, Sasha Levin <sasha.levin@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul
 E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============5507607834493297389==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline

--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 09, 2014 at 03:46:37PM -0500, Felipe Balbi wrote:
> On Thu, Oct 09, 2014 at 10:41:01PM +0200, Rabin Vincent wrote:
> > On Thu, Oct 09, 2014 at 11:26:56AM -0500, Felipe Balbi wrote:
> > > alright, it's pretty deterministic however. Always on the same test, =
no
> > > matter which USB controller, no matter if backing store is RAM or MMC.
> > >=20
> > > Those two undefined instructions on the disassembly caught my attenti=
on,
> > > perhaps I'm facing a GCC bug ?
> >=20
> > The undefined instructions are just ARM's BUG() implementation.
> >=20
> > But did you see the question I asked you yesterday in your other thread?
> > http://www.spinics.net/lists/arm-kernel/msg368634.html
>=20
> hmm, completely missed that, sorry. I'm using 4.8.2, will try something
> else.

seems to be working fine now, thanks. I'll leave test running overnight
just in case.

thanks again, and sorry for the noise.

PS: I wonder if we should a warning message to the build system if we're
building with known broken versions of GCC.

--=20
balbi

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNvkDAAoJEIaOsuA1yqREEVsP/2SxJIVCFQ/Ulti5FMBUKRs/
MTOe7euqjdN8apn1xHhG/5TLuxLiV5t4rLCXBxEmmySxuN+0CzOWGYaoGWxr+2RT
HucKWC1+alYTgV+W+uI2t+77ZAjjWe9+rkuWl3n+JP/eCZ/okFWS6vF+vG9k++Y2
tqluQNOA9tmZk0GiQ5a/tyF/27vfnVqSook+TPuV5UEYCghxyGHG/UWzKn3fUY0D
e+n6Mqsq8E7R+ilnue9aJjTcWiAv14do1rDWNu+ZPl6Kx3u4jnW+Ok4IZE2xTdp3
OBLTK9weBNBJwqSp2m0zU8wXc2BEKBgMgQcAAfkbUxy/brI+gDnGtbUif5QsSy+t
dDu3e68KflwJHqhwbzg67I7Z89KZASFbt4+gqq86dSZnV82Jn6lrvgiFB3vroDO7
AJMYRGmj6faT41doDkiyrqjxRVJmBjUspgBsQASMRyAWGtoKWfa5h5Bq6Au0M9Uf
lUXcdz1pJsXldll/bpr0fwYAZZiah1arkVZ5uN1+KxoJRmrbnvdWN97BCK6Rm6i1
oBJjhysNEKOD/aY1FayFjwEUZ/jksujSqaR5YjT3ci21tYBUGrqe1DwGqyQLEg1R
h+ZKElR6JcsBUYO8nK3Xm1zGQ3IkHkutGn/rLIwpC5ZpSEfe6O9vxch1dOwsH8Dq
HGwP0I+2mUZfSlJHhqU0
=QSKq
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--


--===============5507607834493297389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5507607834493297389==--
