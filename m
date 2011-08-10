From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 4/6] OMAP4: Temperature sensor device support
Date: Thu, 11 Aug 2011 00:37:29 +0300
Message-ID: <20110810213728.GC26868@legolas.emea.dhcp.ti.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-5-git-send-email-j-keerthy@ti.com>
 <20110810123647.GF12882@legolas.emea.dhcp.ti.com>
 <20110810124102.GM1939@atomide.com>
 <20110810124800.GK12882@legolas.emea.dhcp.ti.com>
 <4E4292E1.2070504@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:44554 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755050Ab1HJVkP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 17:40:15 -0400
Received: by mail-bw0-f41.google.com with SMTP id zt4so636173bkb.0
        for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 14:40:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E4292E1.2070504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "J, KEERTHY" <j-keerthy@ti.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 10, 2011 at 04:17:05PM +0200, Cousson, Benoit wrote:
> On 8/10/2011 2:48 PM, Balbi, Felipe wrote:
> >Hi,
> >
> >On Wed, Aug 10, 2011 at 05:41:02AM -0700, Tony Lindgren wrote:
> >>* Felipe Balbi<balbi@ti.com>  [110810 05:31]:
> >>>
> >>>On Wed, Aug 10, 2011 at 05:55:20PM +0530, Keerthy wrote:
> >>>>+
> >>>>+int __init omap_devinit_temp_sensor(void)
> >>>>+{
> >>>>+	if (!cpu_is_omap446x())
> >>>>+		return 0;
> >>>>+
> >>>>+	return omap_hwmod_for_each_by_class("temperature_sensor",
> >>>>+			temp_sensor_dev_init, NULL);
> >>>>+}
> >>>>+
> >>>>+arch_initcall(omap_devinit_temp_sensor);
> >>>
> >>>I really dislike people adding more and more *initcall() to their piec=
es
> >>>of code. But Tony is the final Judge.
> >>
> >>Yes how about making this just a regular device driver and have it
> >>live under drivers/ somewhere?
> >>
> >>Or is there some reason why this could not be a loadable module?
> >
> >driver is loadable, this is just creating the platform_device, but still
> >I don't think it deserves its own arch_initcall(), it could very well be
> >something which is called after we know we're running at omap4, or
> >called by each board...
>=20
> Funny, because I thought we were trying to get rid of the ugly init
> devices from board file to use *initcall() from a dedicated device
> file.
> The advantage is that you do not have anymore a central place that
> everybody will change and that is thus subject to merge conflicts.
>=20
> The drawback is that you do not know where an when the devices are create=
d.
>=20
> That being said, device-tree will provide a nice way to build all
> this devices without any initcall or board hacks.
> This is just a temporary issue :-)

Temporary or not, I would rather have this device created based on CPU
detection as it ought to be. But since we're moving to DT anyway, I
agree it might not be worth spending the time.

--=20
balbi

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQvoYAAoJEAv8Txj19kN1ul4IAKwQyH7jUC0WxCCXzxErtfIO
dFqoL0LiObOgu2PW06aibnW9W+g51KuZwNFJm0qmSkPzCBDZBdpjEeY1zWx7hz7T
8EXHi5PponhOBAeKkoGpYjzHuSxZl4z1Z8Z6FWBb9AXOIlCs8KebjQ4iKEeJkphd
f0iY9cHGkkFuQ+NZeUo4ZXheixTl6sRwDt+dXw5sV/32uXPVwM7GKOxsM6LsEizl
O6kEG9zx+Ib3vviaGVHO+srLgD8oEuMZS/0hiUZ+pVHb+RiheWKOpm7gu1L0971S
5b8jDLdCKikiryylp+vmfeP31kR/4bnkHdwMp4lMS4lVUvFDekqo1AeTOfCrihw=
=tP4Z
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
