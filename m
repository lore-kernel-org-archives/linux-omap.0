From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 01/14] mfd: omap-usb-host: Get clocks based on
 hardware revision
Date: Tue, 25 Feb 2014 09:37:59 +0000
Message-ID: <20140225093759.GA22755@lee--X1>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com>
 <1392896409-5101-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1392896409-5101-2-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: nm@ti.com, devicetree@vger.kernel.org, khilman@linaro.org, Samuel Ortiz <sameo@linux.intel.com>, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

PiBOb3QgYWxsIHJldmlzaW9ucyBoYXZlIGFsbCB0aGUgY2xvY2tzIHNvIGdldCB0aGUgbmVjZXNz
YXJ5IGNsb2Nrcwo+IGJhc2VkIG9uIGhhcmR3YXJlIHJldmlzaW9uLgo+IAo+IFRoaXMgc2hvdWxk
IGF2b2lkIHVuLW5lY2Vzc2FyeSBjbGtfZ2V0IGZhaWx1cmUgbWVzc2FnZXMgdGhhdCB3ZXJlCj4g
b2JzZXJ2ZWQgZWFybGllci4KPiAKPiBDQzogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4KPiBDQzogU2FtdWVsIE9ydGl6IDxzYW1lb0BsaW51eC5pbnRlbC5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQHRpLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9tZmQv
b21hcC11c2ItaG9zdC5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25z
KC0pCgpXaGF0IGFib3V0IHBhdGNoZXMgMSBhbmQgMi4gQXJlIHRoZXNlIHNhZmUgdG8gZ28gaW4g
YWxvbmU/CgotLSAKTGVlIEpvbmVzCkxpbmFybyBTVE1pY3JvZWxlY3Ryb25pY3MgTGFuZGluZyBU
ZWFtIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0Nz
CkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
