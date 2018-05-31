From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH 0/6] drm/tidss: new display driver for TI's DSS6
Date: Thu, 31 May 2018 15:43:48 +0300
Message-ID: <61192206-2118-01f5-d5cd-e6653056b989@ti.com>
References: <20180531124109.3209-1-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180531124109.3209-1-tomi.valkeinen@ti.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

T24gMzEvMDUvMTggMTU6NDEsIFRvbWkgVmFsa2VpbmVuIHdyb3RlOgo+IEhpLAo+IAo+IFRoaXMg
aXMgYSBuZXcgRFJNIGRyaXZlciBmb3IgVGV4YXMgSW5zdHJ1bWVudHMnIEtleXN0b25lIEsyRyBT
b0MuIEsyRyBoYXMgRFNTNgo+IElQLCB3aGljaCBpcyByZWxhdGVkIHRvIHRoZSBPTUFQIERTUyBJ
UHMgaGFuZGxlZCBieSB0aGUgb21hcGRybSBkcml2ZXIuIFdoaWxlCj4gb24gaGlnaGVyIGxldmVs
IHRoZSBEU1M2IHJlc2VtYmxlcyB0aGUgb2xkZXIgRFNTIHZlcnNpb25zLCB0aGUgcmVnaXN0ZXJz
IGFuZAo+IHRoZSBpbnRlcm5hbCBwaXBlbGluZXMgZGlmZmVyIGEgbG90Lgo+IAo+IERTUzYgSVAg
b24gSzJHIGlzIGEgInVsdHJhLWxpZ2h0IiB2ZXJzaW9uLCBhbmQgaGFzIG9ubHkgYSBzaW5nbGUg
cGxhbmUgYW5kIGEKPiBzaW5nbGUgb3V0cHV0LiBUaGUgZHJpdmVyIHdpbGwgYWxzbyBzdXBwb3J0
IGZ1dHVyZSBEU1MgdmVyc2lvbnMsIGxpa2UgRFNTNyBvbgo+IEFNNiBTb0MsIHdoaWNoIHN1cHBv
cnRzIG11bHRpcGxlIHBsYW5lcyBhbmQgb3V0cHV0cywgc28gdGhlIGRyaXZlciBhbHJlYWR5IGhh
cwo+IHN1cHBvcnQgZm9yIHRob3NlLiBUaGlzIGlzIGFsc28gdGhlIHJlYXNvbiBmb3IgdGhlIGRp
c3BjIGFic3RyYWN0aW9uIGxheWVyLgo+IAo+IFRoZSBzZXJpZXMgaXMgYW4gUkZDLCBhcyBJIHdh
bnQgdG8gaW5jbHVkZSB0aGUgRFNTNyBkcml2ZXIgaW4gdGhlIGZpbmFsCj4gdmVyc2lvbi4gSSBo
b3BlIHRoYXQncyByZWFkeSBpbiBhIHdlZWsgb3IgdHdvLiBJJ20gbG9va2luZyBmb3IgY29tbWVu
dHMgb24gdGhlCj4gb3ZlcmFsbCBhcmNoaXRlY3R1cmUuCgpBYW5kIEkgZm9yZ290IHRvIGdpdmUg
Y3JlZGl0IHRvIExhdXJlbnQsIGFzIEkgZGlkIGxvb2sgYXQgaGlzIHJjYXItZHUKZHJpdmVyIGEg
bG90IHdoZW4gd3JpdGluZyB0aGlzLiBUaGVyZSdzIGFsc28gYSBsb3Qgb2YgY29kZSBhZGFwdGVk
IGZyb20Kb21hcGRybS4KCiBUb21pCgotLSAKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBPeSwg
UG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClktdHVubnVzL0J1c2luZXNzIElEOiAw
NjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
