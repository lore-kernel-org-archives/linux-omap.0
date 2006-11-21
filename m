From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] To enable I2C-2 for 2430 SDP
Date: Tue, 21 Nov 2006 00:01:12 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01F29AD2@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C70D32.72BA4389"
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

------_=_NextPart_001_01C70D32.72BA4389
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch enables I2C-2 support for 2430 SDP. On 2430SDP
Triton-2 is connected through I2C bus-2.

Please do let me know if you find any issues with the same.

Thanks & Regards,
Khasim


------_=_NextPart_001_01C70D32.72BA4389
Content-Type: application/octet-stream;
	name="2430I2C2_mach-omap2.patch"
Content-Transfer-Encoding: base64
Content-Description: 2430I2C2_mach-omap2.patch
Content-Disposition: attachment;
	filename="2430I2C2_mach-omap2.patch"

VGhpcyBwYXRjaCBlbmFibGVzIEkyQy0yIHN1cHBvcnQgZm9yIDI0MzAgU0RQLgoKU2lnbmVkLW9m
Zi1ieTogU3llZCBNb2hhbW1lZCBLaGFzaW0gIDx4MGtoYXNpbUB0aS5jb20+CgpGaWxlcyBDaGFu
Z2VkOgogZGV2aWNlcy5jIHwgICAxMCArKysrKystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CmRpZmYgLXB1
ck4gbGludXgtb21hcC9hcmNoL2FybS9tYWNoLW9tYXAyL2RldmljZXMuYyBteV9saW51eF9kZXZw
dC9hcmNoL2FybS9tYWNoLW9tYXAyL2RldmljZXMuYwotLS0gbGludXgtb21hcC9hcmNoL2FybS9t
YWNoLW9tYXAyL2RldmljZXMuYwkyMDA2LTExLTIwIDIxOjU0OjAxLjAwMDAwMDAwMCAtMDYwMAor
KysgbXlfbGludXhfZGV2cHQvYXJjaC9hcm0vbWFjaC1vbWFwMi9kZXZpY2VzLmMJMjAwNi0xMS0y
MCAyMzoxMTo1Ni4wMDAwMDAwMDAgLTA2MDAKQEAgLTUyLDExICs1MiwxMyBAQCBzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSBvbWFwX2kyY19kCiBzdGF0aWMgdm9pZCBvbWFwX2luaXRfaTJj
KHZvaWQpCiB7CiAJLyogUkVWSVNJVDogU2Vjb25kIEkyQyBub3QgaW4gdXNlIG9uIEg0PyAqLwot
CWlmIChtYWNoaW5lX2lzX29tYXBfaDQoKSB8fCBtYWNoaW5lX2lzX29tYXBfMjQzMHNkcCgpKQor
CWlmIChtYWNoaW5lX2lzX29tYXBfaDQoKSkKIAkJcmV0dXJuOwotCi0Jb21hcF9jZmdfcmVnKEox
NV8yNFhYX0kyQzJfU0NMKTsKLQlvbWFwX2NmZ19yZWcoSDE5XzI0WFhfSTJDMl9TREEpOworCQor
CWlmICghY3B1X2lzX29tYXAyNDMwKCkpeworCQlvbWFwX2NmZ19yZWcoSjE1XzI0WFhfSTJDMl9T
Q0wpOworCQlvbWFwX2NmZ19yZWcoSDE5XzI0WFhfSTJDMl9TREEpOworCX0KIAkodm9pZCkgcGxh
dGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZvbWFwX2kyY19kZXZpY2UyKTsKIH0KIAo=

------_=_NextPart_001_01C70D32.72BA4389
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C70D32.72BA4389--
