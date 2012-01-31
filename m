From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] staging: tidspbridge: fix incorrect free to drv_datap
Date: Tue, 31 Jan 2012 11:21:36 +0300
Message-ID: <20120131082136.GC3294@mwanda>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
 <1327972818-30993-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h4FfhoHh9AMwLYAn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:65424 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab2AaIUP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 03:20:15 -0500
Content-Disposition: inline
In-Reply-To: <1327972818-30993-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org


--h4FfhoHh9AMwLYAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2012 at 07:20:18PM -0600, Omar Ramirez Luna wrote:
> This structure is still used after it has been freed, since it
> is being allocated in probe, calls to free it have been moved to
> module's remove routine.
>=20
> This should fix the follwoing messages when attempting to remove the
> module:
>  drv_get_first_dev_extension: Failed to retrieve the object handle
>  drv_get_first_dev_extension: Failed to retrieve the object handle
>  drv_destroy: Failed to store DRV object
>  mgr_destroy: Failed to store MGR object
>=20

So this is only triggered when you do an rmmod to remove the module?

Probably that's not stable material.

regards,
dan carpenter


--h4FfhoHh9AMwLYAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJ6SPAAoJEOnZkXI/YHqRM1UP/Rd15OgmiMhGGZXzMKeKfrU6
mm3dh3kfg514dCItc+9FQjxJ2XMCoYFUoyN+sNkJPeD0MgJVhp0xpbKrpLkVGg4N
0tZjsloOlkQ77CMb8NS/s/hqRFyD4V2vEIs8CSoRUeBzJr/TqAjsg2my6fl7nzWn
m/vvsVXwN4lqdotwyMhn1SeDAWTX1dNYbAtf8EPhwWE62QLYhNdSPXX5W6ZFf5zp
VUWh1OQk7gxfYJIlK+gZPVbLXodxZZ8bJWNXLHdbYqqnORMiZBtuuFxAQkVw1OqB
A+cBKoLcXtNhUmEND8tGQTg0EMHkukhnD/+7IFbgDXriqlmIaEMRnupslfK6EzY3
zeAoRCxIeXIE0/6GpL7nMNx08fV8IUV6CGRzyVQ1wllT6X+ywp/77eVoP6xoi7vX
3Wcxbq0fcIEO5W+4QpHUTIU10AMJv3ac6wnrhkSekx1l2ZLr1ugfXum6fOIDXM6+
yzcr/y5QDu8trg7+0SOs72E5SBOlrV+LDU2ArIKaFQeOuyaVFKAiH1OudPbb5l6h
7FVciVhjA9cQL9HSxQ9QwMT9DpG2Cj9VMsJuQn1aeoLnkDP93IlUhqd8FpZEePOL
NDmZ7dMctNaMNSYxtT5yVY6oYm1JGyIW1QAtQkHOgevGuADETL5c8cWQ/VJ+e2fL
8+SQP1xc4XkKfUGWf4BN
=m5AY
-----END PGP SIGNATURE-----

--h4FfhoHh9AMwLYAn--
