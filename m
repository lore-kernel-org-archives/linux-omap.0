From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 30/38] move mipid_spi_remove to
	.devexit.text
Date: Tue, 24 Nov 2009 22:07:25 +0100
Message-ID: <1259096853-18909-30-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1259096853-18909-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-20-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-21-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-22-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-23-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-24-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-25-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-26-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-27-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-28-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-29-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1259096853-18909-29-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Imre Deak <imre.deak@solidboot.com>, linux-fbdev-devel@lists.sourceforge.net, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Mike Wege <ext-mike.wege@nokia.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: linux-omap@vger.kernel.org

VGhlIGZ1bmN0aW9uIG1pcGlkX3NwaV9yZW1vdmUgaXMgdXNlZCBvbmx5IHdyYXBwZWQgYnkgX19k
ZXZleGl0X3Agc28KZGVmaW5lIGl0IHVzaW5nIF9fZGV2ZXhpdC4KClNpZ25lZC1vZmYtYnk6IFV3
ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+CkNjOiBBcm5h
dWQgUGF0YXJkIDxhcm5hdWQucGF0YXJkQHJ0cC1uZXQub3JnPgpDYzogQW5kcmV3IE1vcnRvbiA8
YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4KQ2M6IE1pa2UgV2VnZSA8ZXh0LW1pa2Uud2VnZUBu
b2tpYS5jb20+CkNjOiBJbXJlIERlYWsgPGltcmUuZGVha0Bzb2xpZGJvb3QuY29tPgpDYzogSGly
b3NoaSBET1lVIDxIaXJvc2hpLkRPWVVAbm9raWEuY29tPgpDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZwpDYzogSW1yZSBEZWFrIDxpbXJlLmRlYWtAbm9raWEuY29tPgpDYzogbGludXgt
ZmJkZXYtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0CkNjOiBsaW51eC1vbWFwQHZnZXIua2Vy
bmVsLm9yZwotLS0KIGRyaXZlcnMvdmlkZW8vb21hcC9sY2RfbWlwaWQuYyB8ICAgIDIgKy0KIDEg
ZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmlkZW8vb21hcC9sY2RfbWlwaWQuYyBiL2RyaXZlcnMvdmlkZW8vb21hcC9s
Y2RfbWlwaWQuYwppbmRleCA5MThlZTg5Li4yNDg4OWNhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Zp
ZGVvL29tYXAvbGNkX21pcGlkLmMKKysrIGIvZHJpdmVycy92aWRlby9vbWFwL2xjZF9taXBpZC5j
CkBAIC01ODcsNyArNTg3LDcgQEAgc3RhdGljIGludCBtaXBpZF9zcGlfcHJvYmUoc3RydWN0IHNw
aV9kZXZpY2UgKnNwaSkKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIGludCBtaXBpZF9zcGlfcmVt
b3ZlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpCitzdGF0aWMgaW50IF9fZGV2ZXhpdCBtaXBpZF9z
cGlfcmVtb3ZlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpCiB7CiAJc3RydWN0IG1pcGlkX2Rldmlj
ZSAqbWQgPSBkZXZfZ2V0X2RydmRhdGEoJnNwaS0+ZGV2KTsKIAotLSAKMS42LjUuMgoKCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpMZXQgQ3J5c3RhbCBSZXBvcnRzIGhhbmRsZSB0aGUgcmVwb3J0aW5n
IC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAzMC1EYXkgCnRyaWFsLiBTaW1wbGlmeSB5b3Vy
IHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9uIGFuZCBkZXBsb3ltZW50IC0gYW5kIGZvY3VzIG9u
IAp3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFwcGxpY2F0aW9uIGNvZGluZy4gRGlzY292ZXIgd2hh
dCdzIG5ldyB3aXRoCkNyeXN0YWwgUmVwb3J0cyBub3cuICBodHRwOi8vcC5zZi5uZXQvc2Z1L2Jv
YmotanVseQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mYmRldi1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZmJkZXYtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWZiZGV2LWRldmVsCg==
