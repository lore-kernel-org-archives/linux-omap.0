From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: clock regression and note.
Date: Fri, 10 Aug 2007 15:44:08 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429019C4FAD@dlee13.ent.ti.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429019C4F91@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7DB8F.33284566"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429019C4F91@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7DB8F.33284566
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> 2430 has a 26MHz input which gets /2 to 13Mhz by the first level =
divider.
> One of your patches did touch this.
>=20
> <6>Clocking rate (Crystal/DPLL/MPU): 6.5/330/165 MHz
> <3>Clock apll54_ck didn't lock in 100000 tries
> <6>GPMC revision 3.0
> <6>IRQ: Found an INTC at 0xd80fe000 (revision 3.0) with 96 i
>=20
> I'll take a quick look.

This fixes it.  Patch #2 of #22 was not right.

What is happening is the u-boot (or other) flash is expected to set the =
APLL field properly via gauging at boot.  It must do this before =
enabling the APLLs.

Therefore when you start up you can look at the APLL value to see what =
your sys_clk rate is actually set to.  From there you multiply the upper =
divider a 1 or 2 to the sys_clk rate to get the osc_clk rate.

--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1149,7 +1149,7 @@ static void __init omap2_get_crystal_rate(struct =
clk *osc, struct clk *sys)
 	div &=3D OMAP_SYSCLKDIV_MASK;
 	div >>=3D sys->rate_offset;
=20
-	osc->rate =3D sclk;
+	osc->rate =3D sclk * div;
 	sys->rate =3D osc->rate / div;
 }

------_=_NextPart_001_01C7DB8F.33284566
Content-Type: application/octet-stream;
	name="fix_osc_calc.diff"
Content-Transfer-Encoding: base64
Content-Description: fix_osc_calc.diff
Content-Disposition: attachment;
	filename="fix_osc_calc.diff"

LS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9jbG9jay5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21h
cDIvY2xvY2suYwpAQCAtMTE0OSw3ICsxMTQ5LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG9tYXAy
X2dldF9jcnlzdGFsX3JhdGUoc3RydWN0IGNsayAqb3NjLCBzdHJ1Y3QgY2xrICpzeXMpCiAJZGl2
ICY9IE9NQVBfU1lTQ0xLRElWX01BU0s7CiAJZGl2ID4+PSBzeXMtPnJhdGVfb2Zmc2V0OwogCi0J
b3NjLT5yYXRlID0gc2NsazsKKwlvc2MtPnJhdGUgPSBzY2xrICogZGl2OwogCXN5cy0+cmF0ZSA9
IG9zYy0+cmF0ZSAvIGRpdjsKIH0KIAo=

------_=_NextPart_001_01C7DB8F.33284566
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7DB8F.33284566--
