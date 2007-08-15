From: "Ralph Walden" <ralphw@everest-co.com>
Subject: RE: CF card driver for OMAP 5910
Date: Wed, 15 Aug 2007 07:27:14 -0700
Message-ID: <E0B2D7DFDC4D1349850E2C7C20DC4B996CF69F@dhost002-71.dex002.intermedia.net>
References: <20070815140832.792948062E@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070815140832.792948062E@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Message: 6
> Date: Wed, 15 Aug 2007 04:18:35 -0700 (PDT)
> From: Zgembo Adislic <adislic_zgembo@yahoo.com>
> Subject: CF card driver for OMAP 5910
> To: linux-omap-open-source@linux.omap.com
> Message-ID: <890228.38431.qm@web30604.mail.mud.yahoo.com>
> Content-Type: text/plain; charset=3Diso-8859-1
>=20
> Hi all,
>=20
> I'm using OMAP5910, kernel linux-2.6.8.1 modified for my=20
> platform (patches for battery, touch screen, ... etc).
> Does anybody know where is the driver for the CF card in this kernel?
> I'm supposed to check the mechanism of writing to CF card.
>=20
> Thanks,
> zgembooo
>       =20
> ---------------------------------
> Yahoo! oneSearch: Finally,  mobile search that gives answers,=20
> not web links.=20
>=20
> ------------------------------
>=20
> Message: 7
> Date: Wed, 15 Aug 2007 06:32:34 -0500
> From: "Kipisz, Steven" <s-kipisz2@ti.com>
> Subject: RE: CF card driver for OMAP 5910
> To: "Zgembo Adislic" <adislic_zgembo@yahoo.com>,
> 	<linux-omap-open-source@linux.omap.com>
> Message-ID:
> 	<B62D67BD8EC3324C8A3DACEEA1A0D6C60237C614@dlee12.ent.ti.com>
> Content-Type: text/plain;	charset=3D"us-ascii"
>=20
> I don't have 2.6.8, but in 2.6.14 it is in drivers/pcmcia/omap_cf.c
>=20
> Steve K.
>=20

I'm strangely familiar with your project :), and you can find the code
related to the physical hardware access here:

drivers/ide/arm/ide_omap.c

This is used by the drivers/ide/* code.

Ralph
