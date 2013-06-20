From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC PATCH 5/6] ARM: dts: omap3beagle-xm: Add idle state pins
 for USB host
Date: Thu, 20 Jun 2013 15:02:24 +0300
Message-ID: <51C2EF50.3070707@ti.com>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
 <1371650753-11452-6-git-send-email-rogerq@ti.com> <87obb26ixm.fsf@linaro.org>
 <51C2EDB1.3080801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51C2EDB1.3080801@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-usb@vger.kernel.org, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>, tony@atomide.com, ruslan.bilovol@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, stern@rowland.harvard.edu, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

T24gMDYvMjAvMjAxMyAwMjo1NSBQTSwgUm9nZXIgUXVhZHJvcyB3cm90ZToKPiBPbiAwNi8xOS8y
MDEzIDA5OjQyIFBNLCBLZXZpbiBIaWxtYW4gd3JvdGU6Cj4+IFJvZ2VyIFF1YWRyb3MgPHJvZ2Vy
cUB0aS5jb20+IHdyaXRlczoKPj4KPj4+IEFkZCB0aGUgSWRsZSBzdGF0ZSBwaW5zIGZvciBVU0Ig
aG9zdCBhbmQgZW5hYmxlIFdBS0VVUCBvbgo+Pj4gRElSLCBEQVQwLTMsIHNvIHRoYXQgdGhlIFBI
WSBjYW4gd2FrZXVwIHRoZSBPTUFQIFNvQyBmcm9tCj4+PiBzbGVlcCBvbiBhbnkgVVNCIGFjdGl2
aXR5IChlLmcuIHJlbW90ZSB3YWtldXAgb3IgY29ubmVjdC9kaXNjb25uZWN0KS4KPj4+Cj4+PiBD
QzogQmVub8OudCBDb3Vzc29uIDxiLWNvdXNzb25AdGkuY29tPgo+Pj4gU2lnbmVkLW9mZi1ieTog
Um9nZXIgUXVhZHJvcyA8cm9nZXJxQHRpLmNvbT4KPj4KPj4gVGhpcyBvbmUgZG9lc24ndCBhcHBs
eS4uLgo+Pgo+Pj4gLS0tCj4+PiAgYXJjaC9hcm0vYm9vdC9kdHMvb21hcDMtYmVhZ2xlLXhtLmR0
cyB8ICAgMjkgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPj4+ICAxIGZpbGVzIGNoYW5n
ZWQsIDIzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL29tYXAzLWJlYWdsZS14bS5kdHMgYi9hcmNoL2FybS9ib290L2R0
cy9vbWFwMy1iZWFnbGUteG0uZHRzCj4+PiBpbmRleCBkMzgwOGVkLi5mMWQ1NmMyIDEwMDY0NAo+
Pj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvb21hcDMtYmVhZ2xlLXhtLmR0cwo+Pj4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvb21hcDMtYmVhZ2xlLXhtLmR0cwo+Pj4gQEAgLTg5LDEyICs4OSw3
IEBACj4+PiAgfTsKPj4+ICAKPj4+ICAmb21hcDNfcG14X2NvcmUgewo+Pj4gLQlwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOwo+Pj4gLQlwaW5jdHJsLTAgPSA8Cj4+PiAtCQkJJmhzdXNiYjJfcGlu
cwo+Pj4gLQk+Owo+Pj4gLQo+Pj4gLQloc3VzYmIyX3BpbnM6IHBpbm11eF9oc3VzYmIyX3BpbnMg
ewo+Pgo+PiBUaGlzIG9tYXAzX3BteF9jb3JlIHNlY3Rpb24gZG9lc24ndCBleGlzdCB1cHN0cmVh
bSBpbiB0aGUgeE0gRFRTIGZpbGUKPj4gKGJ1dCBkb2VzIGluIG9tYXAzLWJlYWdsZS5kdHMuKSAg
Cj4+Cj4+IElzIHRoZXJlIGEgZGVwZW5kZW5jeSBwYXRjaCBtaXNzaW5nPwo+Pgo+IAo+IFNvcnJ5
IGZvciBub3QgbWVudGlvbmluZyBpdCBlYXJsaWVyLiBUaGlzIGlzIGJhc2VkIG9uIEJlbm9pdCdz
IHRyZWUgWzFdCj4gYW5kIHlvdSBuZWVkIHRoZXNlIHBhdGNoZXMKPiAKPiBodHRwOi8vdGhyZWFk
LmdtYW5lLm9yZy9nbWFuZS5saW51eC5kcml2ZXJzLmRldmljZXRyZWUvMzgzODMKCkp1c3Qgbm90
aWNlZCB0aGF0IHRoaXMgbm8gbG9uZ2VyIGFwcGxpZXMgdG9kYXkuIEknbGwgc2VuZCBhIHJldmlz
aW9uIHNvb24uCgpjaGVlcnMsCi1yb2dlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
