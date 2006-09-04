From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Fix no_switch error path
Date: Mon, 04 Sep 2006 17:39:29 +0530
Message-ID: <1157371769.11322.270077842@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1157371769113221";
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

--_----------=_1157371769113221
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 4 Sep 2006 12:09:29 UT

Tony,

Attached patch fixes no_switch error path. 

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - Or how I learned to stop worrying and
                          love email again


--_----------=_1157371769113221
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Fix-no_switch-error-path.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-ARM-OMAP-Fix-no_switch-error-path.patch"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 4 Sep 2006 12:09:29 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBN
b24sIDQgU2VwIDIwMDYgMjM6MDg6NTkgKzA1MzAKU3ViamVjdDogW1BBVENI
XSBBUk06IE9NQVA6IEZpeCBub19zd2l0Y2ggZXJyb3IgcGF0aC4KClNpZ25l
ZC1vZmYtYnk6IEtvbWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28u
Y29tPgoKLS0tCgogZHJpdmVycy9tbWMvb21hcC5jIHwgICAgMyArKy0KIDEg
ZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygt
KQoKMGY3ZWRiMDcyMTc2NWMxMzE4ZmI5ZTYxYmEzM2Y4OGRlZWFlZjEyNApk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvb21hcC5jIGIvZHJpdmVycy9tbWMv
b21hcC5jCmluZGV4IDBmMWY5OWIuLmFlMDhhMzcgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbW1jL29tYXAuYworKysgYi9kcml2ZXJzL21tYy9vbWFwLmMKQEAg
LTExNjMsOCArMTE2Myw5IEBAIHN0YXRpYyBpbnQgX19pbml0IG1tY19vbWFw
X3Byb2JlKHN0cnVjdCAKIAogCW1tY19hZGRfaG9zdChtbWMpOwogCi1ub19z
d2l0Y2g6CiAJcmV0dXJuIDA7CisKK25vX3N3aXRjaDoKIAkvKiBGSVhNRTog
RnJlZSBvdGhlciByZXNvdXJjZXMgdG9vLiAqLwogCWlmIChob3N0KSB7CiAJ
CWlmIChob3N0LT5pY2xrICYmICFJU19FUlIoaG9zdC0+aWNsaykpCi0tIAox
LjMuMwoK

--_----------=_1157371769113221
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_1157371769113221--
