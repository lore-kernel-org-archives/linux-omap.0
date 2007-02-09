From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: [PATCH] - Fix MMC -- was  H4 boot with latest git kernel
Date: Fri, 9 Feb 2007 15:47:24 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>
	<20070209165157.GB22121@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C74C93.E2A05B3F"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070209165157.GB22121@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C74C93.E2A05B3F
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

So took a quick look with the emulator and see its hanging in MMC.  I'm
not an MMC expert but I don't see how you can send an init-stream
command with no clocks running and if you did it looks like it should be
80clocks over 1ms.

The note in the upper layer in mmc.c says you power it first, then send
clocks out.  mmc.c calls MMC_POWER_UP twice.  The first time with
ios->clock =3D 0 and a second time with iso->clock=3Df_min.  To me that =
just
says set the power bit in the first pass and set the initstream command
in the second pass.

The below patch seems to work fine and would appear to be a long
standing bug.

Signed-off-by: Richard Woodruff <r-woodruff2.com>

diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index 796172a..55075cc 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -990,7 +990,7 @@ static void mmc_omap_set_ios(struct mmc_
 	 * Writing to the CON register twice seems to do the trick. */
 	for (i =3D 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
-	if (ios->power_mode =3D=3D MMC_POWER_UP) {
+	if ((ios->power_mode =3D=3D MMC_POWER_UP) && ios->clock) {
 		/* Send clock cycles, poll completion */
 		OMAP_MMC_WRITE(host, IE, 0);
 		OMAP_MMC_WRITE(host, STAT, 0xffff);

Regards,
Richard W.



> -----Original Message-----
> From: =
linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.com
>
[mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.co=
m
]
> On Behalf Of Tony Lindgren
> Sent: Friday, February 09, 2007 10:52 AM
> To: Trilok Soni
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: H4 boot with latest git kernel
>=20
> * Trilok Soni <soni.trilok@gmail.com> [070209 03:30]:
> > Hi,
> >
> > H4 booting sequence stops just after the following NET messages. I
am
> > using latest pull from git. I have tried disabling IrDA, thinking
that
> > it might had created some problems. Is it working for anyone out
> > there?
>=20
> Maybe try booting with initcall_debug kernel parameter to see where
> it hangs?
>=20
> Regards,
>=20
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

------_=_NextPart_001_01C74C93.E2A05B3F
Content-Type: application/octet-stream;
	name="mmcfix.diff"
Content-Transfer-Encoding: base64
Content-Description: mmcfix.diff
Content-Disposition: attachment;
	filename="mmcfix.diff"

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL29tYXAuYyBiL2RyaXZlcnMvbW1jL29tYXAuYwppbmRl
eCA3OTYxNzJhLi41NTA3NWNjIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9vbWFwLmMKKysrIGIv
ZHJpdmVycy9tbWMvb21hcC5jCkBAIC05OTAsNyArOTkwLDcgQEAgc3RhdGljIHZvaWQgbW1jX29t
YXBfc2V0X2lvcyhzdHJ1Y3QgbW1jXwogCSAqIFdyaXRpbmcgdG8gdGhlIENPTiByZWdpc3RlciB0
d2ljZSBzZWVtcyB0byBkbyB0aGUgdHJpY2suICovCiAJZm9yIChpID0gMDsgaSA8IDI7IGkrKykK
IAkJT01BUF9NTUNfV1JJVEUoaG9zdCwgQ09OLCBkc29yKTsKLQlpZiAoaW9zLT5wb3dlcl9tb2Rl
ID09IE1NQ19QT1dFUl9VUCkgeworCWlmICgoaW9zLT5wb3dlcl9tb2RlID09IE1NQ19QT1dFUl9V
UCkgJiYgaW9zLT5jbG9jaykgewogCQkvKiBTZW5kIGNsb2NrIGN5Y2xlcywgcG9sbCBjb21wbGV0
aW9uICovCiAJCU9NQVBfTU1DX1dSSVRFKGhvc3QsIElFLCAwKTsKIAkJT01BUF9NTUNfV1JJVEUo
aG9zdCwgU1RBVCwgMHhmZmZmKTsK

------_=_NextPart_001_01C74C93.E2A05B3F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C74C93.E2A05B3F--
