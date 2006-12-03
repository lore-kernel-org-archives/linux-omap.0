From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] UpdateMakefile and Kconfig for TWL4030
Date: Sun, 3 Dec 2006 14:36:25 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE18@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7171A.B3F0E287"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7171A.B3F0E287
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

The attached patch updates i2c/chips/Makefile and Kconfig for TWL4030
driver.

=20

Regards,

Khasim


------_=_NextPart_001_01C7171A.B3F0E287
Content-Type: application/octet-stream;
	name="twl4030_enable.patch"
Content-Transfer-Encoding: base64
Content-Description: twl4030_enable.patch
Content-Disposition: attachment;
	filename="twl4030_enable.patch"

VGhpcyBwYXRjaCBlbmFibGVzIFRXTDQwMzAgaW4gaTJjL2NoaXBzIEtjb25maWcgYW5kIE1ha2Vm
aWxlCgpTaWduZWQtb2ZmLWJ5OiBTeWVkIE1vaGFtbWVkIEtoYXNpbSAgPHgwa2hhc2ltQHRpLmNv
bT4KCkZpbGVzIENoYW5nZWQ6CiBLY29uZmlnICB8ICAgIDYgKysrKysrCiBNYWtlZmlsZSB8ICAg
IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KZGlmZiAtcHVyTiBsaW51eC1vbWFwL2RyaXZlcnMvaTJjL2NoaXBzL0tjb25maWcgZGV2cHRf
YnJhbmNoL2RyaXZlcnMvaTJjL2NoaXBzL0tjb25maWcKLS0tIGxpbnV4LW9tYXAvZHJpdmVycy9p
MmMvY2hpcHMvS2NvbmZpZwkyMDA2LTExLTIwIDIxOjU1OjIzLjAwMDAwMDAwMCAtMDYwMAorKysg
ZGV2cHRfYnJhbmNoL2RyaXZlcnMvaTJjL2NoaXBzL0tjb25maWcJMjAwNi0xMi0wMSAyMzo0NTox
MS4wMDAwMDAwMDAgLTA2MDAKQEAgLTEyMSw2ICsxMjEsMTIgQEAgY29uZmlnIE1FTkVMQVVTCiAJ
aGVscAogCSAgU2F5IHllcyBoZXJlIGlmIHlvdSBoYXZlIE1lbmVsYXVzIGNoaXAgb24geW91ciBi
b2FyZAogCitjb25maWcgVFdMNDAzMF9DT1JFCisJYm9vbCAiVEkncyBUV0w0MDMwIGNvbXBhbmlv
biBjaGlwIENvcmUgRHJpdmVyIFN1cHBvcnQiCisJZGVwZW5kcyBvbiBJMkM9eSAmJiBBUkNIX09N
QVAyNFhYCisJaGVscAorCSAgU2F5IHllcyBoZXJlIGlmIHlvdSBoYXZlIFRXTDQwMzAgY2hpcCBv
biB5b3VyIGJvYXJkCisKIGNvbmZpZyBTRU5TT1JTX000MVQwMAogCXRyaXN0YXRlICJTVCBNNDFU
MDAgUlRDIGNoaXAiCiAJZGVwZW5kcyBvbiBJMkMgJiYgUFBDMzIKZGlmZiAtcHVyTiBsaW51eC1v
bWFwL2RyaXZlcnMvaTJjL2NoaXBzL01ha2VmaWxlIGRldnB0X2JyYW5jaC9kcml2ZXJzL2kyYy9j
aGlwcy9NYWtlZmlsZQotLS0gbGludXgtb21hcC9kcml2ZXJzL2kyYy9jaGlwcy9NYWtlZmlsZQky
MDA2LTExLTIwIDIxOjU1OjIzLjAwMDAwMDAwMCAtMDYwMAorKysgZGV2cHRfYnJhbmNoL2RyaXZl
cnMvaTJjL2NoaXBzL01ha2VmaWxlCTIwMDYtMTItMDEgMjM6NDU6MTEuMDAwMDAwMDAwIC0wNjAw
CkBAIC0xNSw2ICsxNSw3IEBAIG9iai0kKENPTkZJR19UUFM2NTAxMCkJCSs9IHRwczY1MDEwLm8K
IG9iai0kKENPTkZJR19TRU5TT1JTX1RMVjMyMEFJQzIzKSArPSB0bHYzMjBhaWMyMy5vCiBvYmot
JChDT05GSUdfR1BJT0VYUEFOREVSX09NQVApCSs9IGdwaW9fZXhwYW5kZXJfb21hcC5vCiBvYmot
JChDT05GSUdfTUVORUxBVVMpCQkrPSBtZW5lbGF1cy5vCitvYmotJChDT05GSUdfVFdMNDAzMF9D
T1JFKSAgICAgICs9IHR3bDQwMzBfY29yZS5vCiBvYmotJChDT05GSUdfUlRDX1gxMjA1X0kyQykJ
Kz0geDEyMDUubwogCiBpZmVxICgkKENPTkZJR19JMkNfREVCVUdfQ0hJUCkseSkK

------_=_NextPart_001_01C7171A.B3F0E287
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7171A.B3F0E287--
