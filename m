From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: Reading memory - User Space
Date: Wed, 13 Dec 2006 10:44:35 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF4074CF249@dlee02.ent.ti.com>
References: <C51F43ABFC95844490F0529B60753BF4074CF22C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <C51F43ABFC95844490F0529B60753BF4074CF22C@dlee02.ent.ti.com>
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

Sorry wrong list...this is meant for davinci...

Jon
=20

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com=20
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of Hunter, Jon
> Sent: Wednesday, December 13, 2006 10:40 AM
> To: linux-omap-open-source@linux.omap.com; Jerry Johns
> Subject: RE: Reading memory - User Space
>=20
> > So would I do it like this to read PLL2 Registers? (PLL2=20
> regs start at=20
> > 0x01C40C00, see page 94 of TMS320DM6446 datasheet)
> >=20
> > int memfd;
> > memfd =3D open("/dev/mem", O_RDONLY | O_NONBLOCK, 0); if=20
> (memfd =3D=3D -1) {
> > 	ERR("Cannot open /dev/mem (%s)\n", strerror(errno));
> > 	return FAILURE;
> > }
> >=20
> > unsigned char *memread;
> > memread =3D (unsigned char*)malloc(512); memread =3D (unsigned=20
> > char*)mmap(NULL, 16, PROT_READ, MAP_SHARED, memfd, 0x01C40C00);=20
> > printf("PLL Values %08x\n", *(unsigned int*)memread);
>=20
>=20
> Sorry for the delay. Looks fine, however, the only item that=20
> you need to be wary of is the MMU page size. I was playing=20
> around with the /dev/mem driver and it appears that you need=20
> to map memory on a MMU page boundary otherwise the driver=20
> will issue a fault. For ARM devices, I believe that the page=20
> size used by Linux is 4KB. So what you need to do is create a=20
> 4KB mapping at address 0x01C40000 instead of 0x01C40C00. For example:
>=20
> memread =3D (unsigned char*)mmap(NULL, 4096, PROT_READ,=20
> MAP_SHARED, memfd, 0x01C40000);=20
>=20
> You can then access the particular register by using a 0xC00=20
> offset with the address that mmap provides.=20
>=20
> Cheers
> Jon
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
