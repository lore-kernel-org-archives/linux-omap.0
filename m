From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
Date: Tue, 2 Jul 2013 11:46:50 +0530
Message-ID: <51D27052.6080303@ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
 <51D26CFA.5090500@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EC4E7AB@DBDE04.ent.ti.com>
 <51D26E98.9040303@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EC4E7CC@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EC4E7CC-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Bedia,
 Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

CgpPbiA3LzIvMjAxMyAxMTo0MSBBTSwgSGViYmFyLCBHdXJ1cmFqYSB3cm90ZToKPiBPbiBUdWUs
IEp1bCAwMiwgMjAxMyBhdCAxMTozOToyOCwgTm9yaSwgU2VraGFyIHdyb3RlOgo+PiBPbiA3LzIv
MjAxMyAxMTozNCBBTSwgSGViYmFyLCBHdXJ1cmFqYSB3cm90ZToKPj4+IE9uIFR1ZSwgSnVsIDAy
LCAyMDEzIGF0IDExOjMyOjM0LCBOb3JpLCBTZWtoYXIgd3JvdGU6Cj4+Pj4gT24gNi8yOC8yMDEz
IDM6MDUgUE0sIEhlYmJhciBHdXJ1cmFqYSB3cm90ZToKPj4+Pj4gT24gc29tZSBwbGF0Zm9ybXMg
KGxpa2UgQU0zM3h4KSwgYSBzcGVjaWFsIHJlZ2lzdGVyIChSVENfSVJRV0FLRUVOKQo+Pj4+PiBp
cyBhdmFpbGFibGUgdG8gZW5hYmxlIEFsYXJtIFdha2V1cCBmZWF0dXJlLiBUaGlzIHJlZ2lzdGVy
IG5lZWRzIHRvIGJlCj4+Pj4+IHByb3Blcmx5IGhhbmRsZWQgZm9yIHRoZSBydGN3YWtlIHRvIHdv
cmsgcHJvcGVybHkuCj4+Pj4+Cj4+Pj4+IFBsYXRmb3JtcyB1c2luZyBzdWNoIElQIHNob3VsZCBz
ZXQgInRpLGFtMzM1Mi1ydGMiIGluIHJ0YyBkZXZpY2UgZHQKPj4+Pj4gY29tcGF0aWJpbGl0eSBu
b2RlLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBIZWJiYXIgR3VydXJhamEgPGd1cnVyYWph
LmhlYmJhckB0aS5jb20+Cj4+Pj4+IENjOiBHcmFudCBMaWtlbHkgPGdyYW50Lmxpa2VseUBsaW5h
cm8ub3JnPgo+Pj4+PiBDYzogUm9iIEhlcnJpbmcgPHJvYi5oZXJyaW5nQGNhbHhlZGEuY29tPgo+
Pj4+PiBDYzogUm9iIExhbmRsZXkgPHJvYkBsYW5kbGV5Lm5ldD4KPj4+Pj4gQ2M6IFNla2hhciBO
b3JpIDxuc2VraGFyQHRpLmNvbT4KPj4+Pj4gQ2M6IEtldmluIEhpbG1hbiA8a2hpbG1hbkBsaW5h
cm8ub3JnPgo+Pj4+PiBDYzogQWxlc3NhbmRybyBadW1tbyA8YS56dW1tb0B0b3dlcnRlY2guaXQ+
Cj4+Pj4+IENjOiBydGMtbGludXhAZ29vZ2xlZ3JvdXBzLmNvbQo+Pj4+PiBDYzogZGV2aWNldHJl
ZS1kaXNjdXNzQGxpc3RzLm96bGFicy5vcmcKPj4+Pj4gQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5l
bC5vcmcKPj4+Pj4gLS0tCj4+Pj4KPj4+PiBbLi4uXQo+Pj4+Cj4+Pj4+IC0jZGVmaW5lCU9NQVBf
UlRDX0RBVEFfREE4MzBfSURYCTEKPj4+Pj4gKyNkZWZpbmUJT01BUF9SVENfREFUQV9EQTgzMF9J
RFgJCTEKPj4+Pj4gKyNkZWZpbmUJT01BUF9SVENfREFUQV9BTTMzNVhfSURYCTIKPj4+Pj4gIAo+
Pj4+PiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2VfaWQgb21hcF9ydGNfZGV2dHlwZVtd
ID0gewo+Pj4+PiAgCXsKPj4+Pj4gQEAgLTMwOSw2ICszMjEsOSBAQCBzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RldmljZV9pZCBvbWFwX3J0Y19kZXZ0eXBlW10gPSB7Cj4+Pj4+ICAJfSwgewo+Pj4+
PiAgCQkubmFtZQk9ICJkYTgzMC1ydGMiLAo+Pj4+PiAgCQkuZHJpdmVyX2RhdGEgPSBPTUFQX1JU
Q19IQVNfS0lDS0VSLAo+Pj4+PiArCX0sIHsKPj4+Pj4gKwkJLm5hbWUJPSAiYW0zMzV4LXJ0YyIs
Cj4+Pj4KPj4+PiBtYXkgYmUgdXNlIGFtMzM1Mi1ydGMgaGVyZSBqdXN0IHRvIGtlZXAgdGhlIHBs
YXRmb3JtIGRldmljZSBuYW1lIGFuZCBvZgo+Pj4+IGNvbXBhdGlibGUgaW4gc3luYy4KPj4+Cj4+
PiBDb3JyZWN0LiBJIHdpbGwgdXBkYXRlIHRoZSBzYW1lIGluIHYyLgo+Pj4KPj4+Pgo+Pj4+PiAr
CQkuZHJpdmVyX2RhdGEgPSBPTUFQX1JUQ19IQVNfS0lDS0VSIHwgT01BUF9SVENfSEFTX0lSUVdB
S0VFTiwKPj4+Pj4gIAl9LAo+Pj4+PiAgCXt9LAo+Pj4+Cj4+Pj4gSXQgaXMgYmV0dGVyIHRvIHVz
ZSB0aGUgaW5kZXggZGVmaW5lZCBhYm92ZSBpbiB0aGUgc3RhdGljIGluaXRpYWxpemF0aW9uCj4+
Pj4gc28gdGhleSByZW1haW4gaW4gc3luYy4KPj4+Cj4+PiBTb3JyeS4gSSBkaWRu4oCZdCBnZXQg
dGhpcy4KPj4+Cj4+Cj4+IFNlZSBleGFtcGxlIGJlbG93IEkgcHJvdmlkZWQuIElmIGl0cyBzdGls
bCBub3QgY2xlYXIsIGxldCBtZSBrbm93IHdoYXQKPj4gaXMgbm90IGNsZWFyLgo+Pgo+Pj4+IAku
Li4KPj4+PiAJW09NQVBfUlRDX0RBVEFfREE4MzBfSURYXSA9IHsKPj4+PiAJCS5uYW1lCT0gImRh
ODMwLXJ0YyIsCj4+Pj4gCQkuZHJpdmVyX2RhdGEgPSBPTUFQX1JUQ19IQVNfS0lDS0VSLAo+Pj4+
IAl9LAo+IAo+IFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uIEluIHRoaXMgY2FzZSB3aWxs
IGl0IG9rIGlmIEkgdXBkYXRlIHRoZSBwcmV2aW91cwo+IG1lbWJlciBhbHNvLgoKWW91IGRvbnQg
cmVhbGx5IHJlZmVyZW5jZSBbMF0gaW4gb21hcF9ydGNfb2ZfbWF0Y2hbXSBzbyBldmVuIGlmIHlv
dQpsZWF2ZSBpdCBhcy1pcywgdGhhdCdzIGZpbmUgd2l0aCBtZS4gSSBhbSBtb3N0bHkgY29uY2Vy
bmVkIHdpdGggdGhlCmluZGV4IGRlZmluaXRpb25zIGFuZCBpbml0aWFsaXphdGlvbiBvcmRlciBi
ZWluZyBvdXQgb2Ygc3luYyBhbmQgdGhhdCdzCnJlYWxseSBub3QgYW4gaXNzdWUgd2l0aCBbMF0u
CgpUaGFua3MsClNla2hhcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkZXZpY2V0cmVlLWRpc2N1c3MgbWFpbGluZyBsaXN0CmRldmljZXRyZWUtZGlzY3Vz
c0BsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9kZXZp
Y2V0cmVlLWRpc2N1c3MK
