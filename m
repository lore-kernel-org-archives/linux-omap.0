From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Remove IVA IRQ bank
Date: Mon, 28 Aug 2006 18:04:43 +0530
Message-ID: <1156768483.6544.269568352@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_115676848365440";
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

--_----------=_115676848365440
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 28 Aug 2006 12:34:43 UT

Tony,

Attached the patch as per discussion on following thread:

http://linux.omap.com/pipermail/linux-omap-open-source/2006-August/007820.html

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - Access all of your messages and folders
                          wherever you are


--_----------=_115676848365440
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Remove-IVA-IRQ-bank.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="0001-ARM-OMAP-Remove-IVA-IRQ-bank.patch"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Mon, 28 Aug 2006 12:34:43 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBN
b24sIDI4IEF1ZyAyMDA2IDIzOjMxOjQ1ICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBSZW1vdmUgSVZBIElSUSBiYW5rCgpBUk0xMSBjYW4n
dCBhY2Nlc3MgdGhlIElWQSBpbnRlcnJ1cHQgY29udHJvbGxlciBmcm9tCklW
QSBzbGF2ZSBwb3J0LgoKRnJvbSBSaWNoYXJkIFdvb2RydWZmOgoKIlRoZSAw
eDQwMDAwMDAwIGlzIGFuIElWQS1BUk03IGxvY2FsIGJ1cyBhZGRyZXNzLgpU
aGUgSVZBLUlOVEMgaXMgTk9UIGFjY2Vzc2libGUgdGhyb3VnaCB0aGUgSVZB
LUwzLVNsYXZlIFBvcnQuClRoZSBjdXJyZW50IFRSTSBkb2VzIHNheSB0aGlz
IGRpcmVjdGx5IGFuZCBpbmRpcmVjdGx5IGluIGEgZmV3IHNwb3RzIGFuZApp
biBmaWd1cmVzLiIKClNpZ25lZC1vZmYtYnk6IEtvbWFsIFNoYWggPGtvbWFs
X3NoYWg4MDIwMDNAeWFob28uY29tPgoKLS0tCgogYXJjaC9hcm0vbWFjaC1v
bWFwMi9pcnEuYyB8ICAgMTIgLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5n
ZWQsIDAgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgo2YmI1NzRm
MGJmZjg2Yzc5NWU3MDBhYWY2N2M4YTEzNGU2YThiNGQxCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9tYWNoLW9tYXAyL2lycS5jIGIvYXJjaC9hcm0vbWFjaC1v
bWFwMi9pcnEuYwppbmRleCBkZmMzYjM1Li4xZWQyZmZmIDEwMDY0NAotLS0g
YS9hcmNoL2FybS9tYWNoLW9tYXAyL2lycS5jCisrKyBiL2FyY2gvYXJtL21h
Y2gtb21hcDIvaXJxLmMKQEAgLTQxLDE4ICs0MSw2IEBAIHN0YXRpYyBzdHJ1
Y3Qgb21hcF9pcnFfYmFuayB7CiAJCS5ucl9pcnFzCT0gOTYsCiAJfSwgewog
CQkvKiBYWFg6IERTUCBJTlRDICovCi0KLSNpZiAwCi0JLyoKLQkgKiBDb21t
ZW50ZWQgb3V0IGZvciBub3cgdW50aWwgd2UgZml4IHRoZSBJVkEgY2xvY2tp
bmcKLQkgKi8KLSNpZmRlZiBDT05GSUdfQVJDSF9PTUFQMjQyMAotCX0sIHsK
LQkJLyogSVZBIElOVEMgKDI0MjAgb25seSkgKi8KLQkJLmJhc2VfcmVnCT0g
T01BUDI0WFhfSVZBX0lOVENfQkFTRSwKLQkJLm5yX2lycXMJPSAxNiwJLyog
QWN0dWFsbHkgMzIsIGJ1dCBvbmx5IDE2IGFyZSB1c2VkICovCi0jZW5kaWYK
LSNlbmRpZgogCX0KIH07CiAKLS0gCjEuMy4zCgo=

--_----------=_115676848365440
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_115676848365440--
