From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: ARM: OMAP: Remove .id and .class in menelaus I2C driver
Date: Fri, 15 Jun 2007 11:33:50 +0530
Message-ID: <5d5443650706142303p2a8c7791y68d1bf60e96fa73a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_49245_19910045.1181887430314"
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_49245_19910045.1181887430314
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
--Trilok Soni

------=_Part_49245_19910045.1181887430314
Content-Type: text/x-patch;
	name=0001-ARM-OMAP-Remove-.id-and-.class-in-menelaus-I2C-driver.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2y9853w
Content-Disposition: attachment;
	filename="0001-ARM-OMAP-Remove-.id-and-.class-in-menelaus-I2C-driver.patch"

RnJvbSBlZDg1ZjUyYjc2YWY4NjZkNWVmYjMzMWQ2OTY0YmE1MGI4YTg0MmI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcmlsb2sgU29uaSA8c29uaS50cmlsb2tAZ21haWwuY29tPgpE
YXRlOiBGcmksIDE1IEp1biAyMDA3IDE3OjAxOjUzICswNTMwClN1YmplY3Q6IFtQQVRDSF0gQVJN
OiBPTUFQOiBSZW1vdmUgLmlkIGFuZCAuY2xhc3MgaW4gbWVuZWxhdXMgSTJDIGRyaXZlcgoKLSAu
aWQgYW5kIC5jbGFzcyBtZW1iZXJzIGFyZSBub3QgcmVxdWlyZWQgbm93LgotIFJlYWxseSBrZnJl
ZSB0aGUgbWVuZWxhdXNfY2hpcC4KClNpZ25lZC1vZmYtYnk6IFRyaWxvayBTb25pIDxzb25pLnRy
aWxva0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9pMmMvY2hpcHMvbWVuZWxhdXMuYyB8ICAgIDMg
Ky0tCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9jaGlwcy9tZW5lbGF1cy5jIGIvZHJpdmVycy9pMmMvY2hp
cHMvbWVuZWxhdXMuYwppbmRleCBlYWE0ZTFjLi40ODRhMjNlIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2kyYy9jaGlwcy9tZW5lbGF1cy5jCisrKyBiL2RyaXZlcnMvaTJjL2NoaXBzL21lbmVsYXVzLmMK
QEAgLTEyMzksNiArMTIzOSw3IEBAIHN0YXRpYyBpbnQgX19leGl0IG1lbmVsYXVzX3JlbW92ZShz
dHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQogCXN0cnVjdCBtZW5lbGF1c19jaGlwCSptZW5lbGF1
cyA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOwogCiAJZnJlZV9pcnEoY2xpZW50LT5pcnEs
IG1lbmVsYXVzKTsKKwlrZnJlZShtZW5lbGF1cyk7CiAJdGhlX21lbmVsYXVzID0gTlVMTDsKIAly
ZXR1cm4gMDsKIH0KQEAgLTEyNDcsOCArMTI0OCw2IEBAIHN0YXRpYyBzdHJ1Y3QgaTJjX2RyaXZl
ciBtZW5lbGF1c19pMmNfZHJpdmVyID0gewogCS5kcml2ZXIgPSB7CiAJCS5uYW1lCQk9IERSSVZF
Ul9OQU1FLAogCX0sCi0JLmlkCQk9IEkyQ19EUklWRVJJRF9NSVNDLCAvKkZJWE1FOmFjY3JvZGlu
ZyB0byBpMmMtaWRzLmggKi8KLQkuY2xhc3MJCT0gSTJDX0NMQVNTX0hXTU9OLAogCS5wcm9iZQkJ
PSBtZW5lbGF1c19wcm9iZSwKIAkucmVtb3ZlCQk9IF9fZXhpdF9wKG1lbmVsYXVzX3JlbW92ZSks
CiB9OwotLSAKMS41LjAKCg==
------=_Part_49245_19910045.1181887430314
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_49245_19910045.1181887430314--
