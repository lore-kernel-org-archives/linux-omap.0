From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP2430: networking errors
Date: Thu, 17 May 2007 11:10:24 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429010256C1@dlee13.ent.ti.com>
References: <57314e840705170701k79f76c5k79649f929bc63066@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <57314e840705170701k79f76c5k79649f929bc63066@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> it's a development board. how do I know which ethernet chip is on it ?

Ok.  Is it the TI-SDP2430 development board?

If so, what images are you using?  Did you build them or use pre-built
ones.

Why do you report your MAC address as  yy:yy:yy:yy:yy:yy.  Is that what
the driver said or did you remove it for some reason.

If it works sometimes and not other times that is odd.  Are you using
the same MAC address on multiple board or something?

Regards,
Richard W.

>=20
> >
> > Does networking work at the u-boot level?
>=20
> Have the same problems, but just sometimes.
> I do use tftpboot to load the kernel and fs, and sometimes I=20
> encounter the same problems (arp-reply packets get ignored).
> feels pretty much random behaviour.
>=20
> Sometimes the DHCP succeeds, too.
>=20
> >
> > If it is using the standard etherent on SDP's I'd say the=20
> gpmc timing=20
> > was wrong on your instance.  If its not the same chip add possible=20
> > driver error.
>=20
> Can you please guide me how do i check the ethernet chip ?
> and if it's standard, how do I change the gpmc timing ?
>=20
> Thank you !
> Budhee
>=20
