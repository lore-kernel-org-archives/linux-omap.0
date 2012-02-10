From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: tidspbridge: enable watchdog by default
Date: Fri, 10 Feb 2012 21:00:15 +0300
Message-ID: <20120210180015.GF4141@mwanda>
References: <1328058094-28483-1-git-send-email-felipe.contreras@gmail.com>
 <20120201011239.GA797@suse.de>
 <CAMP44s2Hvgsi+JF=ydAebd=dUYUNfJSB-T3FmLvO=RGDwBvU0Q@mail.gmail.com>
 <20120201034445.GA2979@kroah.com>
 <CAMP44s2FNFwvjv=f7WvJG7qXpYVqq0i53FzPcPTAB2g1mUk1Fw@mail.gmail.com>
 <20120209173528.GA31726@kroah.com>
 <CAMP44s3jvYMSmQfvhKEzTz9iYq-dabLJ6qniFsjw9vZLqgP0Ng@mail.gmail.com>
 <20120209185923.GB10284@kroah.com>
 <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:49439 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab2BJR7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 12:59:24 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s3r1-rt6HqgmVuB_Kjd1LSo-75m=6GERUt+ATewBaFw-Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, Jiri Kosina <jkosina@suse.cz>, linux-omap@vger.kernel.org, "Justin P. Mattock" <justinmattock@gmail.com>, Felipe Contreras <felipe.contreras@nokia.com>


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 10, 2012 at 01:30:48AM +0200, Felipe Contreras wrote:
> It's not an oops, it's a warning, and again, it depends on the
> firmware being used. We don't have control over that, and we have no
> way to detect if this feature is there. It's up to the user.

Perhaps just remove the warning message and handle the condition
instead of printing a stack dump?  The user should be triggering
stack dumps.  What on earth?

regards,
dan carpenter

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNVsuAAoJEOnZkXI/YHqRTIEP/ioANfEM3vDb+XyndSameifE
pXmsL7DyV7mkPlTpqQcVtw5ZJttSmEUFXIhn3bJzA6EeeOSYV1BhLy+onoqJwUbc
C8+YxZUz8Bn7dP3BspCZ84uycWwM6AyD4wlqL1pwG5BZwZpjOqEg6X453QiZDg18
t0340hINOccaH1D6b+nmw38wyRlp5q3CQqVomkOjy0DMQw0WBvTsiEUWoQOSAc23
+w/3pbhc6QtYkmygFBPXoDtPalDqS48bidKBPajpCgDhNC5WhGq8SpgyurPv15/I
yHJc19cUsbqWkrM+YlwxV1q3TvdAikTdjsRouyRaD0XOkResnqwHy5zsjORorWlN
ryP6PmRg9wnoNrCtToKmIYCdjh2cUufD1OHzmJNELvqN5vsFUQ7YMjOmfe3CQh7H
d0isAFEk85HJbFOZvJSrilG/Lr0zg1T7jBFLOJNOAIQZM6704WOqAwSa4DQCuV5K
D9x7VQL2RQrWYDmi+G4mp3jcZGCKvd+OmSi3p4H/+5KqAfvudhxsJgAC/GnzmzmU
73PpaKAGszDzFgWwDOrGYGD80NC09xaUSzdTDWl79sQhLzd/dM1WuFB+CcorAEfM
P6xqDweF5ZuNX1wP0JA2Vvg+DXvVV4l6X2aUEQ1mXW5TBHAZCfuAG9LpEZ7Ln7k3
vVkdnx2I9L1L9YTVKaWJ
=CaxW
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
