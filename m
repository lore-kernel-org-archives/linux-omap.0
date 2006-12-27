From: "=?UTF-8?Q?Ragner_N_Magalh=C3=A3es?=" <ragner@users.sourceforge.net>
Subject: OMAP: small patch fixes "error: field 'gpio_expa' has incomplete
	type"
Date: Wed, 27 Dec 2006 16:36:21 -0400
Message-ID: <25c21ceb0612271236ped35f6t65da0e66c86fcd9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_81152_5738041.1167251781511"
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

------=_Part_81152_5738041.1167251781511
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGksCnRoaXMgc21hbGwgcGF0Y2ggZml4ZXMgdGhpcyBlcnJvciBiZWxvdwoKSW4gZmlsZSBpbmNs
dWRlZCBmcm9tIGFyY2gvYXJtL21hY2gtb21hcDEvYm9hcmQtaDIuYzo0MDoKaW5jbHVkZS9hc20v
YXJjaC9pcmRhLmg6Mjc6IGVycm9yOiBmaWVsZCAnZ3Bpb19leHBhJyBoYXMgaW5jb21wbGV0ZSB0
eXBlCgpCZXN0IHJlZ2FyZHMsCgotLSAKUmFnbmVyIE4gTWFnYWxow6NlcwpJbnN0aXR1dG8gTm9r
aWEgZGUgVGVjbm9sb2dpYSAoSU5kVCkgLSBPU01SQwpFLW1haWw6IHJhZ25lci5tYWdhbGhhZXNA
aW5kdC5vcmcuYnIK
------=_Part_81152_5738041.1167251781511
Content-Type: text/x-patch; name=patch-irda_h-incomplete_type.diff;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew87p4dy
Content-Disposition: attachment; filename="patch-irda_h-incomplete_type.diff"

VGhpcyBwYXRjaCBmaXhlcyAiZXJyb3I6IGZpZWxkICdncGlvX2V4cGEnIGhhcyBpbmNvbXBsZXRl
IHR5cGUiIGF0IGluY2x1ZGUvYXNtL2FyY2gvaXJkYS5oClNpZ25lZC1vZmYtYnk6IFJhZ25lciBN
YWdhbGjjZXMgPHJhZ25lci5tYWdhbGhlc0BpbmR0Lm9yZy5icj4KLS0tCkluZGV4OiAyLjYtZGV2
L2luY2x1ZGUvYXNtL2FyY2gvaXJkYS5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIDIuNi1kZXYub3JpZy9pbmNs
dWRlL2FzbS9hcmNoL2lyZGEuaAkyMDA2LTEyLTI3IDEwOjI4OjA5LjAwMDAwMDAwMCAtMDQwMAor
KysgMi42LWRldi9pbmNsdWRlL2FzbS9hcmNoL2lyZGEuaAkyMDA2LTEyLTI3IDEwOjI5OjA3LjAw
MDAwMDAwMCAtMDQwMApAQCAtMTAsNiArMTAsOCBAQAogI2lmbmRlZiBBU01BUk1fQVJDSF9JUkRB
X0gKICNkZWZpbmUgQVNNQVJNX0FSQ0hfSVJEQV9ICiAKKyNpbmNsdWRlIDxsaW51eC93b3JrcXVl
dWUuaD4KKwogLyogYm9hcmQgc3BlY2lmaWMgdHJhbnNjZWl2ZXIgY2FwYWJpbGl0aWVzICovCiAK
ICNkZWZpbmUgSVJfU0VMCQkxCS8qIFNlbGVjdHMgSXJEQSAqLwo=
------=_Part_81152_5738041.1167251781511
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_81152_5738041.1167251781511--
