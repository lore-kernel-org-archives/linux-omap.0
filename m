From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Exporting reserved APIs in GPMC library.
Date: Mon, 27 Nov 2006 10:15:24 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01F7E534@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7123F.3E8E3412"
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

------_=_NextPart_001_01C7123F.3E8E3412
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch is to export two APIs (gpmc_cs_set_reserved and
gpmc_cs_reserved) of GPMC library.

This allows other libraries and drivers to access these APIs with out
doing a gpmc_request.=20

Reason: If I have already configured a GPMC CS in boot loader I might
not be interested in doing the same again in Kernel. However I might
want to reserve this particular CS so that it doesn't show as free when
others do a gpmc_request.=20

Regards,
Khasim


------_=_NextPart_001_01C7123F.3E8E3412
Content-Type: application/octet-stream;
	name="gpmc_exportedapi.patch"
Content-Transfer-Encoding: base64
Content-Description: gpmc_exportedapi.patch
Content-Disposition: attachment;
	filename="gpmc_exportedapi.patch"

VGhpcyBwYXRjaCBleHBvcnRzIHR3byByZXNlcnZlZCBBUElzIGdwbWNfY3Nfc2V0X3Jlc2VydmVk
IGFuZCBncG1jX2NzX3Jlc2VydmVkLgoKU2lnbmVkLW9mZi1ieTogU3llZCBNb2hhbW1lZCBLaGFz
aW0gIDx4MGtoYXNpbUB0aS5jb20+CgpGaWxlcyBDaGFuZ2VkOgogZ3BtYy5jIHwgICAxMCArKysr
KysrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC1vbWFwL2FyY2gvYXJtL21hY2gtb21hcDIv
Z3BtYy5jCTIwMDYtMTEtMjAgMjE6NTQ6MDEuMDAwMDAwMDAwIC0wNjAwCisrKyBteV9saW51eF9k
ZXZwdC9hcmNoL2FybS9tYWNoLW9tYXAyL2dwbWMuYwkyMDA2LTExLTI3IDA5OjMzOjIxLjAwMDAw
MDAwMCAtMDYwMApAQCAtMjY0LDE0ICsyNjQsMjAgQEAgc3RhdGljIGludCBncG1jX2NzX21lbV9l
bmFibGVkKGludCBjcykKIAlyZXR1cm4gbCAmICgxIDw8IDYpOwogfQogCi1zdGF0aWMgdm9pZCBn
cG1jX2NzX3NldF9yZXNlcnZlZChpbnQgY3MsIGludCByZXNlcnZlZCkKK3ZvaWQgZ3BtY19jc19z
ZXRfcmVzZXJ2ZWQoaW50IGNzLCBpbnQgcmVzZXJ2ZWQpCiB7CisJaWYgKGNzID4gR1BNQ19DU19O
VU0pCisJCXJldHVybiAtRU5PREVWOworCQogCWdwbWNfY3NfbWFwICY9IH4oMSA8PCBjcyk7CiAJ
Z3BtY19jc19tYXAgfD0gKHJlc2VydmVkID8gMSA6IDApIDw8IGNzOwogfQogCi1zdGF0aWMgaW50
IGdwbWNfY3NfcmVzZXJ2ZWQoaW50IGNzKQoraW50IGdwbWNfY3NfcmVzZXJ2ZWQoaW50IGNzKQog
eworCWlmIChjcyA+IEdQTUNfQ1NfTlVNKQorCQlyZXR1cm4gLUVOT0RFVjsKKwkKIAlyZXR1cm4g
Z3BtY19jc19tYXAgJiAoMSA8PCBjcyk7CiB9CiAK

------_=_NextPart_001_01C7123F.3E8E3412
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7123F.3E8E3412--
