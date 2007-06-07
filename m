From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: [PATCH] ARM: OMAP: Fix omap1510-generic board compilation.
Date: Thu, 7 Jun 2007 04:45:38 +0200
Message-ID: <fb249edb0706061945n20d12010scf13154d981c0657@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_31542_27116340.1181184338923"
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

------=_Part_31542_27116340.1181184338923
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Move an #endif so that it doesn't hide the mmc config declaration.
Minor formatting change.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_31542_27116340.1181184338923
Content-Type: text/plain;
	name=0007-ARM-OMAP-Fix-omap1510-generic-building-out-of-defconfig.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2moqa5o
Content-Disposition: attachment;
	filename="0007-ARM-OMAP-Fix-omap1510-generic-building-out-of-defconfig.txt"

RnJvbSBkMGVjNDBjNDg4OGU4ZDAyODFhZTM4YWJkNWRlNGNhYmE1YWRmYzNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGJhbHJvZ0B6YWJvci5vcmc+
CkRhdGU6IFRodSwgNyBKdW4gMjAwNyAwNToyNjo0MyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFS
TTogT01BUDogRml4IG9tYXAxNTEwLWdlbmVyaWMgYnVpbGRpbmcgb3V0IG9mIGRlZmNvbmZpZy4K
Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2FyZC1nZW5lcmljLmMgfCAgICA3ICsrKy0tLS0K
IDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDEvYm9hcmQtZ2VuZXJpYy5jIGIvYXJjaC9hcm0vbWFj
aC1vbWFwMS9ib2FyZC1nZW5lcmljLmMKaW5kZXggMzNkMDFhZC4uMjlmYTM2NCAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2FyZC1nZW5lcmljLmMKKysrIGIvYXJjaC9hcm0vbWFj
aC1vbWFwMS9ib2FyZC1nZW5lcmljLmMKQEAgLTU1LDYgKzU1LDcgQEAgc3RhdGljIHN0cnVjdCBv
bWFwX3VzYl9jb25maWcgZ2VuZXJpYzE2MTBfdXNiX2NvbmZpZyBfX2luaXRkYXRhID0gewogCS5o
bWNfbW9kZQk9IDE2LAogCS5waW5zWzBdCT0gNiwKIH07CisjZW5kaWYKIAogc3RhdGljIHN0cnVj
dCBvbWFwX21tY19jb25maWcgZ2VuZXJpY19tbWNfY29uZmlnIF9faW5pdGRhdGEgPSB7CiAJLm1t
YyBbMF0gPSB7CkBAIC03MywxNSArNzQsMTMgQEAgc3RhdGljIHN0cnVjdCBvbWFwX21tY19jb25m
aWcgZ2VuZXJpY19tbWNfY29uZmlnIF9faW5pdGRhdGEgPSB7CiAJfSwKIH07CiAKLSNlbmRpZgot
CiBzdGF0aWMgc3RydWN0IG9tYXBfdWFydF9jb25maWcgZ2VuZXJpY191YXJ0X2NvbmZpZyBfX2lu
aXRkYXRhID0gewogCS5lbmFibGVkX3VhcnRzID0gKCgxIDw8IDApIHwgKDEgPDwgMSkgfCAoMSA8
PCAyKSksCiB9OwogCiBzdGF0aWMgc3RydWN0IG9tYXBfYm9hcmRfY29uZmlnX2tlcm5lbCBnZW5l
cmljX2NvbmZpZ1tdID0gewotCXsgT01BUF9UQUdfVVNCLCAgICAgICAgICAgTlVMTCB9LAotCXsg
T01BUF9UQUdfTU1DLCAgICAgICAgICAgJmdlbmVyaWNfbW1jX2NvbmZpZyB9LAorCXsgT01BUF9U
QUdfVVNCLAkJTlVMTCB9LAorCXsgT01BUF9UQUdfTU1DLAkJJmdlbmVyaWNfbW1jX2NvbmZpZyB9
LAogCXsgT01BUF9UQUdfVUFSVCwJJmdlbmVyaWNfdWFydF9jb25maWcgfSwKIH07CiAKLS0gCjEu
NC40LjMKCg==
------=_Part_31542_27116340.1181184338923
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_31542_27116340.1181184338923--
