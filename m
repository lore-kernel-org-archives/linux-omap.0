From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: RCU bug with v3.17-rc3 ?
Date: Thu, 9 Oct 2014 15:35:05 -0500
Message-ID: <20141009203505.GD25729@saruman>
References: <20140904184021.GA13421@saruman.home>
 <20140904191642.GJ5001@linux.vnet.ibm.com>
 <20140904192535.GJ13421@saruman.home>
 <20140904200403.GL13421@saruman.home>
 <20140905213216.GD5001@linux.vnet.ibm.com>
 <20141008171322.GH22688@saruman>
 <20141008175707.GI22688@saruman>
 <20141008212938.GP22688@saruman>
 <20141009160138.GA2396@cmpxchg.org>
 <20141009162656.GE16002@saruman>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141009162656.GE16002@saruman>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Johannes Weiner <hannes-druUgvl0LCNAfugRpC6u6w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Sasha Levin <sasha.levin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, josh-iaAMLnmF4UmaiuxdJuQwMA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rik van Riel <riel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 09, 2014 at 11:26:56AM -0500, Felipe Balbi wrote:
> > I'm thinking it's not the slot pointer itself that's bad, because
> > __radix_tree_lookup() dereferences that to test if it's populated
> > before returning it, and slot life-time is guaranteed by RCU.
> >=20
> > That would only leave garbage in the slot itself, crashing during
> > page_cache_get_speculative().
> >=20
> > I'll keep staring at this change, but nothing stands out to me yet.
>=20
> alright, it's pretty deterministic however. Always on the same test, no
> matter which USB controller, no matter if backing store is RAM or MMC.
>=20
> Those two undefined instructions on the disassembly caught my attention,
> perhaps I'm facing a GCC bug ?

no, probably not a GCC bug. Looking at your commit, however. Man, it
does quite many things at once. Moves code around, adds new functions by
refactoring (and changing) code, renames things, changes int offset into
unsigned ints. Should not be too difficult too to miss a bug in there.

I'll continue digging here.

--=20
balbi

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUNvF5AAoJEIaOsuA1yqREvJIP+wQJ3fR8DoSTWlOFZH1MCSeP
pdwbMse8Z8VBC5zRXxF8HMIRGc7ve95qTnDs0TQdhvIR2/EMDXxhDQ8DLnT04JuO
/azKTutBsdK8Axe/czbTMNUspplcVpyWgFuPU9f3rgre5QhTJXryNUz1H3+tnAc2
cwA/8j6wqbVxVIpwZW/Kdozg8QI+T4TO1VGHnsWwYNhjIGnOM5QgMPHDIQJdJc37
SkMifnZTrtwBRGc1xhLPCNuQ/FoHh3Cu4LXKM90sOWMjRcTNr1dK/hnwM7fEVZJF
ByemvzJVxA8EOcoOOUuFoa5J3ow28XNg+kRTIps0PauVyPBL/Xza5JaURMMb97/F
VFd7INn467ZnBsZxnUDt0qjx/0GYwujTrlJbbp0QPKfjhO7dGgGqa3VJXTXV5eRQ
njeUqdcEAgiuPU6CqwboLAgSjODUTE3v3jUdc2EBsq1Hazop7+1cvxCseuKLlc68
r6GiLCn2mvYFIHz1125v/5pGxA6OfkRjaS8A1/U4tA1Wzf0dp/MKi749YfWQ13bD
SfyWycfBI4gbnZb2ZQqGw4htjnzg31ObQCZLTMjn0j0jzftL7TFWily+9Y3L4WQ7
6RetlWcIoxH0iiLqsk3RwtrtaztC2fSu7J7pH3KgbttUzJ7GBIfTXf774MgwIZhd
16HADnJ9B5NEtw608Lgd
=CsDM
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
