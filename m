From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: [PATCH 5/6] ARM: OMAP: Move irq pinmux to board specific init
Date: Wed, 13 Jun 2007 14:53:07 +0530
Message-ID: <5d5443650706130223w566b9704m4edeea58edc85515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_18816_26519770.1181726587414"
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

------=_Part_18816_26519770.1181726587414
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
--Trilok Soni

------=_Part_18816_26519770.1181726587414
Content-Type: text/x-patch;
	name=0005-ARM-OMAP-Move-irq-pinmux-to-board-specific-init.patch;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2vlhjqr
Content-Disposition: attachment;
	filename="0005-ARM-OMAP-Move-irq-pinmux-to-board-specific-init.patch"

RnJvbSBmYjkwOTBkZWRhNTcwZjM4NWE5N2IwZmJlMGU4NmFhNGQzMzU3NWU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBCcm93bmVsbCA8ZGJyb3duZWxsQHVzZXJzLnNvdXJj
ZWZvcmdlLm5ldD4KRGF0ZTogV2VkLCAxMyBKdW4gMjAwNyAxODoyMzo0MSArMDUzMApTdWJqZWN0
OiBbUEFUQ0ggNS82XSBBUk06IE9NQVA6IE1vdmUgaXJxIHBpbm11eCB0byBib2FyZCBzcGVjaWZp
YyBpbml0CgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBCcm93bmVsbCA8ZGJyb3duZWxsQHVzZXJzLnNv
dXJjZWZvcmdlLm5ldD4KU2lnbmVkLW9mZi1ieTogVHJpbG9rIFNvbmkgPHNvbmkudHJpbG9rQGdt
YWlsLmNvbT4KLS0tCiBkcml2ZXJzL2kyYy9jaGlwcy9tZW5lbGF1cy5jIHwgICAgNCAtLS0tCiAx
IGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2kyYy9jaGlwcy9tZW5lbGF1cy5jIGIvZHJpdmVycy9pMmMvY2hpcHMvbWVu
ZWxhdXMuYwppbmRleCBjYTdkZWE1Li40YWM1MzFmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2kyYy9j
aGlwcy9tZW5lbGF1cy5jCisrKyBiL2RyaXZlcnMvaTJjL2NoaXBzL21lbmVsYXVzLmMKQEAgLTQz
LDcgKzQzLDYgQEAKICNpbmNsdWRlIDxhc20vbWFjaC10eXBlcy5oPgogI2luY2x1ZGUgPGFzbS9t
YWNoL2lycS5oPgogCi0jaW5jbHVkZSA8YXNtL2FyY2gvbXV4Lmg+CiAjaW5jbHVkZSA8YXNtL2Fy
Y2gvZ3Bpby5oPgogI2luY2x1ZGUgPGFzbS9hcmNoL21lbmVsYXVzLmg+CiAKQEAgLTgzNCw5ICs4
MzMsNiBAQCBzdGF0aWMgaW50IG1lbmVsYXVzX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQpCiAJCWdvdG8gZmFpbDE7CiAJfQogCi0JLyogTW9zdCBsaWtlbHkgTWVuZWxhdXMgaW50ZXJy
dXB0IGlzIGF0IFNZU19OSVJRICovCi0Jb21hcF9jZmdfcmVnKFcxOV8yNFhYX1NZU19OSVJRKTsK
LQogCS8qIEFjayBhbmQgZGlzYWJsZSBhbGwgTWVuZWxhdXMgaW50ZXJydXB0cyAqLwogCW1lbmVs
YXVzX3dyaXRlX3JlZyhNRU5FTEFVU19JTlRfQUNLMSwgMHhmZik7CiAJbWVuZWxhdXNfd3JpdGVf
cmVnKE1FTkVMQVVTX0lOVF9BQ0syLCAweGZmKTsKLS0gCjEuNS4wCgo=
------=_Part_18816_26519770.1181726587414
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_18816_26519770.1181726587414--
