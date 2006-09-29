From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: H4 with 2.6.9 from TI dev site not booting
Date: Fri, 29 Sep 2006 08:34:55 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A507E2E1A5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

It is likely your u-boot or kernel might be mis-matched with respect to
the mach-type.

This is just a simple error hang loop.  If it can't figure out processor
variant or mach-type it jumps to a hang. It is likely either a mismatch
or memory corruption.

Regards,
Richard W.
=20

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com=20
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On=20
> Behalf Of Richard Copeman
> Sent: Friday, September 29, 2006 7:52 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: H4 with 2.6.9 from TI dev site not booting
>=20
> Hi,
>=20
> =20
>=20
> I wonder if anyone has any experience with LINUX 2.6.9 built=20
> with gcc 3.4.1
> for ARM running on TI OMAP2420 H4 board.
>=20
> =20
>=20
> I download the kernel via JTAG to 0x80000000 and start it=20
> running. It runs
> for 35 instructions and then ends up in a tight loop at=20
> 0x80008118 which
> contains a nop followed by a branch to 0x80008118.
>=20
> =20
>=20
> Can someone point me in the right direction please?
>=20
> =20
>=20
> TIA,
>=20
> =20
>=20
> Richard.
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
