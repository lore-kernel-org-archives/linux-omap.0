From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/2] staging: tidspbridge: fix incorrect free to drv_datap
Date: Wed, 1 Feb 2012 09:58:46 +0300
Message-ID: <20120201065846.GP3356@mwanda>
References: <1327972818-30993-1-git-send-email-omar.ramirez@ti.com>
 <1327972818-30993-3-git-send-email-omar.ramirez@ti.com>
 <20120131082136.GC3294@mwanda>
 <CAB-zwWg9iudV7o5opYHOMHo8HN9EGB+n0f=mAHQCNWZovHrdvQ@mail.gmail.com>
 <20120131184338.GO3356@mwanda>
 <CAMP44s2yssE0_4NnZ=+hhU3_LoV+Uay7Rjmn8m_8RQZefH7knQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4CyH/NlNBqvsUTYP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:34891 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab2BAG5S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 01:57:18 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s2yssE0_4NnZ=+hhU3_LoV+Uay7Rjmn8m_8RQZefH7knQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org


--4CyH/NlNBqvsUTYP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 09:39:00PM +0200, Felipe Contreras wrote:
> On Tue, Jan 31, 2012 at 8:43 PM, Dan Carpenter <dan.carpenter@oracle.com>=
 wrote:
> > How often do people rmmod things on a production system? =A0Hopefully,
> > never right?
>=20
> That's right... At least in recent versions of the tidspbrdige, that
> have recovery support. Before, we needed a script to detect MMU
> faults, and reload the module =3D/ IIRC this is still the case on the
> Nokia N900.

If you have a script that's doing rmmods then that's different.  I
didn't know about that.

regards,
dan carpenter


--4CyH/NlNBqvsUTYP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKOKmAAoJEOnZkXI/YHqROKMP+QHfoR18HDAOh4F5/48o/MV8
sza5+dSwSj1sK/rui1RBefuZ9YNcY3IMxVh6lWgCQh6aveR6d8a84gqBDB9XZxY1
oyIGYmpVY/tORo493sFq3AGFByDMivuPb+cu1YvF3ZYqASxGu+D8Ucssb45rgoBn
yA4PnkvSdo+Ba3glIbNOYLAMEHDO5tiAtpqj8JMhEfS0fizZkmiu8LlzbVjLAAmX
9bp0q/3hzVU97f1ldj5hk8+XRn6XFtC3/GsjgTf4LOv2j1qU8SNmANm0PNt6lb0X
PhjAdNTrL45jmwgJBUTBEjY4WpVPOPk5AQpCjcvKgO2P5XzK20q4y1nJ8/yrq1o3
+z+8zwVBp/vY8Q1CYnVxiCUfNsy9Q/4pZ76jGtJe92phC6FjhCWO0bvT2aNGNdAo
tOHhavc47q3hYXyLi86mdbZcmko7qSOQkkI9sLobWCSPaHAfGpkrLygrBN+Vmy0b
oXhcAvt2qDCIn2PDkyksqUmIUXgFIFOm/hbELY5WGrLbf9glKIH1MD8tTqp5Bhnd
H4OKuIC/zfWR7CeQD9w2U8bDTGqlZHf71/u2KPmgSpEIUb1fmgjU94CaGV5F7qqV
yr7sspeHWmYAln8WDt/kqkDh2Zw5NajLQ6RjLmjzDJvq7xon0MQlmoiwe9COQZnY
QwMV2+PSDxSNwjYM1pPU
=jG1S
-----END PGP SIGNATURE-----

--4CyH/NlNBqvsUTYP--
