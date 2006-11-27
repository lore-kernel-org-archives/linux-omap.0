From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Exporting reserved APIs in GPMC header.
Date: Mon, 27 Nov 2006 10:16:37 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01F7E53A@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7123F.6A6E1D3A"
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

------_=_NextPart_001_01C7123F.6A6E1D3A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch is to export two APIs (gpmc_cs_set_reserved and
gpmc_cs_reserved) in gpmc.h.

This allows other libraries and drivers to access these APIs with out
doing a gpmc_request.=20

Reason: If I have already configured a GPMC CS in boot loader I might
not be interested in doing the same again in Kernel. However I might
want to reserve this particular CS so that it doesn't show as free when
others do a gpmc_request.=20

Regards,
Khasim


------_=_NextPart_001_01C7123F.6A6E1D3A
Content-Type: application/octet-stream;
	name="gpmc_exported_inc.patch"
Content-Transfer-Encoding: base64
Content-Description: gpmc_exported_inc.patch
Content-Disposition: attachment;
	filename="gpmc_exported_inc.patch"

VGhpcyBwYXRjaCBleHBvcnRzIHR3byByZXNlcnZlZCBBUElzIGdwbWNfY3Nfc2V0X3Jlc2VydmVk
IGFuZCBncG1jX2NzX3Jlc2VydmVkLgoKU2lnbmVkLW9mZi1ieTogU3llZCBNb2hhbW1lZCBLaGFz
aW0gIDx4MGtoYXNpbUB0aS5jb20+CgpGaWxlcyBDaGFuZ2VkOgogZ3BtYy5oIHwgICAgOCArKysr
KysrLQogMSBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09CmRpZmYgLXB1ck4gbGludXgtb21hcC9pbmNsdWRlL2FzbS1hcm0v
YXJjaC1vbWFwL2dwbWMuaCBteV9saW51eF9kZXZwdC9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFw
L2dwbWMuaAotLS0gbGludXgtb21hcC9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL2dwbWMuaAky
MDA2LTExLTIwIDIxOjU2OjU5LjAwMDAwMDAwMCAtMDYwMAorKysgbXlfbGludXhfZGV2cHQvaW5j
bHVkZS9hc20tYXJtL2FyY2gtb21hcC9ncG1jLmgJMjAwNi0xMS0yNyAwOTozNzozNi4wMDAwMDAw
MDAgLTA2MDAKQEAgLTIsNyArMiwxMSBAQAogICogR2VuZXJhbC1QdXJwb3NlIE1lbW9yeSBDb250
cm9sbGVyIGZvciBPTUFQMgogICoKICAqIENvcHlyaWdodCAoQykgMjAwNS0yMDA2IE5va2lhIENv
cnBvcmF0aW9uCi0gKgorICogCisgKiBISVNUT1JZOgorICogLS0tLS0tLQorICogRXhwb3J0ZWQg
ImNzIHJlc2VydmVkIiBBUElzCQlTeWVkIEtoYXNpbQorICogCiAgKiBUaGlzIHByb2dyYW0gaXMg
ZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQogICog
aXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJz
aW9uIDIgYXMKICAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgpA
QCAtODgsNSArOTIsNyBAQCBleHRlcm4gaW50IGdwbWNfY3NfY2FsY19kaXZpZGVyKGludCBjcywg
CiBleHRlcm4gaW50IGdwbWNfY3Nfc2V0X3RpbWluZ3MoaW50IGNzLCBjb25zdCBzdHJ1Y3QgZ3Bt
Y190aW1pbmdzICp0KTsKIGV4dGVybiBpbnQgZ3BtY19jc19yZXF1ZXN0KGludCBjcywgdW5zaWdu
ZWQgbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nICpiYXNlKTsKIGV4dGVybiB2b2lkIGdwbWNfY3Nf
ZnJlZShpbnQgY3MpOworZXh0ZXJuIHZvaWQgZ3BtY19jc19zZXRfcmVzZXJ2ZWQoaW50IGNzLCBp
bnQgcmVzZXJ2ZWQpOworZXh0ZXJuIGludCBncG1jX2NzX3Jlc2VydmVkKGludCBjcyk7CiAKICNl
bmRpZgo=

------_=_NextPart_001_01C7123F.6A6E1D3A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7123F.6A6E1D3A--
