From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH]  H4 / 2430SDP ethernet IRQ flags fix
Date: Fri, 10 Nov 2006 13:36:18 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01D9199A@DLEE09.ent.ti.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE01D91956@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C704FF.7E87A434"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <77C7F7CB1230A74A9D19C0C111E6EDBE01D91956@DLEE09.ent.ti.com>
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C704FF.7E87A434
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Tony,

The attached patch configures the Ethernet IRQ flag on H4 / 2430SDP to
IRQF_TRIGGER_LOW

This has been tested and validated on 2430 SDP and H4 board.

Thanks & Regards,
Khasim

------_=_NextPart_001_01C704FF.7E87A434
Content-Type: application/octet-stream;
	name="ethernet_fix_H4_2430.patch"
Content-Transfer-Encoding: base64
Content-Description: ethernet_fix_H4_2430.patch
Content-Disposition: attachment;
	filename="ethernet_fix_H4_2430.patch"

VGhpcyBwYXRjaCBjb25maWd1cmVzIHRoZSBFdGhlcm5ldCBJUlEgZmxhZyBvbiBINCAvIDI0MzBT
RFAgdG8gSVJRRl9UUklHR0VSX0xPVy4KClNpZ25lZC1vZmYtYnk6IFN5ZWQgTW9oYW1tZWQgS2hh
c2ltICA8eDBraGFzaW1AdGkuY29tPgoKRmlsZXMgY2hhbmdlZDoKIHNtYzkxeC5oIHwgICAgNyAr
KysrLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQpkaWZmIC1wdXJOIGxpbnV4LW9tYXAvZHJpdmVycy9uZXQv
c21jOTF4LmggZGV2LWxpbnV4LW9tYXAtMi42LmdpdC9kcml2ZXJzL25ldC9zbWM5MXguaAotLS0g
bGludXgtb21hcC9kcml2ZXJzL25ldC9zbWM5MXguaAkyMDA2LTExLTAyIDAwOjE2OjIxLjAwMDAw
MDAwMCAtMDYwMAorKysgZGV2LWxpbnV4LW9tYXAtMi42LmdpdC9kcml2ZXJzL25ldC9zbWM5MXgu
aAkyMDA2LTExLTEwIDEzOjIyOjUzLjAwMDAwMDAwMCAtMDYwMApAQCAtMTkzLDExICsxOTMsMTIg
QEAgU01DX291dHcodTE2IHZhbCwgdm9pZCBfX2lvbWVtICppb2FkZHIsIAogI2luY2x1ZGUgPGFz
bS9hcmNoL2NwdS5oPgogCiAjZGVmaW5lCVNNQ19JUlFfRkxBR1MgKCggXAotCQkgICBtYWNoaW5l
X2lzX29tYXBfaDIoKSBcCisJCW1hY2hpbmVfaXNfb21hcF9oMigpIFwKIAkJfHwgbWFjaGluZV9p
c19vbWFwX2gzKCkgXAotCQl8fCBtYWNoaW5lX2lzX29tYXBfaDQoKSBcCiAJCXx8IChtYWNoaW5l
X2lzX29tYXBfaW5ub3ZhdG9yKCkgJiYgIWNwdV9pc19vbWFwMTUxMCgpKSBcCi0JKSA/IElSUUZf
VFJJR0dFUl9GQUxMSU5HIDogSVJRRl9UUklHR0VSX1JJU0lORykKKwkJKT8gSVJRRl9UUklHR0VS
X0ZBTExJTkcgOiBcCisJCSgobWFjaGluZV9pc19vbWFwX2g0KCkgfHwgbWFjaGluZV9pc19vbWFw
XzI0MzBzZHAoKSk/IFwKKwkJSVJRRl9UUklHR0VSX0xPVyA6IElSUUZfVFJJR0dFUl9SSVNJTkcp
KQogCiAKICNlbGlmCWRlZmluZWQoQ09ORklHX1NIX1NINDIwMl9NSUNST0RFVikK

------_=_NextPart_001_01C704FF.7E87A434
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C704FF.7E87A434--
