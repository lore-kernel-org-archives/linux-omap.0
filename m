From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC update 0/2] dmaengine/ASoC: omap: Enable
 element mode in cyclic DMA
Date: Mon, 10 Sep 2012 11:21:34 +0300
Message-ID: <504DA30E.9030304@ti.com>
References: <E1T8a09-0002vz-Bl@rmk-PC.arm.linux.org.uk>
 <1346760482-12794-1-git-send-email-peter.ujfalusi@ti.com>
 <1402174.PkzhGH5Vno@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1402174.PkzhGH5Vno@acer>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

SGkgSmFudXN6LAoKT24gMDkvMDkvMjAxMiAxMDo1NyBQTSwgSmFudXN6IEtyenlzenRvZmlrIHdy
b3RlOgo+IE9uIFR1ZSwgNCBTZXAgMjAxMiAxNTowODowMCBQZXRlciBVamZhbHVzaSB3cm90ZToK
Pj4KPj4gRW5hYmxlIHRoZSBlbGVtZW50IG1vZGUgKHRodXMgYWxsb3dpbmcgbW9ubyBwbGF5YmFj
ayBhbmQgcHJvYmFibHkgCj4gdW5ibG9ja2luZwo+PiBPTUFQMSwgT01BUDI0MjApIGluIE9NQVAg
ZG1hZW5naW5lIGFuZCBvbWFwLXBjbS4KPj4KPj4gSmFudXN6OiB3b3VsZCBpdCBiZSBwb3NzaWJs
ZSBmb3IgeW91IHRvIHRlc3QgUnVzc2VsbCdzIHNlcmllcyBwbHVzIAo+IHRoaXMgb24KPj4gT01B
UDEgdG8gbWFrZSBzdXJlIHRoYXQgd2UgZG8gbm90IGJyb2tlIGl0Pwo+IAo+IEhpLAo+IEkgY2Fu
IGNvbmZpcm0gdGhhdCBzb3VuZCB3b3JrcyBmb3IgbWUgYXMgYmVmb3JlLCBib3RoIGNhcHR1cmUg
YW5kIAo+IHBsYXliYWNrLCBvbiBteSBPTUFQMSBBbXN0cmFkIERlbHRhIHdpdGggUnVzc2VsbCdz
IGFuZCBQZXRlcidzIHBhdGNoZXMgCj4gYXBwbGllZCBvbiB0b3Agb2YgbGludXgtMy42LXJjMywg
d2l0aCB0aGUgT01BUCBETUEgZW5naW5lIGRyaXZlciBidWlsdCAKPiBpbi4gSSB3YXMgbm90IGFi
bGUgbWFrZSBhdWRpYmxlIHRlc3RzIHdpdGggYXBwbGljYXRpb25zIG90aGVyIHRoYW4gYSAKPiBz
b2Z0IHBob25lIGFzIEkgZGlkbid0IGdldCBiYWNrIGhvbWUgZm9yIHRoaXMgd2Vla2VuZCwgYnV0
IEkgdGhpbmsgdGhhdCAKPiB0aGUgYXN0ZXJpc2sgc29mdCBwaG9uZSBpcyBxdWl0ZSBhIGRlbWFu
ZGluZyB1c2UgY2FzZS4KClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRha2luZyB0aW1lIHRvIHRl
c3QgdGhpcyEgVGhpcyBpcyBpbmRlZWQgYSBnb29kIG5ld3MuCgo+IFRoZSBvbmx5IHRoaW5nIEkn
bSBub3Qgc3VyZSBhYm91dCBpcyB3aHkgdGhlIHN5c2ZzIHByb3ZpZGVkIAo+IGJ5dGVzX3RyYW5z
ZmVycmVkIHZhbHVlcyBuZXZlciBjaGFuZ2UgZnJvbSB0aGVpciBpbml0aWFsIHplcm9zLgoKSSBo
YXZlIG5vdCBsb29rZWQgYXQgdGhvc2UgZmlsZXMgaW4gc3lzZnMsIGJ1dCBpZiB0aGUgc2FtZSBh
cHBsaWVzIGZvcgpPTUFQMy80LzUgSSBjYW4gbG9vayBhdCBpdCBhbmQgZml4IGl0IHdoaWNoIHNo
b3VsZCBjb3JyZWN0IE9NQVAxIGF0IHRoZSBzYW1lIHRpbWUuCgo+IAo+IEZvciBPTUFQMToKPiBU
ZXN0ZWQtYnk6IEphbnVzeiBLcnp5c3p0b2ZpayA8amtyenlzenRAdGlzLmljbmV0LnBsPgoKQWdh
aW4sIHRoYW5rcyBmb3IgdGhlIHRlc3RpbmcsClDDqXRlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRl
dmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
