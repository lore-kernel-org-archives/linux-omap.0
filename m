From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] I2C-1 init fix for 2430
Date: Sun, 3 Dec 2006 14:34:58 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE14@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7171A.804EDFCF"
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

------_=_NextPart_001_01C7171A.804EDFCF
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

The attached patch fixes/enables the I2C-1 for OMAP2430.=20

=20

Regards,

Khasim


------_=_NextPart_001_01C7171A.804EDFCF
Content-Type: application/octet-stream;
	name="2430_i2cinit_fix.patch"
Content-Transfer-Encoding: base64
Content-Description: 2430_i2cinit_fix.patch
Content-Disposition: attachment;
	filename="2430_i2cinit_fix.patch"

STJDLTEgZm9yIDI0MzAgd2FzIGNvbW1lbnRlZCBwcmV2aW91c2x5LCBlbmFibGVkIGluIHRoaXMg
cGF0Y2guCgpTaWduZWQtb2ZmLWJ5OiBTeWVkIE1vaGFtbWVkIEtoYXNpbSAgPHgwa2hhc2ltQHRp
LmNvbT4KCkZpbGVzIENoYW5nZWQ6CiBkZXZpY2VzLmMgfCAgICA4ICsrKysrLS0tCiAxIGZpbGVz
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KZGlmZiAtcHVyTiBsaW51eC1vbWFwL2FyY2gvYXJtL3BsYXQtb21hcC9kZXZpY2VzLmMg
ZGV2cHRfYnJhbmNoL2FyY2gvYXJtL3BsYXQtb21hcC9kZXZpY2VzLmMKLS0tIGxpbnV4LW9tYXAv
YXJjaC9hcm0vcGxhdC1vbWFwL2RldmljZXMuYwkyMDA2LTExLTI4IDA5OjU5OjI5LjAwMDAwMDAw
MCAtMDYwMAorKysgZGV2cHRfYnJhbmNoL2FyY2gvYXJtL3BsYXQtb21hcC9kZXZpY2VzLmMJMjAw
Ni0xMi0wMyAxMTo1Mzo0MC4wMDAwMDAwMDAgLTA2MDAKQEAgLTEzNiw4ICsxMzYsMTAgQEAgc3Rh
dGljIHZvaWQgb21hcF9pbml0X2kyYyh2b2lkKQogCSAqIGl0IGNhbiBpbmNsdWRlIGNsb2NraW5n
IGFuZCBhZGRyZXNzIGluZm8sIG1heWJlIG1vcmUuCiAJICovCiAJaWYgKGNwdV9pc19vbWFwMjR4
eCgpKSB7Ci0JCW9tYXBfY2ZnX3JlZyhNMTlfMjRYWF9JMkMxX1NDTCk7Ci0JCW9tYXBfY2ZnX3Jl
ZyhMMTVfMjRYWF9JMkMxX1NEQSk7CisJCWlmKG1hY2hpbmVfaXNfb21hcF9oNCgpKXsKKwkJCW9t
YXBfY2ZnX3JlZyhNMTlfMjRYWF9JMkMxX1NDTCk7CisJCQlvbWFwX2NmZ19yZWcoTDE1XzI0WFhf
STJDMV9TREEpOworCQl9CiAJfSBlbHNlIHsKIAkJb21hcF9jZmdfcmVnKEkyQ19TQ0wpOwogCQlv
bWFwX2NmZ19yZWcoSTJDX1NEQSk7CkBAIC01MDEsMTMgKzUwMywxMyBAQCBzdGF0aWMgaW50IF9f
aW5pdCBvbWFwX2luaXRfZGV2aWNlcyh2b2lkCiAJICogaW4gYWxwaGFiZXRpY2FsIG9yZGVyIHNv
IHRoZXkncmUgZWFzaWVyIHRvIHNvcnQgdGhyb3VnaC4KIAkgKi8KIAlvbWFwX2luaXRfZHNwKCk7
Ci0Jb21hcF9pbml0X2kyYygpOwogCW9tYXBfaW5pdF9rcCgpOwogCW9tYXBfaW5pdF9tbWMoKTsK
IAlvbWFwX2luaXRfdXdpcmUoKTsKIAlvbWFwX2luaXRfd2R0KCk7CiAJb21hcF9pbml0X3JuZygp
OwogI2VuZGlmCisJb21hcF9pbml0X2kyYygpOwogCXJldHVybiAwOwogfQogYXJjaF9pbml0Y2Fs
bChvbWFwX2luaXRfZGV2aWNlcyk7Cg==

------_=_NextPart_001_01C7171A.804EDFCF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7171A.804EDFCF--
