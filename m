From: "=?ISO-8859-1?Q?Ragner_Magalh=E3es?=" <ragner@users.sourceforge.net>
Subject: Fwd: SD response type 6 vs. 1
Date: Fri, 8 Jun 2007 09:55:39 -0400
Message-ID: <25c21ceb0706080655y5fec5d0ex7ad0c6e909d07a6b@mail.gmail.com>
References: <fb249edb0706040841m222daab2xc7a4833e7b1c96cb@mail.gmail.com>
	<466456CC.1070408@drzeus.cx> <4664607B.1070103@indt.org.br>
	<4666F848.1020600@drzeus.cx>
	<25c21ceb0706061415k5e8ce510t3a1c999bcbb5102c@mail.gmail.com>
	<4667C0B6.6090408@drzeus.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_48559_25193863.1181310939645"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4667C0B6.6090408@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_48559_25193863.1181310939645
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

---------- Forwarded message ----------
From: Pierre Ossman <drzeus-list@drzeus.cx>
Date: Jun 7, 2007 4:24 AM
Subject: Re: SD response type 6 vs. 1
To: Ragner Magalh=E3es <ragner@users.sourceforge.net>


Ragner Magalh=E3es wrote:
> I tested this patch and it is working ...
>

Looks good. Could you send it out to the omap list so that others can
test it?

Somebody more could to test this patch?

