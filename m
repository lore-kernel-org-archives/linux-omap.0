From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH v2 2/7] i2c: omap: reorder exit path of omap_i2c_xfer_msg()
Date: Thu, 25 Oct 2012 14:53:33 +0200
Message-ID: <20617.13901.479604.302420@ipc1.ka-ro>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1351167915-15079-1-git-send-email-balbi@ti.com>
 <1351167915-15079-3-git-send-email-balbi@ti.com>
 <50893398.6070004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50893398.6070004@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>, linux-i2c@vger.kernel.org, ben-linux@fluff.org, michael@amarulasolutions.com, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

SGksCgpTYW50b3NoIFNoaWxpbWthciB3cml0ZXM6Cj4gT24gVGh1cnNkYXkgMjUgT2N0b2JlciAy
MDEyIDA1OjU1IFBNLCBGZWxpcGUgQmFsYmkgd3JvdGU6Cj4gPiBqdXN0IGEgY2xlYW51cCBwYXRj
aCB0cnlpbmcgdG8gbWFrZSBleGl0IHBhdGgKPiA+IG1vcmUgc3RyYWlnaHRmb3J3YXJkLiBObyBj
aGFuZ2VzIG90aGVyd2lzZS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgQmFsYmkgPGJh
bGJpQHRpLmNvbT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLW9tYXAuYyB8
IDI2ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2kyYy9idXNzZXMvaTJjLW9tYXAuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21hcC5jCj4g
PiBpbmRleCBjMDdkOWM0Li5iZWEwMjc3IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1vbWFwLmMKPiA+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb21hcC5jCj4g
PiBAQCAtNTA1LDYgKzUwNSw3IEBAIHN0YXRpYyBpbnQgb21hcF9pMmNfeGZlcl9tc2coc3RydWN0
IGkyY19hZGFwdGVyICphZGFwLAo+ID4gICB7Cj4gPiAgIAlzdHJ1Y3Qgb21hcF9pMmNfZGV2ICpk
ZXYgPSBpMmNfZ2V0X2FkYXBkYXRhKGFkYXApOwo+ID4gICAJdW5zaWduZWQgbG9uZyB0aW1lb3V0
Owo+ID4gKwlpbnQgcmV0OwpbLi4uXQo+ID4gKwkJcmV0ID0gLUVSRU1PVEVJTzsKPiA+ICsJCWdv
dG8gZXJyOwo+ID4gICAJfQo+ID4gLQlyZXR1cm4gLUVJTzsKPiA+ICsKPiA+ICsJcmV0dXJuIDA7
Cj4gV2l0aCBpbml0aWFsaXplZCB2YWx1ZSB5b3UgY2FuIHVzZQo+IHJldHVybiByZXQ7Cj4gCkRv
aW5nIGl0IHRoaXMgd2F5IGhhcyB0aGUgYWR2YW50YWdlLCB0aGF0IGlmIGFuIGFkZGl0aW9uYWwg
ZXJyb3IgZXhpdAppcyBhZGRlZCBpdCB3aWxsIGdlbmVyYXRlIGFuICd1bmluaXRpYWxpemVkIHZh
cmlhYmxlJyB3YXJuaW5nLCBpZiBpdApmYWlscyB0byBzZXQgdGhlIHJldHVybiB2YWx1ZS4KCgoK
TG90aGFyIFdhw59tYW5uCi0tIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwoKS2EtUm8gZWxlY3Ryb25pY3MgR21iSCB8IFBhc2NhbHN0
cmHDn2UgMjIgfCBEIC0gNTIwNzYgQWFjaGVuClBob25lOiArNDkgMjQwOCAxNDAyLTAgfCBGYXg6
ICs0OSAyNDA4IDE0MDItMTAKR2VzY2jDpGZ0c2bDvGhyZXI6IE1hdHRoaWFzIEthdXNzZW4KSGFu
ZGVsc3JlZ2lzdGVyZWludHJhZzogQW10c2dlcmljaHQgQWFjaGVuLCBIUkIgNDk5NgoKd3d3Lmth
cm8tZWxlY3Ryb25pY3MuZGUgfCBpbmZvQGthcm8tZWxlY3Ryb25pY3MuZGUKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
