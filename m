From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
Date: Tue, 2 Feb 2016 11:33:08 +0200
Message-ID: <56B077D4.3030902@gmail.com>
References: <20160106174713.GL12777@atomide.com> <568D5669.4040801@gmail.com>
 <20160106182650.GM12777@atomide.com> <568D5F54.7040900@gmail.com>
 <20160107180700.GN12777@atomide.com> <568EDC8D.7070205@gmail.com>
 <20160108022619.GS12777@atomide.com> <568F4596.8020206@gmail.com>
 <20160108075913.GN11364@pali> <569052FE.1040008@gmail.com>
 <20160121091437.GT7192@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160121091437.GT7192@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, pavel@ucw.cz, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

CkhpLAoKT24gMjEuMDEuMjAxNiAxMToxNCwgUGFsaSBSb2jDoXIgd3JvdGU6Cj4gT24gU2F0dXJk
YXkgMDkgSmFudWFyeSAyMDE2IDAyOjIzOjI2IEl2YXlsbyBEaW1pdHJvdiB3cm90ZToKPj4gSGks
Cj4+Cj4+IE9uICA4LjAxLjIwMTYgMDk6NTksIFBhbGkgUm9ow6FyIHdyb3RlOgo+Pj4gT24gRnJp
ZGF5IDA4IEphbnVhcnkgMjAxNiAwNzoxMzo1OCBJdmF5bG8gRGltaXRyb3Ygd3JvdGU6Cj4+Pj4g
QW5kIGl0IGxvb2tzIGxpa2UgdGhlIHByb2JsZW1zIGhhcHBlbnMgc29tZXRpbWVzIG9uIG9vcHMg
dG9vLgo+Pj4KPj4+IEluIGxpbnV4LW45MDAgdHJlZSBpcyBlbmFibGVkIG10ZG9vcHMgZHJpdmVy
IHdoaWNoIHN0b3JlIG9vcHMgdG8KPj4+IHNwZWNpZmllZCBNVEQgZGV2aWNlLiBTbyBtYXliZSB0
aGlzIGFjY2VzcyBjYXVzZSBpdD8KPj4+Cj4+Cj4+IFRoZSBrZXkgd29yZCBoZXJlIGlzICJzb21l
dGltZXMiLiBpLmUgc29tZXRpbWVzIGl0IGhhcGVucyBvbiBub3JtYWwgcmVib290LAo+PiBzb21l
dGltZXMgaXQgaGFwcGVucyBvbiBvb3BzLgo+Cj4gU28gd2hlcmUgaXMgcHJvYmxlbT8gSW4gb21h
cC1ncG1jPyBtdGQ/IG9uZW5hbmQ/IG9yIHViaWZzPyBPciBpbgo+IGRpZmZlcmVudCBjb21wb25l
bnQ/IERvIHdlIGtub3cgYXQgbGVhc3QgdGhpcz8KPgoKSSB0aGluayBJIG1hZGUgc29tZSBwcm9n
cmVzcyBvbiB0aGUgaXNzdWUsIGl0IHNlZW1zIEkgaGF2ZSB0byBoYXZlIAoqYm90aCogZTdiMTFk
YzdiNzdiZmNlMGEzNTEyMzBhNWZlZWFkYzFkMGJiYTk5NyAKKGU3YjExZGM3Yjc3YmZjZTBhMzUx
MjMwYTVmZWVhZGMxZDBiYmE5OTcpIHJldmVydGVkICphbmQqIApIV01PRF9JTklUX05PX1JFU0VU
IHJlc3RvcmVkIGluIG9tYXAzeHh4X2dwbWNfaHdtb2QgZmxhZ3MgdG8gaGF2ZSAKd29ya2luZyBv
bmVuYW5kLgoKVG9ueSwgc2hhbGwgSSBoYXJkY29kZSBHUE1DX0NTX0NPTkZJRzQgT0VPTlRJTUUg
dG8gYmUgdGhlIHNhbWUgYXMgTk9MTydzIApvciBpdCBkb2VzIG5vdCBtYWtlIHNlbnNlPwoKUmVn
YXJkcywKSXZvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
