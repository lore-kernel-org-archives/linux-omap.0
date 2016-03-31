From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v9 2/7] ALSA: pcm: Allow 32 bit sample format in IEC958
 channel status helper
Date: Thu, 31 Mar 2016 16:35:59 +0300
Message-ID: <44ee7ac5c0ddb4d25ac1bd4f189d328f8205e4a0.1459431292.git.jsarha@ti.com>
References: <cover.1459431292.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1459431292.git.jsarha@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, tony@atomide.com, broonie@kernel.org, arnaud.pouliquen@st.com, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

VHJlYXQgMzIgYml0IHNhbXBsZSB3aWR0aCBhcyBpZiBpdCB3YXMgMjQgYml0cyB3aGVuIGdlbmVy
YXRpbmcgSUVDOTU4CmNoYW5uZWwgc3RhdHVzIGJpdHMuIE9uIHNvbWUgcGxhdGZvcm1zIDI0IHNh
bXBsZSB3aWR0aCBpcyBwcm9ibGVtYXRpYwphbmQgdG8gZ2V0IGZ1bGwgMjQgYml0IHByZWNpc2lv
biBhIDMyIGJpdCBmb3JtYXQsIHVzaW5nIG9ubHkgdGhlIDI0Cm1vc3Qgc2lnbmlmaWNhbnQgYml0
cywgbWF5IGhhdmUgdG8gYmUgdXNlZC4KClNpZ25lZC1vZmYtYnk6IEp5cmkgU2FyaGEgPGpzYXJo
YUB0aS5jb20+Ci0tLQogc291bmQvY29yZS9wY21faWVjOTU4LmMgfCAxICsKIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL2NvcmUvcGNtX2llYzk1OC5j
IGIvc291bmQvY29yZS9wY21faWVjOTU4LmMKaW5kZXggZTAxNjg3MS4uNWU2YWVkNiAxMDA2NDQK
LS0tIGEvc291bmQvY29yZS9wY21faWVjOTU4LmMKKysrIGIvc291bmQvY29yZS9wY21faWVjOTU4
LmMKQEAgLTU5LDYgKzU5LDcgQEAgc3RhdGljIGludCBjcmVhdGVfaWVjOTU4X2NvbnN1bWVyKHVp
bnQgcmF0ZSwgdWludCBzYW1wbGVfd2lkdGgsCiAJCQkgICAgIElFQzk1OF9BRVM0X0NPTl9NQVhf
V09SRExFTl8yNDsKIAkJCWJyZWFrOwogCQljYXNlIDI0OgorCQljYXNlIDMyOiAvKiBBc3N1bWUg
MjQtYml0IHdpZHRoIGZvciAzMi1iaXQgc2FtcGxlcy4gKi8KIAkJCXdzID0gSUVDOTU4X0FFUzRf
Q09OX1dPUkRMRU5fMjRfMjAgfAogCQkJICAgICBJRUM5NThfQUVTNF9DT05fTUFYX1dPUkRMRU5f
MjQ7CiAJCQlicmVhazsKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
