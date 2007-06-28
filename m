From: "Sriram, Kannan" <ksriram@ti.com>
Subject: RE: U-boot at 0x10000
Date: Thu, 28 Jun 2007 12:55:05 +0530
Message-ID: <0A50DBE80DD6674E94F7269DC964A7B618136F@dbde01.ent.ti.com>
References: <c656a4d20706280020y6bc7ae4cwc0cb673572b28a86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20706280020y6bc7ae4cwc0cb673572b28a86@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: arun c <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of arun c
> Sent: Thursday, June 28, 2007 4:20 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: U-boot at 0x10000
>=20
> Hi all,
>=20
>=20
> Thank you very much Sriram.
>=20
> >From the answer i understand,
>=20
> 1) While flashing, Nand is addressed at 0x0c000000
> thats why we write xload.bin.ift there
>
Yes, during flashing using CSST, CSST .2nd configures the NAND flash to
be mapped at 0x0c000000 (which typically is on CS1, if you look at your
switch settings).
=20
> 2) While booting from nand flash it is addressed(CS0) at 0x0
> Thats why we flash u-boot at 0x10000(0+4*16k=3D0x10000)
>=20
While booting, NAND flash would typically be mapped to 0x08000000 by the
boot ROM code (while Xloader begins to run), and later on be remapped to
a different address (maybe even 0x00) by Xloader or u-boot. Also, while
booting, NAND must be at CS0.

>=20
> Is this correct?
>=20
> Thanks&warm regards
> Arun c
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
