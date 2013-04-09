From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH V3 1/2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Tue, 9 Apr 2013 21:40:49 +0200
Message-ID: <20130409194049.GA16847@avionic-0098.mockup.avionic-design.de>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
 <1363214006-10662-2-git-send-email-achew@nvidia.com>
 <20130408214624.GZ10155@atomide.com>
 <20130408215616.GA25124@avionic-0098.mockup.avionic-design.de>
 <20130408221657.GC10155@atomide.com>
 <20130409075602.GA27255@avionic-0098.mockup.avionic-design.de>
 <20130409164003.GK10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51921 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759626Ab3DITkx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 15:40:53 -0400
Content-Disposition: inline
In-Reply-To: <20130409164003.GK10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Chew <achew@nvidia.com>, peter.ujfalusi@ti.com, acourbot@nvidia.com, linux-omap@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2013 at 09:40:04AM -0700, Tony Lindgren wrote:
[...]
> But then the regulator is not found and the driver should just exit,
> or do nothing. If this is an optional regulator, then that should be
> indicated in some platform data flags?

Yes, if the regulator isn't found then the driver fails. However the
goal was to maintain bisectability. If we apply them in the wrong order
we can't guarantee that because pwm-backlight will fail to work between
both patches.

> The driver parts really must be done in independently from any platform
> data or .dts changes. The only common part needed should be changes
> to include/linux/platform_data/*.h files.

We don't even need to touch platform data because the regulators are
looked up via a global table. And the changes are all done independently
but as I mentioned above, bisectability isn't maintained, so the
preferred patch order is the one in which pwm-backlight keeps working at
each point in the commit history.

Thierry

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRZG7BAAoJEN0jrNd/PrOhFeoP/0fZjVSDX+zviB98PLN2sCgh
5L5d8ur5hOI9gf9ckgJHL6LrzzVHJGrsn4zSXOSTJ3RYt/LjM+gw7XtFGqEAu2PZ
ghkGBXF6YY+hcCLUZMeghRh2JgFHJoWq44lknjmkwAC2q8Bu3j5DdoAuSC9BqHxE
vt0jQvD3g6a9nAexohEI39S2HqI5/IDxSpkuJHtujXhFos8/hHZQS7aGnj3R6lTS
JCz8K6rah8RrpVXrbUD5b5W9wHKAsyD9PuKcFi3UeakGVMeducwcjdP+HwsbcLdI
IJjxyiODZO6yg5G0wgbdS7DxGZ88o/FjpW7SKxe9NkuaTRzTk7I38NB0pCgSg+Is
terkxHHwo6FfqJr6nAGhy5dEeHr0i+FmJkxZcG382hyw/XWcd6EVwg/i6Yi20W8X
OazoN1Use0lwMYj3dvzFj9Ibzkq7DxYiWx2ahWsVZR3HytOturByifq0PWQDtUcN
jmhjvtYcRPvto2GGecPqVaekzlumRCLob2Kb/w+excM0dStFBTyz7g2jbOaFIpq7
YcPStKic+NWzodEJ5DiVZAAsANksU4OTbP4deSUIXmV76BQ3x98lCMC5tPPyYWiL
xf6J2EGssugpQYodgY7gha+zRv9g4CxdS2YQe+XDDLWeGt30ewG70FQmtrNJiiJ0
FyRR4qrOdT8YT6RRIzQi
=7mxw
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
