From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH] ASoC: omap: Remove OMAP_MUX dependency from
	Nokia N810 audio support
Date: Wed, 25 Apr 2018 21:01:00 +0300
Message-ID: <20180425180100.15104-1-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, aaro.koskinen@iki.f, peter.ujfalusi@ti.com, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Q29tbWl0IGU5ZjVmMWU0NTYwOCAoIkFSTTogT01BUDIrOiBSZW1vdmUgbGVnYWN5IG11eCBjb2Rl
IikgcmVtb3ZlZApDT05GSUdfT01BUF9NVVggbWFraW5nIGltcG9zc2libGUgdG8gYnVpbGQgTm9r
aWEgTjgxMCBhdWRpbyBzdXBwb3J0LiBSZW1vdmUKdGhpcyBkZXBlbmRlbmN5IHNvIHdlIGNhbiBk
byBhdCBsZWFzdCBidWlsZCB0ZXN0cy4KCkZpeGVzOiBlOWY1ZjFlNDU2MDggKCJBUk06IE9NQVAy
KzogUmVtb3ZlIGxlZ2FjeSBtdXggY29kZSIpClNpZ25lZC1vZmYtYnk6IEphcmtrbyBOaWt1bGEg
PGphcmtrby5uaWt1bGFAYml0bWVyLmNvbT4KLS0tClDDqXRlciwgVG9ueTogU2hhbGwgd2UgcGls
ZSBmaXhlcyB0b2dldGhlciBvciBqdXN0IHNlbmQgc2VwYXJhdGVseSB3aGVuZXZlcgpmaXhlcyBv
ciBjbGVhbnVwcyBhcmUgcmVhZHk/Ci0tLQogc291bmQvc29jL29tYXAvS2NvbmZpZyB8IDEgLQog
MSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvb21h
cC9LY29uZmlnIGIvc291bmQvc29jL29tYXAvS2NvbmZpZwppbmRleCBmNTQ1MWM3OGVkZTUuLjlk
MjBjOWI5NDQ3NyAxMDA2NDQKLS0tIGEvc291bmQvc29jL29tYXAvS2NvbmZpZworKysgYi9zb3Vu
ZC9zb2Mvb21hcC9LY29uZmlnCkBAIC0zMCw3ICszMCw2IEBAIGNvbmZpZyBTTkRfT01BUF9TT0Nf
SERNSV9BVURJTwogY29uZmlnIFNORF9PTUFQX1NPQ19OODEwCiAJdHJpc3RhdGUgIlNvQyBBdWRp
byBzdXBwb3J0IGZvciBOb2tpYSBOODEwIgogCWRlcGVuZHMgb24gU05EX09NQVBfU09DICYmIE1B
Q0hfTk9LSUFfTjgxMCAmJiBJMkMKLQlkZXBlbmRzIG9uIE9NQVBfTVVYCiAJc2VsZWN0IFNORF9P
TUFQX1NPQ19NQ0JTUAogCXNlbGVjdCBTTkRfU09DX1RMVjMyMEFJQzNYCiAJaGVscAotLSAKMi4x
Ny4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNh
LWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21h
aWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
