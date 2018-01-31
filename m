From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Date: Wed, 31 Jan 2018 11:12:20 +0200
Message-ID: <f3f23e16-2045-78bd-b77e-f236cab3b85d@ti.com>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180129232031.GA7695@lenoch>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>, Pavel Machek <pavel@ucw.cz>
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, tony@atomide.com, abcloriens@gmail.com, lgirdwood@gmail.com, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, patrikbachan@gmail.com, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tiwai@suse.com, serge@hallyn.com, devicetree@vger.kernel.org, broonie@kernel.org, sre@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, aaro.koskinen@iki.fi, linux-kernel@vger.kernel.org, robh+dt@kernel.org, clayton@craftyguy.net, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, bhumirks@gmail.com
List-Id: linux-omap@vger.kernel.org

CgpPbiAyMDE4LTAxLTMwIDAxOjIwLCBMYWRpc2xhdiBNaWNobCB3cm90ZToKPiBPbiBUdWUsIEph
biAzMCwgMjAxOCBhdCAxMjowNTozOUFNICswMTAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6Cj4+Cj4+
IFRoaXMgYWRkcyBkZXZpY2UgdHJlZSBzdXBwb3J0IHRvIHRsdjMyMGRhYzMzLmMuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IFBhdmVsIE1hY2hlayA8cGF2ZWxAdWN3LmN6Pgo+Pgo+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3RsdjMyMGRhYzMzLnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC90bHYzMjBkYWMzMy50
eHQKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMC4uNmNiZDMxMQo+PiAt
LS0gL2Rldi9udWxsCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC90bHYzMjBkYWMzMy50eHQKPj4gQEAgLTAsMCArMSwzMiBAQAo+PiArVGV4YXMgSW5zdHJ1
bWVudHMgLSB0bHYzMjBkYWMzMyBDb2RlYyBtb2R1bGUKPj4gKwo+PiArVGhlIHRsdjMyMGRhYzMz
IHNlcmlhbCBjb250cm9sIGJ1cyBjb21tdW5pY2F0ZXMgdGhyb3VnaCBJMkMgcHJvdG9jb2xzLgo+
PiArCj4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+PiArCj4+ICstIGNvbXBhdGlibGUgLSAidGks
dGx2MzIwZGFjMzMiCj4+ICstIHJlZyAtIEkyQyBzbGF2ZSBhZGRyZXNzCj4+ICsKPj4gK09wdGlv
bmFsIHByb3BlcnRpZXM6Cj4+ICsKPj4gKy0gcG93ZXItZ3Bpb3MgLSBncGlvIHBpbiB0byBwb3dl
ciB0aGUgZGV2aWNlLCBhY3RpdmUgaGlnaAo+IAo+IFdoaWxlIGRyaXZlciB1c2VkIGdwaW8gaW4g
cGxhdGZvcm0gZGF0YSwgaXNuJ3QgaXQgbW9yZSBsaWtlbHkKPiByZWd1bGF0b3Igd2hpY2ggcG93
ZXJzIGRldmljZT8KCkl0IGlzIEdQSU8sIGFuZCBhY2NvcmRpbmcgdG8gdGhlIG5vbiBwdWJsaWMg
VFJNIGl0IGlzIGNvbm5lY3RlZCB0byB0aGUKcmVzZXQgcGluIG9mIHRoZSBjb2RlYy4KClNvIHRo
ZSBjb3JyZWN0IG5hbWUgc2hvdWxkIGJlIHJlc2V0LWdwaW9zCgotIFDDqXRlcgoKVGV4YXMgSW5z
dHJ1bWVudHMgRmlubGFuZCBPeSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuClkt
dHVubnVzL0J1c2luZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNp
bmtpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2Et
ZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFp
bG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
