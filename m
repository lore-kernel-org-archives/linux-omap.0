From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] backlight: Avoid double fbcon backlight
	handling
Date: Thu, 7 Jul 2016 10:33:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1607071032280.24757@cbobk.fhfr.pm>
References: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Milo Kim <milo.kim@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Jon Nettleton <jon.nettleton@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, linux-acpi@vger.kernel.org, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Michael Hennerich <michael.hennerich@analog.com>, intel-gfx@lists.
List-Id: linux-omap@vger.kernel.org

T24gVGh1LCAzMCBKdW4gMjAxNiwgQ2hyaXMgV2lsc29uIHdyb3RlOgoKPiBCYWNrbGlnaHRzIGNv
bnRyb2xsZWQgYnkgaTkxNS5rbyBhbmQgb25seSBhc3NvY2lhdGVkIHdpdGggaXRzIGNvbm5lY3Rv
cnMKPiBhbmQgYWxzbyBvbmx5IGFzc29jaWF0ZWQgd2l0aCB0aGUgaW50ZWxfZHJtZmIgZmJjb24s
IGNvbnRyb2xsZWQgYnkKPiBpOTE1LmtvLiBJbiB0aGlzIHNpdHVhdGlvbiwgd2UgYWxyZWFkeSBo
YW5kbGUgYWRqdXN0aW5nIHRoZSBiYWNrbGlnaHQKPiB3aGVuIHRoZSBmYmNvbiBpcyBibGFua2Vk
L3VuYmxhbmtlZCBhbmQgZG8gbm90IHJlcXVpcmUgYmFja2xpZ2h0IHRyeWluZwo+IHRvIGRvIHRo
ZSBzYW1lLgo+IAo+IEF0dGVtcHRpbmcgdG8gcmVnaXN0ZXIgd2l0aCB0aGUgZmJkZXYgYXMgYSBj
bGllbnQgY2F1c2VzIGxvY2tkZXAgdG8gd2Fybgo+IGFib3V0IGEgZGVwZW5kZW5jeSBjeWNsZToK
WyAuLi4gc25pcCAuLi4gXQo+ICBkcml2ZXJzL2hpZC9oaWQtcGljb2xjZF9iYWNrbGlnaHQuYyAg
ICAgICAgICAgICAgICAgIHwgIDMgKystCgpGb3IgdGhpcyBvbmU6CgoJQWNrZWQtYnk6IEppcmkg
S29zaW5hIDxqa29zaW5hQHN1c2UuY3o+CgotLSAKSmlyaSBLb3NpbmEKU1VTRSBMYWJzCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFp
bGluZyBsaXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9pbnRlbC1nZngK
