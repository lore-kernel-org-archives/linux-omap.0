From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] ARM: dts: am4372: Set memory bandwidth limit for DISPC
Date: Mon, 30 Sep 2019 11:54:50 +0300
Message-ID: <20190930085450.15874-1-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

RnJvbTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4KClNldCBtZW1vcnkg
YmFuZHdpZHRoIGxpbWl0IHRvIGZpbHRlciBvdXQgcmVzb2x1dGlvbnMgYWJvdmUgNzIwcEA2MEh6
IHRvCmF2b2lkIHVuZGVyZmxvdyBlcnJvcnMgZHVlIHRvIHRoZSBiYW5kd2lkdGggbmVlZHMgb2Yg
aGlnaGVyIHJlc29sdXRpb25zLgoKYW00M3h4IGNhbiBub3QgcHJvdmlkZSBlbm91Z2ggYmFuZHdp
ZHRoIHRvIERJU1BDIHRvIGNvcnJlY3RseSBoYW5kbGUKJ2hpZ2gnIHJlc29sdXRpb25zLgoKU2ln
bmVkLW9mZi1ieTogUGV0ZXIgVWpmYWx1c2kgPHBldGVyLnVqZmFsdXNpQHRpLmNvbT4KU2lnbmVk
LW9mZi1ieTogVG9taSBWYWxrZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNvbT4KLS0tCiBhcmNo
L2FybS9ib290L2R0cy9hbTQzNzIuZHRzaSB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hbTQzNzIuZHRzaSBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2FtNDM3Mi5kdHNpCmluZGV4IDg0OGUyYTg4ODRlMi4uMTRiYmM0Mzgw
NTVmIDEwMDY0NAotLS0gYS9hcmNoL2FybS9ib290L2R0cy9hbTQzNzIuZHRzaQorKysgYi9hcmNo
L2FybS9ib290L2R0cy9hbTQzNzIuZHRzaQpAQCAtMzM3LDYgKzMzNyw4IEBACiAJCQkJdGksaHdt
b2RzID0gImRzc19kaXNwYyI7CiAJCQkJY2xvY2tzID0gPCZkaXNwX2Nsaz47CiAJCQkJY2xvY2st
bmFtZXMgPSAiZmNrIjsKKworCQkJCW1heC1tZW1vcnktYmFuZHdpZHRoID0gPDIzMDAwMDAwMD47
CiAJCQl9OwogCiAJCQlyZmJpOiByZmJpQDQ4MzJhODAwIHsKLS0gClRleGFzIEluc3RydW1lbnRz
IEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLgpZLXR1bm51cy9C
dXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
