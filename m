From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] i2c-omap.c modified for 2430 I2C controller
Date: Sun, 3 Dec 2006 14:34:22 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE13@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7171A.6AD74A74"
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

------_=_NextPart_001_01C7171A.6AD74A74
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

In OMAP 2430 the DATA register is only 8 bits. In existing bus driver
(i2c-omap.c) we were writing 16 bits (if len>1).=20

=20

In order to do a multi byte read / write we need to update the I2C FIFO
threshold values and do a continuous write/read from DATA register. I
will take up this task later some time along with I2C HS. For now, the
attached patch makes I2C functional for 2430.

=20

Regards,

Khasim


------_=_NextPart_001_01C7171A.6AD74A74
Content-Type: application/octet-stream;
	name="i2c_omap.patch"
Content-Transfer-Encoding: base64
Content-Description: i2c_omap.patch
Content-Disposition: attachment;
	filename="i2c_omap.patch"

SW4gT01BUCAyNDMwIHRoZSBJMkMgREFUQSBSZWdpc3RlciBpcyA4Yml0IHdpZGUsIHRoZSBsb2dp
YyB0byB3cml0ZSAxNmJpdCB3b3JkIGRvZXNuJ3QgYXBwbHkgZm9yIE9NQVAyNDMwIEkyQyBjb250
cm9sbGVyLgoKU2lnbmVkLW9mZi1ieTogU3llZCBNb2hhbW1lZCBLaGFzaW0gIDx4MGtoYXNpbUB0
aS5jb20+CgpGaWxlcyBDaGFuZ2VkOgogaTJjLW9tYXAuYyB8ICAgMjIgKysrKysrKysrKysrKysr
Ky0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQoKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KZGlmZiAtcHVyTiBsaW51eC1vbWFwL2RyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtb21hcC5jIGRldnB0X2JyYW5jaC9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9t
YXAuYwotLS0gbGludXgtb21hcC9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9tYXAuYwkyMDA2LTEx
LTIwIDIxOjU1OjIyLjAwMDAwMDAwMCAtMDYwMAorKysgZGV2cHRfYnJhbmNoL2RyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtb21hcC5jCTIwMDYtMTItMDMgMTM6MDc6MzQuMDAwMDAwMDAwIC0wNjAwCkBA
IC00NzgsOSArNDc4LDE0IEBAIG9tYXBfaTJjX2lzcihpbnQgdGhpc19pcnEsIHZvaWQgKmRldl9p
ZCkKIAkJCWlmIChkZXYtPmJ1Zl9sZW4pIHsKIAkJCQkqZGV2LT5idWYrKyA9IHc7CiAJCQkJZGV2
LT5idWZfbGVuLS07Ci0JCQkJaWYgKGRldi0+YnVmX2xlbikgewotCQkJCQkqZGV2LT5idWYrKyA9
IHcgPj4gODsKLQkJCQkJZGV2LT5idWZfbGVuLS07CisJCQkJLyoKKwkJCQkgKiBEYXRhIHJlZyBp
biAyNDMwIGlzIDggYml0IHdpZGUsIAorCQkJCSAqLworCQkJCWlmICghY3B1X2lzX29tYXAyNDMw
KCkpIHsKKwkJCQkJaWYgKGRldi0+YnVmX2xlbikgeworCQkJCQkJKmRldi0+YnVmKysgPSB3ID4+
IDg7CisJCQkJCQlkZXYtPmJ1Zl9sZW4tLTsKKwkJCQkJfQogCQkJCX0KIAkJCX0gZWxzZQogCQkJ
CWRldl9lcnIoZGV2LT5kZXYsICJSUkRZIElSUSB3aGlsZSBubyBkYXRhIgpAQCAtNDkzLDkgKzQ5
OCwxNCBAQCBvbWFwX2kyY19pc3IoaW50IHRoaXNfaXJxLCB2b2lkICpkZXZfaWQpCiAJCQlpZiAo
ZGV2LT5idWZfbGVuKSB7CiAJCQkJdyA9ICpkZXYtPmJ1ZisrOwogCQkJCWRldi0+YnVmX2xlbi0t
OwotCQkJCWlmIChkZXYtPmJ1Zl9sZW4pIHsKLQkJCQkJdyB8PSAqZGV2LT5idWYrKyA8PCA4Owot
CQkJCQlkZXYtPmJ1Zl9sZW4tLTsKKwkJCQkvKgorCQkJCSAqIERhdGEgcmVnIGluIDI0MzAgaXMg
OCBiaXQgd2lkZSwgCisJCQkJICovCisJCQkJaWYgKCFjcHVfaXNfb21hcDI0MzAoKSkgeworCQkJ
CQlpZiAoZGV2LT5idWZfbGVuKSB7CisJCQkJCQl3IHw9ICpkZXYtPmJ1ZisrIDw8IDg7CisJCQkJ
CQlkZXYtPmJ1Zl9sZW4tLTsKKwkJCQkJfQogCQkJCX0KIAkJCX0gZWxzZQogCQkJCWRldl9lcnIo
ZGV2LT5kZXYsICJYUkRZIElSUSB3aGlsZSBubyIK

------_=_NextPart_001_01C7171A.6AD74A74
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7171A.6AD74A74--
