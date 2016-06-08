From: joerg Reisenweber <joerg-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Wed, 08 Jun 2016 12:20:45 +0200
Message-ID: <4684873.SkgQPQ65qP@saturn>
References: <201601091616.04193@pali> <20160608095321.GH22406@atomide.com> <87h9d49exz.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3703601.eBue3Ziqxy"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87h9d49exz.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--nextPart3703601.eBue3Ziqxy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wed 08 June 2016 13:02:00 Felipe Balbi wrote:
> Hi,
> 
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> > Yeah I don't know, AFAIK we don't have a generic way to
> > force MUSB to change mode without ID pin. If you have figured
> #define MUSB_TEST_FORCE_HOST	0x80
> 
> Can someone confirm on MUSB's docs (and actual running system) that this
> does what's supposed to do?



(disclaimer: all IIRC) Alas it doesn't, at least for the MentorGraphics MUSB 
in OMAP3.  
We use MUSB_TEST_FORCE_HOST in the H-E-N N900 hostmode hack 
(http://talk.maemo.org/showthread.php?p=696115) and it's really just a test 
thing that doesn't support full hostmode as we know it. 

There is definitely no other way to force the state machine in MUSB core into 
hostmode, than the "ID pin grounded" message from PHY via ULPI bus up to the 
MUSB, whether it's real or *sw-triggered by a command to PHY*.
Shame on the MUSB core design for this.


/jOERG

--nextPart3703601.eBue3Ziqxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAldX8YQACgkQ7Xtwhpk1UgwqzwCgoCvpp0/4vVQOXX17uYDHVDlM
BUEAnjOK3BBfk4Q9oC1DKDba6eMk1sHA
=nfAr
-----END PGP SIGNATURE-----

--nextPart3703601.eBue3Ziqxy--

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
