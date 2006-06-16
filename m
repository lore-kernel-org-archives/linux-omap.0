From: "Komal Shah" <komal_shah802003@yahoo.com>
Subject: [PATCH] ARM: OMAP: Fix gpmc.c compilation
Date: Fri, 16 Jun 2006 04:35:04 -0700
Message-ID: <1150457704.31515.263970479@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1150457704315150";
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

--_----------=_1150457704315150
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Fri, 16 Jun 2006 11:35:04 UT

This patch is compile tested only.

--Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - Or how I learned to stop worrying and
                          love email again


--_----------=_1150457704315150
Content-Disposition: attachment; filename="0001-fix-gpmc.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="0001-fix-gpmc.patch"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Date: Fri, 16 Jun 2006 11:35:04 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBG
cmksIDE2IEp1biAyMDA2IDIyOjMwOjEwICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gQVJNOiBPTUFQOiBGaXggZ3BtYy5jIGNvbXBpbGF0aW9uIHdoZW4gREVC
VUcgaXMKCmVuYWJsZWQgYW5kIGFkZCBncG1jX2dldF9jbGtfcGVyaW9kLgpT
aWduZWQtb2ZmLWJ5OiBLb21hbCBTaGFoIDxrb21hbF9zaGFoODAyMDAzQHlh
aG9vLmNvbT4KCi0tLQoKIGFyY2gvYXJtL21hY2gtb21hcDIvZ3BtYy5jIHwg
ICAxNiArKysrKysrKysrKy0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgowMmM0NjdkZTcxNTAxMTNk
NmM4NGNiOGQ2YjIxYWQ2YzYzZjI3MmExCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLW9tYXAyL2dwbWMuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvZ3Bt
Yy5jCmluZGV4IDRhZWFhNGUuLjM0Y2RhZjggMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL21hY2gtb21hcDIvZ3BtYy5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21h
cDIvZ3BtYy5jCkBAIC03MSw2ICs3MSwxMiBAQCB1MzIgZ3BtY19jc19yZWFk
X3JlZyhpbnQgY3MsIGludCBpZHgpCiAJcmV0dXJuIF9fcmF3X3JlYWRsKGdw
bWNfY3NfYmFzZSArIChjcyAqIEdQTUNfQ1NfU0laRSkgKyBpZHgpOwogfQog
CitzdGF0aWMgdW5zaWduZWQgbG9uZyBncG1jX2dldF9jbGtfcGVyaW9kKGlu
dCBkaXYpCit7CisJLyogSW4gcGljb3NlY29uZHMgKi8KKwlyZXR1cm4gMTAw
MDAwMDAwMCAvICgoY2xrX2dldF9yYXRlKGdwbWNfbDNfY2xrKS9kaXYpIC8g
MTAwMCk7Cit9CisKIC8qIFRPRE86IEFkZCBzdXBwb3J0IGZvciBncG1jX2Zj
ayB0byBjbG9jayBmcmFtZXdvcmsgYW5kIHVzZSBpdCAqLwogc3RhdGljIHVu
c2lnbmVkIGxvbmcgZ3BtY19nZXRfZmNsa19wZXJpb2Qodm9pZCkKIHsKQEAg
LTkzLDcgKzk5LDcgQEAgc3RhdGljIGludCBzZXRfZ3BtY190aW1pbmdfcmVn
KGludCBjcywgaQogCQkJICAgICAgIGludCB0aW1lLCBpbnQgZGl2LCBjb25z
dCBjaGFyICpuYW1lKQogI2Vsc2UKIHN0YXRpYyBpbnQgc2V0X2dwbWNfdGlt
aW5nX3JlZyhpbnQgY3MsIGludCByZWcsIGludCBzdF9iaXQsIGludCBlbmRf
Yml0LAotCQkJICAgICAgIGludCB0aW1lKQorCQkJICAgICAgIGludCB0aW1l
LCBpbnQgZGl2KQogI2VuZGlmCiB7CiAJdTMyIGw7CkBAIC0xMjQsMTEgKzEz
MCwxMSBAQCAjZW5kaWYKICNpZmRlZiBERUJVRwogI2RlZmluZSBHUE1DX1NF
VF9PTkUocmVnLCBzdCwgZW5kLCBmaWVsZCkgXAogCWlmIChzZXRfZ3BtY190
aW1pbmdfcmVnKGNzLCAocmVnKSwgKHN0KSwgKGVuZCksCQlcCi0JCQl0LT5m
aWVsZCwgI2ZpZWxkKSA8IDApCQkJXAorCQkJdC0+ZmllbGQsIGRpdiwgI2Zp
ZWxkKSA8IDApCQkJXAogCQlyZXR1cm4gLTEKICNlbHNlCiAjZGVmaW5lIEdQ
TUNfU0VUX09ORShyZWcsIHN0LCBlbmQsIGZpZWxkKSBcCi0JaWYgKHNldF9n
cG1jX3RpbWluZ19yZWcoY3MsIChyZWcpLCAoc3QpLCAoZW5kKSwgdC0+Zmll
bGQpIDwgMCkgXAorCWlmIChzZXRfZ3BtY190aW1pbmdfcmVnKGNzLCAocmVn
KSwgKHN0KSwgKGVuZCksIHQtPmZpZWxkLCBkaXYpIDwgMCkgXAogCQlyZXR1
cm4gLTEKICNlbmRpZgogCkBAIC0xNzYsOCArMTgyLDggQEAgaW50IGdwbWNf
Y3Nfc2V0X3RpbWluZ3MoaW50IGNzLCBjb25zdCBzdAogCUdQTUNfU0VUX09O
RShHUE1DX0NTX0NPTkZJRzUsIDI0LCAyNywgcGFnZV9idXJzdF9hY2Nlc3Mp
OwogCiAjaWZkZWYgREVCVUcKLQlwcmludGsoS0VSTl9JTkZPICJHUE1DIENM
SyBwZXJpb2QgaXMgJWQgKGRpdiAlZClcbiIsCi0JICAgICAgIGNzLCBnZXRf
Z3BtY19jbGtfcGVyaW9kKGRpdiksIGRpdik7CisJcHJpbnRrKEtFUk5fSU5G
TyAiR1BNQyBDUyVkOiBDTEsgcGVyaW9kIGlzICUzbHUgKGRpdiAlZClcbiIs
CisJICAgICAgIGNzLCBncG1jX2dldF9jbGtfcGVyaW9kKGRpdiksIGRpdik7
CiAjZW5kaWYKIAogCWwgPSBncG1jX2NzX3JlYWRfcmVnKGNzLCBHUE1DX0NT
X0NPTkZJRzEpOwotLSAKMS4zLjMKCg==

--_----------=_1150457704315150
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_----------=_1150457704315150--
