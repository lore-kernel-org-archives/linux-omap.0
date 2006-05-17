From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Make McBSP KConfigurable
Date: Wed, 17 May 2006 03:30:49 -0700
Message-ID: <1147861849.30153.261638320@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1147861849301531";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

--_----------=_1147861849301531
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Wed, 17 May 2006 10:30:49 UT

---Komal Shah
http://komalshah.blogspot.com

--=20
http://www.fastmail.fm - And now for something completely different=85


--_----------=_1147861849301531
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Make-McBSP-KConfigurable.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-Make-McBSP-KConfigurable.patch"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Wed, 17 May 2006 10:30:49 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBX
ZWQsIDE3IE1heSAyMDA2IDE0OjMxOjM4ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBNYWtlIE1jQlNQIEtDb25maWd1cmFibGUuCgpTaWdu
ZWQtb2ZmLWJ5OiBLb21hbCBTaGFoIDxrb21hbF9zaGFoODAyMDAzQHlhaG9v
LmNvbT4KCi0tLQoKIGFyY2gvYXJtL3BsYXQtb21hcC9LY29uZmlnICB8ICAg
IDcgKysrKysrKwogYXJjaC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlIHwgICAg
NCArKystCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb25zKC0pCgo0NDYzMTI4MWQ5YmJiZTBiY2EyM2YxZmRjMDk5MWYy
NzExYjZjYTViCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvS2Nv
bmZpZyBiL2FyY2gvYXJtL3BsYXQtb21hcC9LY29uZmlnCmluZGV4IDI4Y2E1
YWQuLmY0Y2JmN2YgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9L
Y29uZmlnCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9LY29uZmlnCkBAIC0x
MDIsNiArMTAyLDEzIEBAIGNvbmZpZyBPTUFQX1NUSV9DT05TT0xFCiAJaGVs
cAogCSAgVGhpcyBlbmFibGVzIGEgY29uc29sZSBkcml2ZXIgYnkgd2F5IG9m
IFNUSS9YVEkuCiAKK2NvbmZpZyBPTUFQX01DQlNQCisJYm9vbCAiTWNCU1Ag
c3VwcG9ydCIKKwlkZXBlbmRzIG9uIEFSQ0hfT01BUAorCWhlbHAKKwkgIFNh
eSBZIGhlcmUgaWYgeW91IHdhbnQgc3VwcG9ydCBmb3IgdGhlIE9NQVAgTXVs
dGljaGFubmVsCisJICBCdWZmZXJlZCBTZXJpYWwgUG9ydC4KKwogY2hvaWNl
CiAgICAgICAgIHByb21wdCAiU3lzdGVtIHRpbWVyIgogCWRlZmF1bHQgT01B
UF9NUFVfVElNRVIKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtb21hcC9N
YWtlZmlsZSBiL2FyY2gvYXJtL3BsYXQtb21hcC9NYWtlZmlsZQppbmRleCAz
NGJhOGZkLi5mZGZkZWNiIDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9t
YXAvTWFrZWZpbGUKKysrIGIvYXJjaC9hcm0vcGxhdC1vbWFwL01ha2VmaWxl
CkBAIC0zLDcgKzMsNyBAQCAjIE1ha2VmaWxlIGZvciB0aGUgbGludXgga2Vy
bmVsLgogIwogCiAjIENvbW1vbiBzdXBwb3J0Ci1vYmoteSA6PSBjb21tb24u
byBzcmFtLm8gc3JhbS1mbi5vIGNsb2NrLm8gZGV2aWNlcy5vIGRtYS5vIG11
eC5vIGdwaW8ubyBtY2JzcC5vIHVzYi5vIGZiLm8KK29iai15IDo9IGNvbW1v
bi5vIHNyYW0ubyBzcmFtLWZuLm8gY2xvY2subyBkZXZpY2VzLm8gZG1hLm8g
bXV4Lm8gZ3Bpby5vIHVzYi5vIGZiLm8KIG9iai1tIDo9CiBvYmotbiA6PQog
b2JqLSAgOj0KQEAgLTE2LDYgKzE2LDggQEAgb2JqLSQoQ09ORklHX0FSQ0hf
T01BUDE2WFgpICs9IG9jcGkubwogIyBTVEkgc3VwcG9ydAogb2JqLSQoQ09O
RklHX09NQVBfU1RJKSArPSBzdGkvCiAKK29iai0kKENPTkZJR19PTUFQX01D
QlNQKSArPSBtY2JzcC5vCisKIG9iai0kKENPTkZJR19DUFVfRlJFUSkgKz0g
Y3B1LW9tYXAubwogb2JqLSQoQ09ORklHX09NQVBfRE1fVElNRVIpICs9IGRt
dGltZXIubwogb2JqLSQoQ09ORklHX09NQVBfQk9PVF9SRUFTT04pICs9IGJv
b3RyZWFzb24ubwotLSAKMS4zLjIuZ2RlMWQKCg==

--_----------=_1147861849301531
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_1147861849301531--
