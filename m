From: "andrzej zaborowski" <balrog@zabor.org>
Subject: [PATCH] OMAP audio DMA changes for 310 CPUs
Date: Fri, 18 Aug 2006 10:20:39 +0200
Message-ID: <fb249edb0608180120m4d0786c7i6d4408112d7e2cf0@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_45220_31954790.1155889239143"
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
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_45220_31954790.1155889239143
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Avoid restarting McBSP hardware after every DMA transfer to OMAP audio
devices on OMAP310, restart only DMA. Also avoid trying to link DMA
channels together as this feature isn't supported on 310 processors.
Apply on top of "[PATCH 1/5] Change all omap15xx devices to use
similar DMA handling than h6300 uses".

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_45220_31954790.1155889239143
Content-Type: application/octet-stream; name=linux-omap310-audio.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_er0ern8o
Content-Disposition: attachment; filename="linux-omap310-audio.patch"

ZGlmZiAtcE5hdXIgLVggYi9Eb2N1bWVudGF0aW9uL2RvbnRkaWZmIGEvc291bmQvYXJtL29tYXAv
b21hcC1hbHNhLWRtYS5jIGIvc291bmQvYXJtL29tYXAvb21hcC1hbHNhLWRtYS5jCi0tLSBhL3Nv
dW5kL2FybS9vbWFwL29tYXAtYWxzYS1kbWEuYwkyMDA2LTAzLTIyIDE3OjQ1OjEzLjAwMDAwMDAw
MCArMDAwMAorKysgYi9zb3VuZC9hcm0vb21hcC9vbWFwLWFsc2EtZG1hLmMJMjAwNi0wOC0xOCAw
MDowMToyMy4wMDAwMDAwMDAgKzAwMDAKQEAgLTIwMCw3ICsyMDAsNyBAQCBpbnQgb21hcF9yZXF1
ZXN0X2Fsc2Ffc291bmRfZG1hKGludCBkZXZpCiAJfQogCiAJLyogQ2hhaW4gdGhlIGNoYW5uZWxz
IHRvZ2V0aGVyICovCi0JaWYgKCFjcHVfaXNfb21hcDE1MTAoKSkKKwlpZiAoIWNwdV9pc19vbWFw
MTV4eCgpKQogCQlvbWFwX3NvdW5kX2RtYV9saW5rX2xjaChkYXRhKTsKIAogCXNwaW5fdW5sb2Nr
KCZkbWFfbGlzdF9sb2NrKTsKQEAgLTI1MSw3ICsyNTEsNyBAQCBpbnQgb21hcF9mcmVlX2Fsc2Ff
c291bmRfZG1hKHZvaWQgKmRhdGEsCiAJfQogCWNoYW4gPSAoKmNoYW5uZWxzKTsKIAotCWlmICgh
Y3B1X2lzX29tYXAxNTEwKCkpCisJaWYgKCFjcHVfaXNfb21hcDE1eHgoKSkKIAkJb21hcF9zb3Vu
ZF9kbWFfdW5saW5rX2xjaChkYXRhKTsKIAlmb3IgKGkgPSAwOyBpIDwgbnJfbGlua2VkX2NoYW5u
ZWxzOyBpKyspIHsKIAkJaW50IGN1cl9jaGFuID0gY2hhbltpXTsKQEAgLTM0OSw3ICszNDksOCBA
QCBzdGF0aWMgaW50IGF1ZGlvX3N0YXJ0X2RtYV9jaGFpbihzdHJ1Y3QgCiAJCW9tYXBfc3RhcnRf
ZG1hKGNoYW5uZWwpOwogCQlzLT5zdGFydGVkID0gMTsKIAkJcy0+aHdfc3RhcnQoKTsJICAgLyog
c3RhcnQgTWNCU1AgaW50ZXJmYWNlICovCi0JfQorCX0gZWxzZSBpZiAoY3B1X2lzX29tYXAzMTAo
KSkKKwkJb21hcF9zdGFydF9kbWEoY2hhbm5lbCk7CiAJLyogZWxzZSB0aGUgZG1hIGl0c2VsZiB3
aWxsIHByb2dyZXNzIGZvcndhcmQgd2l0aCBvdXQgb3VyIGhlbHAgKi8KIAlGTl9PVVQoMCk7CiAJ
cmV0dXJuIDA7CmRpZmYgLXBOYXVyIC1YIGIvRG9jdW1lbnRhdGlvbi9kb250ZGlmZiBhL3NvdW5k
L2FybS9vbWFwL29tYXAtYWxzYS5jIGIvc291bmQvYXJtL29tYXAvb21hcC1hbHNhLmMKLS0tIGEv
c291bmQvYXJtL29tYXAvb21hcC1hbHNhLmMJMjAwNi0wOC0xOCAxMDowNTo1Ni4wMDAwMDAwMDAg
KzAwMDAKKysrIGIvc291bmQvYXJtL29tYXAvb21hcC1hbHNhLmMJMjAwNi0wOC0xOCAxMDowNjo1
OC4wMDAwMDAwMDAgKzAwMDAKQEAgLTIwNCw3ICsyMDQsNyBAQCBzdGF0aWMgdm9pZCBhdWRpb19w
cm9jZXNzX2RtYShzdHJ1Y3QgYXVkCiAJCSAqIGlycSBmcm9tIERNQSBhZnRlciB0aGUgZmlyc3Qg
dHJhbnNmZXJlZC9wbGF5ZWQgYnVmZmVyLgogCQkgKiAoaW52b2NhdGlvbiBvZiBjYWxsYmFja19v
bWFwX2Fsc2Ffc291bmRfZG1hKCkgbWV0aG9kKS4KIAkJICovCi0JCWlmIChjcHVfaXNfb21hcDE1
eHgoKSkgeworCQlpZiAoY3B1X2lzX29tYXAxNTEwKCkpIHsKIAkJCXNwaW5fbG9ja19pcnFzYXZl
KCZzLT5kbWFfbG9jaywgZmxhZ3MpOwogCQkJb21hcF9zdG9wX2Fsc2Ffc291bmRfZG1hKHMpOwog
CQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcy0+ZG1hX2xvY2ssIGZsYWdzKTsK
------=_Part_45220_31954790.1155889239143
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_45220_31954790.1155889239143--
