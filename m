From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC] possible removal of omap-serial
Date: Fri, 21 Mar 2014 12:36:53 -0500
Message-ID: <20140321173653.GP12310@saruman.home>
References: <20140320235210.GB26964@saruman.home>
 <20140321001228.GA18131@kroah.com>
 <20140321013557.GB29691@saruman.home>
 <20140321013729.GC29691@saruman.home>
 <20140321023646.GB17404@kroah.com>
 <CAOCHtYhwuAJy-=LJV=eFwzwqzDDPv5RngQ2dVJDOPhYT+J_Mvw@mail.gmail.com>
 <20140321025238.GA31610@saruman.home>
 <20140321171029.GC3842@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YttKMwf6abDJOSyE"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140321171029.GC3842@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

--YttKMwf6abDJOSyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 21, 2014 at 10:10:30AM -0700, Tony Lindgren wrote:
> > > On the support side, I'm not looking forward to this for beagle/panda
> > > users.  We've already converted them once from ttySx -> ttyOx back in
> > > 2.6.33/2.6.34? days.  That was an irc/email/u-boot/kernel nightmare...
> >=20
> > that's exactly why we're talking about ways to maintain backwards
> > compatibility here. But I'm more interested in finding a way to switch
> > over to ttyS and have a symlink to ttyO, that way a simple debootstrap
> > (or any other ARM distro minimal rootfs) would work out of the box,
> > without any changes, just like in "normal" systems.
>=20
> Yeah let's not break things. The symlink solution won't work for kernel

again. Let's not break things again.

> console output so it needs to be dealt with some other way.

it would if kernel itself would create the symlink, but that might not
be doable in a clean way.

> It seems that the biggest amount of work is making existing 8250
> support the missing features in a clean way and without breaking
> other platforms. Looks like 8250_dw.c has some pm_runtime_calls so
> obviously it's doable.

right

--=20
balbi

--YttKMwf6abDJOSyE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTLHi1AAoJEIaOsuA1yqRE73oP/RRB4VaZVBf4/VOw1DBOnunu
KwPDlK3ZYArM8BhlMLu3STJXepHi7X2bOYSzqgK/t3RqnXb0GdGPR8OjrrLPF+yy
wifTJAHa3PIfulQOj3RorUa18j+Dxy/O1Isdd6uF06nGIVviL6VNA834EWO6zPVG
tzJErAjLbRTnI2b7F7R1OG/+uIL7XBDy/aVhKtJ5fUrH7sngWUhTjYlG/JUghrg8
rlXGxx8NGbao8wekp1vfhtuheWkIzK79XEwYbvtQ9bFNaBek8wEYS14pTx710bgG
crd95fR9wg59VllkIU8Beeg6Zx5SWaY7H6dTcKUafoYycc9AWb46svIbIODarVQR
NozRLaXRH+dtlxgwTk40aA89jDvkuLZRO8qoUzHAdhByDImjONnNgdXe3c7KxlB9
Ih9ONzS1We5uQpv4NvkObkoljJSp7EDpuyTBV9slhNMXLaF8nns6HBeEXcJNs9Aj
aIZyZeWW/U9rBhBlVkmBn9aYOvMHzyDogFIhUP1Zo3ASMnm4MBNANuXGvcbcLxZO
nFJrf9XyN6klNd5haerVs4HRmuyW5xuPnlFkXs6epQzgzOcShMybZlZF7nKLm1QV
5oPpSi2F8BJJWdw0oK2Lh42I7+gIrUdGP7cj0pZ16Y9isoYneFGSRMn/EX24/bcP
pxEjUy4t0ipvqzVZNNqC
=TBWn
-----END PGP SIGNATURE-----

--YttKMwf6abDJOSyE--
