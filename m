From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH] media: omap2: omapfb: fix ifnullfree.cocci warnings
Date: Thu, 26 Jul 2018 01:57:00 +0800
Message-ID: <20180725175700.GA83136@lkp-sb05.lkp.intel.com>
References: <201807260144.q4WK2PMA%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <201807260144.q4WK2PMA%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kbuild-all@01.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

RnJvbToga2J1aWxkIHRlc3Qgcm9ib3QgPGZlbmdndWFuZy53dUBpbnRlbC5jb20+Cgpkcml2ZXJz
L3ZpZGVvL2ZiZGV2L29tYXAyL29tYXBmYi9kc3MvY29yZS5jOjE0MToyLTI2OiBXQVJOSU5HOiBO
VUxMIGNoZWNrIGJlZm9yZSBzb21lIGZyZWVpbmcgZnVuY3Rpb25zIGlzIG5vdCBuZWVkZWQuCgog
TlVMTCBjaGVjayBiZWZvcmUgc29tZSBmcmVlaW5nIGZ1bmN0aW9ucyBpcyBub3QgbmVlZGVkLgoK
IEJhc2VkIG9uIGNoZWNrcGF0Y2ggd2FybmluZwogImtmcmVlKE5VTEwpIGlzIHNhZmUgdGhpcyBj
aGVjayBpcyBwcm9iYWJseSBub3QgcmVxdWlyZWQiCiBhbmQga2ZyZWVhZGRyLmNvY2NpIGJ5IEp1
bGlhIExhd2FsbC4KCkdlbmVyYXRlZCBieTogc2NyaXB0cy9jb2NjaW5lbGxlL2ZyZWUvaWZudWxs
ZnJlZS5jb2NjaQoKRml4ZXM6IDczNzhmMTE0OTg4NCAoIm1lZGlhOiBvbWFwMjogb21hcGZiOiBh
bGxvdyBidWlsZGluZyBpdCB3aXRoIENPTVBJTEVfVEVTVCIpClNpZ25lZC1vZmYtYnk6IGtidWls
ZCB0ZXN0IHJvYm90IDxmZW5nZ3Vhbmcud3VAaW50ZWwuY29tPgotLS0KClBsZWFzZSB0YWtlIHRo
ZSBwYXRjaCBvbmx5IGlmIGl0J3MgYSBwb3NpdGl2ZSB3YXJuaW5nLiBUaGFua3MhCgogY29yZS5j
IHwgICAgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMo
LSkKCi0tLSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvb21hcDIvb21hcGZiL2Rzcy9jb3JlLmMKKysr
IGIvZHJpdmVycy92aWRlby9mYmRldi9vbWFwMi9vbWFwZmIvZHNzL2NvcmUuYwpAQCAtMTM3LDgg
KzEzNyw3IEBAIHN0YXRpYyBpbnQgZHNzX2luaXRpYWxpemVfZGVidWdmcyh2b2lkKQogCiBzdGF0
aWMgdm9pZCBkc3NfdW5pbml0aWFsaXplX2RlYnVnZnModm9pZCkKIHsKLQlpZiAoZHNzX2RlYnVn
ZnNfZGlyKQotCQlkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoZHNzX2RlYnVnZnNfZGlyKTsKKwlk
ZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoZHNzX2RlYnVnZnNfZGlyKTsKIH0KIAogaW50IGRzc19k
ZWJ1Z2ZzX2NyZWF0ZV9maWxlKGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgKCp3cml0ZSkoc3RydWN0
IHNlcV9maWxlICopKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
