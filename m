From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/14] Rework OMAP4+ HDMI audio support
Date: Thu, 14 Aug 2014 20:10:08 +0100
Message-ID: <20140814191008.GE17528@sirena.org.uk>
References: <cover.1407503813.git.jsarha@ti.com>
 <20140813110425.GL17528@sirena.org.uk>
 <53EB5F6A.9060308@ti.com>
 <20140813172632.GE17528@sirena.org.uk>
 <53EC8127.7090405@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hKlCbHbSDGogBfqt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35533 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbaHNTKN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2014 15:10:13 -0400
Content-Disposition: inline
In-Reply-To: <53EC8127.7090405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com


--hKlCbHbSDGogBfqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2014 at 12:28:07PM +0300, Jyri Sarha wrote:

> After discussing with Peter and Tomi I decided to change the approach a bit.
> There should not be any new device registered, just ASoC components that are
> implemented under sound/soc as a library rather than a device driver.

> The library would export a register and unregister functions to be called
> from video driver directory. The functions will then register the necessary
> ASoC components under the video device.

> If there are no objections I'll go ahead implementing this approach, first
> for OMAP HDMI audio, and later for SiI9022 driver we are cooking.

That also sounds perfectly sensible.

--hKlCbHbSDGogBfqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT7QmMAAoJELSic+t+oim9VikP/3b0/Vli9SYeaan6A7lPeUnW
366oz6KwXmJPOLEcjFsmhXpMj+RJlVw2aMvu6wH/dUzJsN1QeKD+nvhTi8wrgBmU
8Z+uYkOLs2Q6fapTV6LlU7Ek+tNHLoIz6bn2AsAd4m+HEqKyRgEsydU5Lteh3ih6
YLPI6NhDqbH7Y/MbwY7Uo7GD8pnkuKDUEwKdAHymXn47kvNpVEsvtNpQ2oiZRwKM
OIAr3RkOrg0udYf+lTOTQnk1cXFM7UUq4q/JSOVfRUx+cMYz8woLkUl0VyZXt0Eq
RQoRHrwaC4mPBBxtlQVYTmD9nHyCPs3SuTEvp6yVzZYKppyqeWPUOYYdN8AtD/Pn
8l9jJmkldW1lrICIhYvtfDVH7zDLYoJpI8QrATrH5Ck4dxaspmRDxeFbGmOieAYa
kNOISmqZ3WcE0KvbSL83HK0Fq/QJG1vTgGmRt9jwI44kJ8YoGcYFc/WvXllTsxsP
XgafrPmLiqu4XfLec63pTTt+atSQorFYH2YxT4DqrGlbtI9BuO7DIakOpOXqqTg+
DaN12zI12DgjCkvqTOXS3TMHEZQnV4Bv5U6HGOOiY+DWo1jzCMYhuAQHN9NSuJOz
i12YLLY34hSj6EZdQmgU0hbkHCCYsxxxtQNQ08T+8ES4IQLj+CqXnodilhm9NGah
qSXp8h+UgYXYeUG3l4TL
=Mrqw
-----END PGP SIGNATURE-----

--hKlCbHbSDGogBfqt--
