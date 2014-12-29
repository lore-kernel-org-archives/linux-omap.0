From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/3] usb: dwc3: add a quirk for device disconnection
 issue in Synopsis dwc3 core
Date: Mon, 29 Dec 2014 10:06:41 -0600
Message-ID: <20141229160641.GD29379@saruman>
References: <1418695828-605-1-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <1418695828-605-4-git-send-email-Sneeker.Yeh@tw.fujitsu.com>
 <20141222153730.GA12815@saruman>
 <CAJ1gpc3jVpz=5ME4+wCJDW5NKihvB4xYzwi0co=UuPtG9Ubmjg@mail.gmail.com>
 <CAJ1gpc3-Wjtm54WOhO6RXjZft9BMngzyYC0-S-XnTacV-qKgMg@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ1gpc3-Wjtm54WOhO6RXjZft9BMngzyYC0-S-XnTacV-qKgMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Mosberger <davidm-haPfTeumbwasTnJN9+BGXg@public.gmane.org>, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb
List-Id: linux-omap@vger.kernel.org

--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 29, 2014 at 04:07:50PM +0800, Sneeker Yeh wrote:
> Hi,
>=20
> 2014-12-29 14:41 GMT+08:00 Sneeker Yeh <sneeker.yeh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>=20
> > Hi,
> >
> > 2014-12-22 23:37 GMT+08:00 Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>:
> >
> >> On Tue, Dec 16, 2014 at 10:10:28AM +0800, Sneeker Yeh wrote:
> >> > Synopsis DesignWare USB3 IP Core integrated with a config-free
> >> > phy needs special handling during device disconnection to avoid
> >> > the host controller dying.
> >> >
> >> > This quirk makes sure PORT_CSC is cleared after the disable slot
> >> > command when usb device is disconnected from internal root hub,
> >> > otherwise, Synopsis core would fall into a state that cannot use
> >> > any endpoint command. Consequently, device disconnection procedure
> >> > might not be finished because sometimes endpoint need to be stop
> >> > by endpoint stop command issuing.
> >> >
> >> > Symptom usually happens when disconnected device is keyboard,
> >> > mouse, and hub.
> >>
> >> you need to point us to the synopsys STARS ticket number. That's the
> >> only way to reference this specific quirk. Add it to a comment
> >> somewhere.
> >>
> >
> > Thanks, we're still waiting for Synopsis STARS ticket number.
> > I'll add it to comment later.
> >
> >
> Sorry I didn't express myself clearly.
>=20
> So far Fujitsu Semiconductor got Synopsys internal case id , that is "
> Case: 8000679552".
> However the contents belongs this id cannot be referred except Fujitsu
> Semiconductor and Synopsys.
> Synopsis decide the official errata (STAR information) will be disclosed
> next February.
>=20
> Would you suggest if this quirk can be accepted with this case ID, or can
> only be accepted with STARS ticket number?

The thing is that without the STARS number I can't really verify which
versions of the IP would be affected. Clearly, it's not only your setup
and I think it's pretty unfair to have "is_compatible("fujitsu")" to
enable the quirk only for you. Isn't there a better way of enabling the
quirk based off of revision detection couple with a look on GHWPARAMS*
registers ?

What's tricking me is this claim that only config-free PHYs would be
affected, why ?

I still have many questions about this patch which are not answered by
commit log nor can I poke around on Synopsys solvnet for answers :-s

--=20
balbi

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUoXwRAAoJEIaOsuA1yqREBpsQALJPdrZ8vpH1bBY08O7kg9vH
6FGwvX+rSuy0ZjLJ9qJDSxJrMrrXVzt9zr5wv/T0HJxMDBCCR5a3isiLSXJU34RD
Cl1+9KPxa8rCkQsUa3UMfF9e0azMLnfhPWW8DNdWE8NHoQRVzCCvIBwAHBbI5yKj
xCfAErr62LbeWm6s3qG5mkcpsLQkrUZjuDU7pqlYd8B3m8CBNMRKGuA5GG7la7Uy
kVKPPjyf0GmHFQx8VPnVzp+84dhXBA2eBpVSX/WW0VxNI4ElJqcpv7UifuyrNaX3
RtwY/O78TIIu/Yo7+LpKFhBwwVWltq37NDmHVIYP3P5Z5YBR5TZbcjvBRbSC6EmY
HNRoO8eDqY57VKZ6wJ2MnZ1Ouqe/zEQLNGil1Ft+/oJ7DSesJbSt8rslgwoUiCdc
+utAHMrjxKvgPtgSf9IS8j1hlcpU/9ZpR7O/A1SPtv4DT50lUl4s1ZWDgmHDqnD5
CMKZ+cvYlt8FqmQUqi7ke+9XS9D7V0M0OeC55j504qEgsX/WneYokWXMClZNpuQy
yVHTPFvbUPLxxj9H08b5JitMRWlFr7RQJiWfDMyv5sEclpbnHWKkpIywo1JkWAMT
cOWho5mOTFx75FyH0GNdHOtkRMmlV9CrNyRL+0VZVu2+ePY5hVLZmcIPfxRRQuMl
nbwvxY/IfDK7TBnZ9Ex8
=4uzM
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
