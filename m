From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: [PATCH] Update SX1 audio to current ALSA typenames
Date: Thu, 7 Jun 2007 04:50:30 +0200
Message-ID: <fb249edb0706061950t2a1a5596h55911911365608d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_31595_23554957.1181184630520"
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

------=_Part_31595_23554957.1181184630520
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Update to newer ALSA structs in order to fix building.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>

------=_Part_31595_23554957.1181184630520
Content-Type: text/plain;
	name=0008-ARM-OMAP-Update-SX1-audio-to-current-ALSA-typenames.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f2motw8k
Content-Disposition: attachment;
	filename="0008-ARM-OMAP-Update-SX1-audio-to-current-ALSA-typenames.txt"

RnJvbSAzMDdkNGVhMzBmODczMWEyNzU0OTRhOTdlNWQ3Yjc1NTVhNmUyMDljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyemVqIFphYm9yb3dza2kgPGJhbHJvZ0B6YWJvci5vcmc+
CkRhdGU6IFRodSwgNyBKdW4gMjAwNyAwNToyODoyNCArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEFS
TTogT01BUDogVXBkYXRlIFNYMSBhdWRpbyB0byBjdXJyZW50IEFMU0EgdHlwZW5hbWVzLgoKLS0t
CiBzb3VuZC9hcm0vb21hcC9vbWFwLWFsc2Etc3gxLmMgfCAgICA2ICsrKy0tLQogMSBmaWxlcyBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291
bmQvYXJtL29tYXAvb21hcC1hbHNhLXN4MS5jIGIvc291bmQvYXJtL29tYXAvb21hcC1hbHNhLXN4
MS5jCmluZGV4IGVhZGFlNjguLmM0NjkxY2QgMTAwNjQ0Ci0tLSBhL3NvdW5kL2FybS9vbWFwL29t
YXAtYWxzYS1zeDEuYworKysgYi9zb3VuZC9hcm0vb21hcC9vbWFwLWFsc2Etc3gxLmMKQEAgLTgy
LDEzICs4MiwxMyBAQCBzdGF0aWMgdW5zaWduZWQgaW50IHJhdGVzW10gPSB7CiAJIDMyMDAwLCA0
NDEwMCwgNDgwMDAsCiB9OwogCi1zdGF0aWMgc25kX3BjbV9od19jb25zdHJhaW50X2xpc3RfdCBl
Z29sZF9od19jb25zdHJhaW50c19yYXRlcyA9IHsKK3N0YXRpYyBzdHJ1Y3Qgc25kX3BjbV9od19j
b25zdHJhaW50X2xpc3QgZWdvbGRfaHdfY29uc3RyYWludHNfcmF0ZXMgPSB7CiAJLmNvdW50CT0g
QVJSQVlfU0laRShyYXRlcyksCiAJLmxpc3QJPSByYXRlcywKIAkubWFzawk9IDAsCiB9OwogCi1z
dGF0aWMgc25kX3BjbV9oYXJkd2FyZV90IGVnb2xkX3NuZF9vbWFwX2Fsc2FfcGxheWJhY2sgPSB7
CitzdGF0aWMgc3RydWN0IHNuZF9wY21faGFyZHdhcmUgZWdvbGRfc25kX29tYXBfYWxzYV9wbGF5
YmFjayA9IHsKIAkuaW5mbyA9IChTTkRSVl9QQ01fSU5GT19JTlRFUkxFQVZFRCB8IFNORFJWX1BD
TV9JTkZPX0JMT0NLX1RSQU5TRkVSIHwKIAkJIFNORFJWX1BDTV9JTkZPX01NQVAgfCBTTkRSVl9Q
Q01fSU5GT19NTUFQX1ZBTElEKSwKIAkuZm9ybWF0cyA9IChTTkRSVl9QQ01fRk1UQklUX1MxNl9M
RSksCkBAIC0xMDksNyArMTA5LDcgQEAgc3RhdGljIHNuZF9wY21faGFyZHdhcmVfdCBlZ29sZF9z
bmRfb21hcF9hbHNhX3BsYXliYWNrID0gewogCS5maWZvX3NpemUJCT0gMCwKIH07CiAKLXN0YXRp
YyBzbmRfcGNtX2hhcmR3YXJlX3QgZWdvbGRfc25kX29tYXBfYWxzYV9jYXB0dXJlID0geworc3Rh
dGljIHN0cnVjdCBzbmRfcGNtX2hhcmR3YXJlIGVnb2xkX3NuZF9vbWFwX2Fsc2FfY2FwdHVyZSA9
IHsKIAkuaW5mbyA9IChTTkRSVl9QQ01fSU5GT19JTlRFUkxFQVZFRCB8IFNORFJWX1BDTV9JTkZP
X0JMT0NLX1RSQU5TRkVSIHwKIAkJIFNORFJWX1BDTV9JTkZPX01NQVAgfCBTTkRSVl9QQ01fSU5G
T19NTUFQX1ZBTElEKSwKIAkuZm9ybWF0cyA9IChTTkRSVl9QQ01fRk1UQklUX1MxNl9MRSksCi0t
IAoxLjQuNC4zCgo=
------=_Part_31595_23554957.1181184630520
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_31595_23554957.1181184630520--
