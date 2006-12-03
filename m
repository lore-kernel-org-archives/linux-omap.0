From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] GPMC warning fix in header file
Date: Sun, 3 Dec 2006 14:39:51 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE1D@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7171B.2E80F87F"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7171B.2E80F87F
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

This patch is to fix GPMC warning / error in gpmc.h.

=20

Regards,

Khasim


------_=_NextPart_001_01C7171B.2E80F87F
Content-Type: application/octet-stream;
	name="gpmc_includefix.patch"
Content-Transfer-Encoding: base64
Content-Description: gpmc_includefix.patch
Content-Disposition: attachment;
	filename="gpmc_includefix.patch"

VG8gZml4IHRoZSByZXR1cm4gdHlwZS4KClNpZ25lZC1vZmYtYnk6IFN5ZWQgTW9oYW1tZWQgS2hh
c2ltICA8eDBraGFzaW1AdGkuY29tPgoKRmlsZXMgQ2hhbmdlZDoKIGdwbWMuaCB8ICAgIDIgKy0K
IDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09CmRpZmYgLXB1ck4gbGludXgtb21hcC9pbmNsdWRlL2FzbS1hcm0vYXJjaC1v
bWFwL2dwbWMuaCBkZXZwdF9icmFuY2gvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9ncG1jLmgK
LS0tIGxpbnV4LW9tYXAvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9ncG1jLmgJMjAwNi0xMi0w
MyAxMjo1MzoyMy4wMDAwMDAwMDAgLTA2MDAKKysrIGRldnB0X2JyYW5jaC9pbmNsdWRlL2FzbS1h
cm0vYXJjaC1vbWFwL2dwbWMuaAkyMDA2LTEyLTAyIDA4OjE0OjU0LjAwMDAwMDAwMCAtMDYwMApA
QCAtODgsNyArODgsNyBAQCBleHRlcm4gaW50IGdwbWNfY3NfY2FsY19kaXZpZGVyKGludCBjcywg
CiBleHRlcm4gaW50IGdwbWNfY3Nfc2V0X3RpbWluZ3MoaW50IGNzLCBjb25zdCBzdHJ1Y3QgZ3Bt
Y190aW1pbmdzICp0KTsKIGV4dGVybiBpbnQgZ3BtY19jc19yZXF1ZXN0KGludCBjcywgdW5zaWdu
ZWQgbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nICpiYXNlKTsKIGV4dGVybiB2b2lkIGdwbWNfY3Nf
ZnJlZShpbnQgY3MpOwotZXh0ZXJuIHZvaWQgZ3BtY19jc19zZXRfcmVzZXJ2ZWQoaW50IGNzLCBp
bnQgcmVzZXJ2ZWQpOworZXh0ZXJuIGludCBncG1jX2NzX3NldF9yZXNlcnZlZChpbnQgY3MsIGlu
dCByZXNlcnZlZCk7CiBleHRlcm4gaW50IGdwbWNfY3NfcmVzZXJ2ZWQoaW50IGNzKTsKIAogI2Vu
ZGlmCg==

------_=_NextPart_001_01C7171B.2E80F87F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7171B.2E80F87F--