---

 drivers/mmc/host/omap.c |   24 +++---------------------
 1 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 383bd54..b6a55e1 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -524,28 +524,10 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id=
)
 =09=09}

 =09=09if (status & OMAP_MMC_STAT_CARD_ERR) {
-=09=09=09if (host->cmd && host->cmd->opcode =3D=3D MMC_STOP_TRANSMISSION) =
{
-=09=09=09=09u32 response =3D OMAP_MMC_READ(host, RSP6)
-=09=09=09=09=09| (OMAP_MMC_READ(host, RSP7) << 16);
-=09=09=09=09/* STOP sometimes sets must-ignore bits */
-=09=09=09=09if (!(response & (R1_CC_ERROR
-=09=09=09=09=09=09=09=09| R1_ILLEGAL_COMMAND
-=09=09=09=09=09=09=09=09| R1_COM_CRC_ERROR))) {
-=09=09=09=09=09end_command =3D 1;
-=09=09=09=09=09continue;
-=09=09=09=09}
-=09=09=09}
-
-=09=09=09dev_dbg(mmc_dev(host->mmc), "card status error (CMD%d)\n",
+=09=09=09dev_dbg(mmc_dev(host->mmc),
+=09=09=09=09"ignoring card status error (CMD%d)\n",
 =09=09=09=09host->cmd->opcode);
-=09=09=09if (host->cmd) {
-=09=09=09=09host->cmd->error =3D MMC_ERR_FAILED;
-=09=09=09=09end_command =3D 1;
-=09=09=09}
-=09=09=09if (host->data) {
-=09=09=09=09host->data->error =3D MMC_ERR_FAILED;
-=09=09=09=09transfer_error =3D 1;
-=09=09=09}
+=09=09=09end_command =3D 1;
 =09=09}

 =09=09/*

I am sending it attached too ...

Best regards,

--=20
Ragner N Magalh=E3es

Instituto Nokia de Tecnologia - INdT
Open Source Mobile Research Center - OSMRC
Linux Kernel Team

E-mail: ragner.magalhaes@indt.org.br
            ragner@users.sourceforge.net

------=_Part_48559_25193863.1181310939645
Content-Type: text/x-patch; name=omap-mmc_rsp_r6.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2opxf9d
Content-Disposition: attachment; filename="omap-mmc_rsp_r6.diff"

U0QgQ2FyZCB3b3JraW5nIG9uIE9NQVAgcGxhdGZvcm1zCgpGcm9tOiBSYWduZXIgTWFnYWxoYWVz
IDxyYWduZXIubWFnYWxoYWVzQGluZHQub3JnLmJyPgoKRml4aW5nIHJlcG9uc2UgdHlwZSBSNiBm
b3IgQ01EMyB3aGVuIFNEIENhcmQgd2lsbCBiZSBhdHRhY2hlZC4KCklnbm9yaW5nIE9NQVBfTU1D
X1NUQVRfQ0FSRF9FUlIsIHRyZWF0aW5nIGl0IGFzIGlmIHRoZSBjb21tYW5kCmNvbXBsZXRlZCBj
b3JyZWN0bHkuCgpTaWduZWQtb2ZmLWJ5OiBSYWduZXIgTWFnYWxoYWVzIDxyYWduZXIubWFnYWxo
YWVzQGluZHQub3JnLmJyPgpTaWduZWQtb2ZmLWJ5OiBDYXJsb3MgRWR1YXJkbyBBZ3VpYXIgPGNh
cmxvcy5hZ3VpYXJAaW5kdC5vcmcuYnI+Ci0tLQoKIGRyaXZlcnMvbW1jL2hvc3Qvb21hcC5jIHwg
ICAyNCArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAyMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L29t
YXAuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvb21hcC5jCmluZGV4IDM4M2JkNTQuLmI2YTU1ZTEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvb21hcC5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qv
b21hcC5jCkBAIC01MjQsMjggKzUyNCwxMCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbW1jX29tYXBf
aXJxKGludCBpcnEsIHZvaWQgKmRldl9pZCkKIAkJfQogCiAJCWlmIChzdGF0dXMgJiBPTUFQX01N
Q19TVEFUX0NBUkRfRVJSKSB7Ci0JCQlpZiAoaG9zdC0+Y21kICYmIGhvc3QtPmNtZC0+b3Bjb2Rl
ID09IE1NQ19TVE9QX1RSQU5TTUlTU0lPTikgewotCQkJCXUzMiByZXNwb25zZSA9IE9NQVBfTU1D
X1JFQUQoaG9zdCwgUlNQNikKLQkJCQkJfCAoT01BUF9NTUNfUkVBRChob3N0LCBSU1A3KSA8PCAx
Nik7Ci0JCQkJLyogU1RPUCBzb21ldGltZXMgc2V0cyBtdXN0LWlnbm9yZSBiaXRzICovCi0JCQkJ
aWYgKCEocmVzcG9uc2UgJiAoUjFfQ0NfRVJST1IKLQkJCQkJCQkJfCBSMV9JTExFR0FMX0NPTU1B
TkQKLQkJCQkJCQkJfCBSMV9DT01fQ1JDX0VSUk9SKSkpIHsKLQkJCQkJZW5kX2NvbW1hbmQgPSAx
OwotCQkJCQljb250aW51ZTsKLQkJCQl9Ci0JCQl9Ci0KLQkJCWRldl9kYmcobW1jX2Rldihob3N0
LT5tbWMpLCAiY2FyZCBzdGF0dXMgZXJyb3IgKENNRCVkKVxuIiwKKwkJCWRldl9kYmcobW1jX2Rl
dihob3N0LT5tbWMpLAorCQkJCSJpZ25vcmluZyBjYXJkIHN0YXR1cyBlcnJvciAoQ01EJWQpXG4i
LAogCQkJCWhvc3QtPmNtZC0+b3Bjb2RlKTsKLQkJCWlmIChob3N0LT5jbWQpIHsKLQkJCQlob3N0
LT5jbWQtPmVycm9yID0gTU1DX0VSUl9GQUlMRUQ7Ci0JCQkJZW5kX2NvbW1hbmQgPSAxOwotCQkJ
fQotCQkJaWYgKGhvc3QtPmRhdGEpIHsKLQkJCQlob3N0LT5kYXRhLT5lcnJvciA9IE1NQ19FUlJf
RkFJTEVEOwotCQkJCXRyYW5zZmVyX2Vycm9yID0gMTsKLQkJCX0KKwkJCWVuZF9jb21tYW5kID0g
MTsKIAkJfQogCiAJCS8qCg==
------=_Part_48559_25193863.1181310939645
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_48559_25193863.1181310939645--
