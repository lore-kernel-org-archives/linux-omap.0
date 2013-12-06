From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: phy: am335x: Prevent GPIO reset line request
Date: Fri, 6 Dec 2013 14:16:23 -0600
Message-ID: <20131206201623.GB21086@saruman.home>
References: <1384984714-19860-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131120220212.GA12776@localhost>
 <528DC168.7090204@linutronix.de>
 <20131121113025.GA2942@localhost>
 <528DF233.40502@linutronix.de>
 <20131121115519.GC2942@localhost>
 <20131121130155.GC24559@saruman.home>
 <20131130224504.GA2446@localhost>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131130224504.GA2446@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2013 at 07:45:05PM -0300, Ezequiel Garcia wrote:
> On Thu, Nov 21, 2013 at 07:01:55AM -0600, Felipe Balbi wrote:
> > On Thu, Nov 21, 2013 at 08:55:20AM -0300, Ezequiel Garcia wrote:
> > > On Thu, Nov 21, 2013 at 12:44:51PM +0100, Sebastian Andrzej Siewior w=
rote:
> > > > On 11/21/2013 12:30 PM, Ezequiel Garcia wrote:
> > > > > Ah, good to know. That patch should be picked ASAP, without it th=
e USB
> > > > > in AM335x is broken. Is it already too late to -rc1?
> > > > Yes.
> > > >=20
> > > > > Who is supposed to merge that? Greg?
> > > >=20
> > > > Felipe will start collecting fixes once -rc1 is out [0] so it shoul=
d be
> > > > part of -rc2.
> > > >=20
> > >=20
> > > OK, fine by me. Please note that Felipe's commit is a much bigger (and
> > > nicer) rework of the code, and that it doesn't clearly state it fixes
> > > the current code.
> > >=20
> > > Felipe: Maybe you should add some message stating it fixes a regressi=
on?
> >=20
> > sure, makes sense. Sebastian had already mentioned it sounded too nice
> > of a commit log ;-)
> >=20
>=20
> I'm looking at -rc2 and it seems the fix was never pushed, so my board
> is probably still broken :-(
>=20
> Can anybody _please_please_ fix the issue by merging some fix so we can
> use USB with mainline?

it's in Greg's tree

--=20
balbi

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSojCXAAoJEIaOsuA1yqRE3MgQAJ2oI4l3syN8e0Z/tvn290bd
EUWIV5p6vsxpinhnaxG1OftmUSnQy6iqtz7XtgaurmGMGB2HmWC8ck9/T7demWMC
80+GsSPcRbTY+1FNZw1J1RFDbzd+62OOXMtxvRHGWFCJYTdAWduxrkql+FDDQVnY
Y0gHrBROVGSN9yM0qJK3rXu2bO5GP2ccjGnzrPf3KGRrYpTIEmnYTeTtwAShOHGA
+ASTG73bzXFHSHgQSuXbhiA3YsYuRx6WnALRRIiTczk4Vp5/nhLYsTOZCP2zIK6O
/z7TmEmhlW7gBfbVoqywl1en5g5WcokkS5vafNJJNCkut27TwIf3EvuYIhtWxx/P
AQSHx2x/KvlDnKjkoZcCcjvNKCuGae8cZPwboVDlAffKSVronSwZIW6CtJ+QctO4
VjHilEAIz2Qpb9x2maOSGQS4QkN/3CmBS4W809GeMOZFoCyUfe2lxOlbLkfUvAci
xroNPuNdMQ3bakeAcPFpMWtXQKXb6yRTm7WVv/gmLTWVyF6Iz5HtghFcHwyE1Jj3
oHmdEyG71IGTANWIM/PgmcbS6QpvAWh0rumF+afN6TAAzJHqPyUVC4H9dnav9ssU
TDiTzRaNZsI+fI0EMCzJKGJ6xOGwavHnIzex/shKO9fIVOAIQer9OPLkpIXm6w89
bitStmkyyjeQGq05aiy4
=/9ju
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
