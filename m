From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Fix mmc driver no_switch error path
Date: Mon, 04 Sep 2006 17:46:49 +0530
Message-ID: <1157372209.5446.270078515@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_115737220954460";
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

--_----------=_115737220954460
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 4 Sep 2006 12:16:49 UT

Tony,

This patch fixes no_switch error path in probe function of mmc driver.

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - One of many happy users:
  http://www.fastmail.fm/docs/quotes.html


--_----------=_115737220954460
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Fix-mmc-driver-no_switch-error-path.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-ARM-OMAP-Fix-mmc-driver-no_switch-error-path.patch"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 4 Sep 2006 12:16:49 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBN
b24sIDQgU2VwIDIwMDYgMjM6MTU6NTcgKzA1MzAKU3ViamVjdDogW1BBVENI
XSBBUk06IE9NQVA6IEZpeCBtbWMgZHJpdmVyIG5vX3N3aXRjaCBlcnJvciBw
YXRoLgoKU2lnbmVkLW9mZi1ieTogS29tYWwgU2hhaCA8a29tYWxfc2hhaDgw
MjAwM0B5YWhvby5jb20+CgotLS0KCiBkcml2ZXJzL21tYy9vbWFwLmMgfCAg
ICAzICsrLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb25zKC0pCgozNWViOWJlNGQyMGFjMmUyNzRhMGE0YjY4NWRiOTRi
MWI1YjNkOTA4CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9vbWFwLmMgYi9k
cml2ZXJzL21tYy9vbWFwLmMKaW5kZXggMGYxZjk5Yi4uYWUwOGEzNyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9tbWMvb21hcC5jCisrKyBiL2RyaXZlcnMvbW1j
L29tYXAuYwpAQCAtMTE2Myw4ICsxMTYzLDkgQEAgc3RhdGljIGludCBfX2lu
aXQgbW1jX29tYXBfcHJvYmUoc3RydWN0IAogCiAJbW1jX2FkZF9ob3N0KG1t
Yyk7CiAKLW5vX3N3aXRjaDoKIAlyZXR1cm4gMDsKKworbm9fc3dpdGNoOgog
CS8qIEZJWE1FOiBGcmVlIG90aGVyIHJlc291cmNlcyB0b28uICovCiAJaWYg
KGhvc3QpIHsKIAkJaWYgKGhvc3QtPmljbGsgJiYgIUlTX0VSUihob3N0LT5p
Y2xrKSkKLS0gCjEuMy4zCgo=

--_----------=_115737220954460
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_115737220954460--
