From: "Amit Kucheria" <kucheria.amit@gmail.com>
Subject: [PATCH] set_vpp works for omap1 only
Date: Fri, 19 Oct 2007 17:12:14 +0300
Message-ID: <52d486620710190712k6f5f4c52l1abf69c4cb5bb750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3743_16236503.1192803134284"
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

------=_Part_3743_16236503.1192803134284
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Along with the "unlock flash" patch from Kevin, I need the following
trivial patch to get an OMAP3 SDP booting with a jffs2 FS on NOR.

Regards,
Amit
--
Amit Kucheria, Linux developer

------=_Part_3743_16236503.1192803134284
Content-Type: application/octet-stream;
	name=0001-set_vpp-is-only-functional-for-omap1-now.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f7ys4ryy
Content-Disposition: attachment;
	filename=0001-set_vpp-is-only-functional-for-omap1-now.patch

RnJvbSA5YmQ3MDI2NThmN2RlNmM4NzBmZmNkYTBhZTA5ZTFhYjg4MWJiMTI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWl0IEt1Y2hlcmlhIDxhbWl0Lmt1Y2hlcmlhQHZlcmR1cmVu
dC5jb20+CkRhdGU6IEZyaSwgMTkgT2N0IDIwMDcgMTY6MzI6NTIgKzAzMDAKU3ViamVjdDogW1BB
VENIXSBzZXRfdnBwKCkgaXMgb25seSBmdW5jdGlvbmFsIGZvciBvbWFwMSBub3cKClNpZ25lZC1v
ZmYtYnk6IEFtaXQgS3VjaGVyaWEgPGFtaXQua3VjaGVyaWFAdmVyZHVyZW50LmNvbT4KLS0tCiBk
cml2ZXJzL210ZC9tYXBzL29tYXBfbm9yLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9t
YXBzL29tYXBfbm9yLmMgYi9kcml2ZXJzL210ZC9tYXBzL29tYXBfbm9yLmMKaW5kZXggYTBhMTJh
Zi4uYTEzNDJhMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tdGQvbWFwcy9vbWFwX25vci5jCisrKyBi
L2RyaXZlcnMvbXRkL21hcHMvb21hcF9ub3IuYwpAQCAtNjEsNyArNjEsNyBAQCBzdGF0aWMgdm9p
ZCBvbWFwX3NldF92cHAoc3RydWN0IG1hcF9pbmZvICptYXAsIGludCBlbmFibGUpCiB7CiAJc3Rh
dGljIGludAljb3VudDsKIAotCWlmICghY3B1X2lzX29tYXAyNHh4KCkpIHsKKwlpZiAoY3B1X2Ns
YXNzX2lzX29tYXAxKCkpIHsKIAkJaWYgKGVuYWJsZSkgewogCQkJaWYgKGNvdW50KysgPT0gMCkK
IAkJCQlPTUFQX0VNSUZTX0NPTkZJR19SRUcgfD0gT01BUF9FTUlGU19DT05GSUdfV1A7Ci0tIAox
LjUuMi5HSVQKCg==
------=_Part_3743_16236503.1192803134284
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_3743_16236503.1192803134284--
