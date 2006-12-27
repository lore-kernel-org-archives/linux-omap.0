From: "=?UTF-8?Q?Ragner_N_Magalh=C3=A3es?=" <ragner@users.sourceforge.net>
Subject: OMAP: small patch fixes "fs/jffs2/malloc.c:126: error:
	dereferencing pointer to incomplete type"
Date: Wed, 27 Dec 2006 16:39:00 -0400
Message-ID: <25c21ceb0612271239v5c245656ha1c467e04338aea9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_81164_31738185.1167251940689"
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

------=_Part_81164_31738185.1167251940689
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGkgYWxsLAp0aGlzIGlzIG90aGVyIHNtYWxsIHBhdGNoIHRoYXQgZml4ZXMgdGhpcyBlcnJvciBi
ZWxvdwoKZnMvamZmczIvbWFsbG9jLmM6IEluIGZ1bmN0aW9uICdqZmZzMl9hbGxvY19mdWxsX2Rp
cmVudCc6CmZzL2pmZnMyL21hbGxvYy5jOjEyNjogZXJyb3I6IGRlcmVmZXJlbmNpbmcgcG9pbnRl
ciB0byBpbmNvbXBsZXRlIHR5cGUKCkJlc3QgcmVnYXJkcywKLS0gClJhZ25lciBOIE1hZ2FsaMOj
ZXMKSW5zdGl0dXRvIE5va2lhIGRlIFRlY25vbG9naWEgKElOZFQpIC0gT1NNUkMKRS1tYWlsOiBy
YWduZXIubWFnYWxoYWVzQGluZHQub3JnLmJyCg==
------=_Part_81164_31738185.1167251940689
Content-Type: text/x-patch; name=patch-malloc_c-incomplete_type.diff;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew87ts5f
Content-Disposition: attachment; filename="patch-malloc_c-incomplete_type.diff"

VGhpcyBwYXRjaCBmaXhlcyAiZXJyb3I6IGRlcmVmZXJlbmNpbmcgcG9pbnRlciB0byBpbmNvbXBs
ZXRlIHR5cGUiIGluIGZzL2pmZnMyL21hbGxvYy5jClNpZ25lZC1vZmYtYnk6IFJhZ25lciBNYWdh
bGjjZXMgPHJhZ25lci5tYWdhbGhlc0BpbmR0Lm9yZy5icj4KLS0tCkluZGV4OiAyLjYtZGV2L2Zz
L2pmZnMyL21hbGxvYy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIDIuNi1kZXYub3JpZy9mcy9qZmZzMi9tYWxs
b2MuYwkyMDA2LTEyLTI3IDEwOjUzOjA5LjAwMDAwMDAwMCAtMDQwMAorKysgMi42LWRldi9mcy9q
ZmZzMi9tYWxsb2MuYwkyMDA2LTEyLTI3IDE1OjIwOjE1LjAwMDAwMDAwMCAtMDQwMApAQCAtMTUs
NiArMTUsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51eC9pbml0
Lmg+CiAjaW5jbHVkZSA8bGludXgvamZmczIuaD4KKyNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPgog
I2luY2x1ZGUgIm5vZGVsaXN0LmgiCiAKIC8qIFRoZXNlIGFyZSBpbml0aWFsaXNlZCB0byBOVUxM
IGluIHRoZSBrZXJuZWwgc3RhcnR1cCBjb2RlLgo=
------=_Part_81164_31738185.1167251940689
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_81164_31738185.1167251940689--
