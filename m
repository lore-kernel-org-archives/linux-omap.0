From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Fri, 10 Feb 2012 23:35:37 +0300
Message-ID: <20120210203537.GG4141@mwanda>
References: <20120201011239.GA797@suse.de>
 <CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
 <20120201034445.GA2979@kroah.com>
 <CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
 <20120209173528.GA31726@kroah.com>
 <CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
 <20120209185923.GB10284@kroah.com>
 <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
 <20120210180015.GF4141@mwanda>
 <CAMP44s2HUApzGH_rExqS1bOnq0nHj4Y0vEojZN4vXNPAxC1oKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sLx0z+5FKKtIVDwd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:25421 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab2BJUeI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 15:34:08 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s2HUApzGH_rExqS1bOnq0nHj4Y0vEojZN4vXNPAxC1oKA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, linux-omap@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, Felipe Contreras <felipe.contreras@nokia.com>


--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2012 at 09:42:32PM +0200, Felipe Contreras wrote:
> On Fri, Feb 10, 2012 at 8:00 PM, Dan Carpenter <dan.carpenter@oracle.com>=
 wrote:
> > On Fri, Feb 10, 2012 at 01:30:48AM +0200, Felipe Contreras wrote:
> >> It's not an oops, it's a warning, and again, it depends on the
> >> firmware being used. We don't have control over that, and we have no
> >> way to detect if this feature is there. It's up to the user.
> >
> > Perhaps just remove the warning message and handle the condition
> > instead of printing a stack dump? =A0The user should be triggering
> > stack dumps. =A0What on earth?
>=20
> The warning doesn't come from the driver.

I'm not sure I understand.  Are you saying that because it comes
=66rom the arch/ directory, it can't be fixed?  I have good news for
you my friend.  :)  It's all open source!  \o/

Anyway, I saw in another email that Omar is working on a fix so
probably we can just wait for his patch, yes?

regards,
dan carpenter

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNX+ZAAoJEOnZkXI/YHqRCIkP/1028kvRf51goeJCxyfhjssK
ex+leTNTnf9CrXlgeCQuB2gyWxGjWjhzEN6iiqo3H+wjIKcQEFx5XnQGo4/znVPN
oWh9YfPYqX2jz0y6j278phdW2+gs+r+5Qdk8V/gBYALzlXm6n7/oij282NowiU+0
vSSUl/EuCqgGomwBfkCNUy46OM8F9L3rk3PQEk173AyExWO+NXiv35kJFyVdeRd1
zck41UOzR8i9hZshVlh5Zu0bTxnIryHXKXOD5AXyhtnOoz6Uz8ab1v3Ldbc3Zeoi
9Cxv1ItBKlZh3A+Bj3JzRDsX7zUcW1rf4BdUajZI91NqUJ1Al08vwYA25y7+JFvw
1WU/N5FGC2iKq/MP5SwcAaundMKTL/XMg6rA+3GaTj2D8xYENu0vdDWqzf1lKzxD
dLtPQ210Fxm9A/fFpz10abvzkUaXmBMzXemEPehmfzkmd7PW82kRH+uARNKGZ9EV
Sf/NcuSwtiKnaDq8eG2+UumwzdwBWGR0VToHDFxU57IR5RUbKoweR18ylcYdDSk8
rWLv05WmG4WhfqeTMRmcdmGN33yFaDIAxiNnOTxSphhR0dmbrXkes2b6i9axYmfH
Xu8KiITzp8tiEUJVvjm1EkyGMQVvVw1mEA7xPRvxbeDjJdBcE6P4SbH03uRq6+y2
1sbo0SiWcwtz3enrZMH7
=mUkG
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--
