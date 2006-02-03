From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: OSK5912 cpu_is_omap5912() FALSE
Date: Fri, 3 Feb 2006 08:41:17 -0600
Message-ID: <C51F43ABFC95844490F0529B60753BF4036F2F52@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: "Smith, Stephen" <smsmith@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Stephen,=20

> -----Original Message-----
> From:=20
> linux-omap-open-source-bounces+jon-hunter=3Dti.com@linux.omap.co
> m=20
> [mailto:linux-omap-open-source-bounces+jon-hunter=3Dti.com@linux
> .omap.com] On Behalf Of Smith, Stephen
> Sent: Thursday, February 02, 2006 5:14 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: OSK5912 cpu_is_omap5912() FALSE
>=20
> OSK5912/Linux 2.6.13
>=20
> =20
>=20
> There is a discrepancy in cpu.h and what my OSK5912 reflects.
>=20
> =20
>=20
> cpu.h reflects:
>=20
> IS_OMAP_TYPE(5912, 0x1611)
>=20
> =20
>=20
> Here is my data from boot, which reflects the correct values:
>=20
> OMAP_DIE_ID_0: 0xbfd20610
>=20
> OMAP_DIE_ID_1: 0x8e059089 DIE_REV: 2
>=20
> OMAP_PRODUCTION_ID_0: 0x00aaaafc
>=20
> OMAP_PRODUCTION_ID_1: 0x00016cbe JTAG_ID: 0x6cbe
>=20
> OMAP32_ID_0: 0x03320500
>=20
> OMAP32_ID_1: 0x2b65f02f
>=20
> JTAG_ID: 0xb65f DIE_REV: 2
>=20
> OMAP162123 revision 2 handled as 16xx id: 8e059089bfd20610
>=20
> =20
>=20
> =20
>=20
> Is arch-omap/cpu.h wrong, or is there something more here?  With
>=20
> code as it was patched, cpu_is_omap5912() fails.  Sign of problem
>=20
> is the inability to reboot the board (# reboot).  I can fix by
>=20
> changing cpu.h to:
>=20
> =20
>=20
> IS_OMAP_TYPE(5912, 0x1621)
>=20
> =20
>=20
> I don't want to blindly change because I do not know history=20
> of OMAP5912
>=20
> and it is possible some previous rev had id'ed as 1611.
>=20
> It could also be fixed by adding another type check to=20
> arch_reset(), but
>=20
> that may include 1621 types that do not require or want workaround.
>=20
> =20
>=20
> Any insight would be appreciated.


The initial 5912 devices were based on the 1611 devices. However, the
production version of the 5912 is based on the 1621. From a
user/functional perspective there is not much difference between the
devices. There were a lot of silicon issues that were fixed and
performance improvements made.=20

It appears that you have the production 5912 silicon and so 1621 makes
sense.=20

Regards,
Jon
