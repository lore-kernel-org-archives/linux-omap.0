From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: [PATCH] IrDA: Fix omap-ir build
Date: Tue, 8 May 2007 13:11:09 +0530
Message-ID: <5d5443650705080041l5082ac73jd69ed20bfbb185e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_98561_30352007.1178610069004"
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

------=_Part_98561_30352007.1178610069004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Tony,

Attached patch fixes omap-ir build.

-- 
--Trilok Soni

------=_Part_98561_30352007.1178610069004
Content-Type: text/x-patch; name=0001-IrDA-Fix-omap-ir-build.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1g1z863
Content-Disposition: attachment; filename="0001-IrDA-Fix-omap-ir-build.patch"

RnJvbSAzZTZkNWNhZDUyYWFjMjhmZjg4YmFhNjI5NDM2MDBlNGI0OTBkZmM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUcmlsb2sgU29uaSA8c29uaS50cmlsb2tAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDggTWF5IDIwMDcgMTg6NDA6NTQgKzA1MzAKU3ViamVjdDogW1BBVENIXSBJckRB
OiBGaXggb21hcC1pciBidWlsZAoKLSB1c2UgbmV3IHNrYl9yZXNldF9tYWNfaGVhZGVyIGFuZAog
IHNrYl9jb3B5X2Zyb21fbGluZWFyX2RhdGEgZnVuY3Rpb25zLgoKU2lnbmVkLW9mZi1ieTogVHJp
bG9rIFNvbmkgPHNvbmkudHJpbG9rQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL25ldC9pcmRhL29t
YXAtaXIuYyB8ICAgIDQgKystLQogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvaXJkYS9vbWFwLWlyLmMgYi9k
cml2ZXJzL25ldC9pcmRhL29tYXAtaXIuYwppbmRleCA4NTY1OGRjLi4xZmM4YzMxIDEwMDY0NAot
LS0gYS9kcml2ZXJzL25ldC9pcmRhL29tYXAtaXIuYworKysgYi9kcml2ZXJzL25ldC9pcmRhL29t
YXAtaXIuYwpAQCAtMzk1LDcgKzM5NSw3IEBAIG9tYXBfaXJkYV9pcnEoaW50IGlycSwgdm9pZCAq
ZGV2X2lkKQogCQkJCQl3IC0gNCk7CiAKIAkJc2tiLT5kZXYgPSBkZXY7Ci0JCXNrYi0+bWFjLnJh
dyA9IHNrYi0+ZGF0YTsKKwkJc2tiX3Jlc2V0X21hY19oZWFkZXIoc2tiKTsKIAkJc2tiLT5wcm90
b2NvbCA9IGh0b25zKEVUSF9QX0lSREEpOwogCQlvbWFwX2lyLT5zdGF0cy5yeF9wYWNrZXRzKys7
CiAJCW9tYXBfaXItPnN0YXRzLnJ4X2J5dGVzICs9IHNrYi0+bGVuOwpAQCAtNDQ0LDcgKzQ0NCw3
IEBAIHN0YXRpYyBpbnQgb21hcF9pcmRhX2hhcmRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2KQogCW5ldGlmX3N0b3BfcXVldWUoZGV2KTsKIAogCS8qIENv
cHkgc2tiIGRhdGEgdG8gRE1BIGJ1ZmZlciAqLwotCW1lbWNweShvbWFwX2lyLT50eF9idWZfZG1h
X3ZpcnQsIHNrYi0+ZGF0YSwgc2tiLT5sZW4pOworCXNrYl9jb3B5X2Zyb21fbGluZWFyX2RhdGEo
c2tiLCBvbWFwX2lyLT50eF9idWZfZG1hX3ZpcnQsIHNrYi0+bGVuKTsKIAogCS8qIENvcHkgc2ti
IGRhdGEgdG8gRE1BIGJ1ZmZlciAqLwogCW9tYXBfaXItPnN0YXRzLnR4X2J5dGVzICs9IHNrYi0+
bGVuOwotLSAKMS41LjAKCg==
------=_Part_98561_30352007.1178610069004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_98561_30352007.1178610069004--
