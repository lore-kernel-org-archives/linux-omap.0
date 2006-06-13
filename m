From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Make McBSP KConfigurable.
Date: Tue, 13 Jun 2006 08:17:36 -0700
Message-ID: <1150211856.20744.263714230@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1150211856207440";
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

--_----------=_1150211856207440
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Tue, 13 Jun 2006 15:17:36 UT

Make default selecton to "yes" for McBSP.

-- 
http://www.fastmail.fm - One of many happy users:
  http://www.fastmail.fm/docs/quotes.html


--_----------=_1150211856207440
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Make-McBSP-KConfigurable.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-Make-McBSP-KConfigurable.patch"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Tue, 13 Jun 2006 15:17:36 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBU
dWUsIDEzIEp1biAyMDA2IDIyOjQ5OjE0ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBNYWtlIE1jQlNQIEtDb25maWd1cmFibGUuCgpTaWdu
ZWQtb2ZmLWJ5OiBLb21hbCBTaGFoIDxrb21hbF9zaGFoODAyMDAzQHlhaG9v
LmNvbT4KCi0tLQoKIGFyY2gvYXJtL3BsYXQtb21hcC9LY29uZmlnICB8ICAg
IDggKysrKysrKysKIGFyY2gvYXJtL3BsYXQtb21hcC9NYWtlZmlsZSB8ICAg
IDQgKysrLQogMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9ucygtKQoKYjk1ZGJjMTRmOTgyMWUzM2I3Y2RhMGUxY2FmYzY5
MTJjOGFjYTljZgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vcGxhdC1vbWFwL0tj
b25maWcgYi9hcmNoL2FybS9wbGF0LW9tYXAvS2NvbmZpZwppbmRleCA4YWNk
ZWI3Li43NWYxNDk0IDEwMDY0NAotLS0gYS9hcmNoL2FybS9wbGF0LW9tYXAv
S2NvbmZpZworKysgYi9hcmNoL2FybS9wbGF0LW9tYXAvS2NvbmZpZwpAQCAt
MTAxLDYgKzEwMSwxNCBAQCBjb25maWcgT01BUF9TVElfQ09OU09MRQogCWhl
bHAKIAkgIFRoaXMgZW5hYmxlcyBhIGNvbnNvbGUgZHJpdmVyIGJ5IHdheSBv
ZiBTVEkvWFRJLgogCitjb25maWcgT01BUF9NQ0JTUAorCWJvb2wgIk1jQlNQ
IHN1cHBvcnQiCisJZGVwZW5kcyBvbiBBUkNIX09NQVAKKwlkZWZhdWx0IHkK
KwloZWxwCisJICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IHN1cHBvcnQgZm9y
IHRoZSBPTUFQIE11bHRpY2hhbm5lbAorCSAgQnVmZmVyZWQgU2VyaWFsIFBv
cnQuCisKIGNob2ljZQogICAgICAgICBwcm9tcHQgIlN5c3RlbSB0aW1lciIK
IAlkZWZhdWx0IE9NQVBfTVBVX1RJTUVSCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9wbGF0LW9tYXAvTWFrZWZpbGUgYi9hcmNoL2FybS9wbGF0LW9tYXAvTWFr
ZWZpbGUKaW5kZXggMzRiYThmZC4uZmRmZGVjYiAxMDA2NDQKLS0tIGEvYXJj
aC9hcm0vcGxhdC1vbWFwL01ha2VmaWxlCisrKyBiL2FyY2gvYXJtL3BsYXQt
b21hcC9NYWtlZmlsZQpAQCAtMyw3ICszLDcgQEAgIyBNYWtlZmlsZSBmb3Ig
dGhlIGxpbnV4IGtlcm5lbC4KICMKIAogIyBDb21tb24gc3VwcG9ydAotb2Jq
LXkgOj0gY29tbW9uLm8gc3JhbS5vIHNyYW0tZm4ubyBjbG9jay5vIGRldmlj
ZXMubyBkbWEubyBtdXgubyBncGlvLm8gbWNic3AubyB1c2IubyBmYi5vCitv
YmoteSA6PSBjb21tb24ubyBzcmFtLm8gc3JhbS1mbi5vIGNsb2NrLm8gZGV2
aWNlcy5vIGRtYS5vIG11eC5vIGdwaW8ubyB1c2IubyBmYi5vCiBvYmotbSA6
PQogb2JqLW4gOj0KIG9iai0gIDo9CkBAIC0xNiw2ICsxNiw4IEBAIG9iai0k
KENPTkZJR19BUkNIX09NQVAxNlhYKSArPSBvY3BpLm8KICMgU1RJIHN1cHBv
cnQKIG9iai0kKENPTkZJR19PTUFQX1NUSSkgKz0gc3RpLwogCitvYmotJChD
T05GSUdfT01BUF9NQ0JTUCkgKz0gbWNic3AubworCiBvYmotJChDT05GSUdf
Q1BVX0ZSRVEpICs9IGNwdS1vbWFwLm8KIG9iai0kKENPTkZJR19PTUFQX0RN
X1RJTUVSKSArPSBkbXRpbWVyLm8KIG9iai0kKENPTkZJR19PTUFQX0JPT1Rf
UkVBU09OKSArPSBib290cmVhc29uLm8KLS0gCjEuMy4zCgo=

--_----------=_1150211856207440
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_1150211856207440--
