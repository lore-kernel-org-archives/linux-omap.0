From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Fix gpio expander linking error
Date: Mon, 19 Jun 2006 07:05:05 -0700
Message-ID: <1150725905.23380.264144249@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1150725905233800";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

--_----------=_1150725905233800
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Mon, 19 Jun 2006 14:05:05 UT

This patch should be applied after my gpmc apis
patch for smc91x.

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service


--_----------=_1150725905233800
Content-Disposition: attachment; filename="0001-fix-ir-build-err.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="0001-fix-ir-build-err.patch"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Mon, 19 Jun 2006 14:05:05 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBU
dWUsIDIwIEp1biAyMDA2IDAxOjAxOjQ0ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBGaXggdGhlIGZvbGxvd2luZyBncGlvIGV4cGFuZGVy
IGxpbmtpbmcgZXJyb3IsCgpnZW5lcmF0ZWQgd2hlbiB0aGUgbWFpbmxpbmUg
a2VybmVsIGlzIGNvbXBpbGVkIHdpdGggaDQgZGVmY29uZmlnLgoKOiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGByZWFkX2dwaW9fZXhwYScKYXJjaC9hcm0v
bWFjaC1vbWFwMi9idWlsdC1pbi5vKC50ZXh0KzB4MTg2Yyk6IEluIGZ1bmN0
aW9uIGAkYSc6CjogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgd3JpdGVfZ3Bp
b19leHBhJwphcmNoL2FybS9tYWNoLW9tYXAyL2J1aWx0LWluLm8oLnRleHQr
MHgxOGFjKTogSW4gZnVuY3Rpb24gYCRhJzoKClNpZ25lZC1vZmYtYnk6IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgoKLS0tCgog
YXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC1oNC5jIHwgICAgNSArKysrKwog
MSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25z
KC0pCgo4NzAxMzc3N2Q2ZTA3NmI0MTdlNDA5NTIzNjBmNTE2ZGVhMTA5ZjQw
CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWg0LmMg
Yi9hcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLWg0LmMKaW5kZXggMTE0M2Q4
Yi4uMzk1MTAxYyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9i
b2FyZC1oNC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtaDQu
YwpAQCAtMTU1LDYgKzE1NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlIGg0X3NtYzkxeF8KIAogLyogU2VsZWN0IGJldHdlZW4gdGhlIEly
REEgYW5kIGFHUFMgbW9kdWxlCiAgKi8KKyNpZiBkZWZpbmVkKENPTkZJR19P
TUFQX0lSKSB8fCBkZWZpbmVkKENPTkZJR19PTUFQX0lSX01PRFVMRSkKIHN0
YXRpYyBpbnQgaDRfc2VsZWN0X2lyZGEoc3RydWN0IGRldmljZSAqZGV2LCBp
bnQgc3RhdGUpCiB7CiAJdW5zaWduZWQgY2hhciBleHBhOwpAQCAtMjExLDYg
KzIxMiwxMCBAQCBzdGF0aWMgaW50IGg0X3RyYW5zY2VpdmVyX21vZGUoc3Ry
dWN0IGRlCiAKIAlyZXR1cm4gMDsKIH0KKyNlbHNlCitzdGF0aWMgaW50IGg0
X3NlbGVjdF9pcmRhKHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IHN0YXRlKSB7
IHJldHVybiAwOyB9CitzdGF0aWMgaW50IGg0X3RyYW5zY2VpdmVyX21vZGUo
c3RydWN0IGRldmljZSAqZGV2LCBpbnQgbW9kZSkgeyByZXR1cm4gMDsgfQor
I2VuZGlmCiAKIHN0YXRpYyBzdHJ1Y3Qgb21hcF9pcmRhX2NvbmZpZyBoNF9p
cmRhX2RhdGEgPSB7CiAJLnRyYW5zY2VpdmVyX2NhcAk9IElSX1NJUk1PREUg
fCBJUl9NSVJNT0RFIHwgSVJfRklSTU9ERSwKLS0gCjEuMy4zCgo=

--_----------=_1150725905233800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_1150725905233800--
