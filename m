From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: OMAP: mcbsp: ensure that CLKX and
 CLKR are not used as ouput pins when they are used as input clock for the
 SRG.
Date: Mon, 19 Jan 2015 09:44:51 +0200
Message-ID: <54BCB5F3.6000704@ti.com>
References: <1421360901-20671-1-git-send-email-niederp@physik.uni-kl.de>		
 <54B8D6CB.6020801@ti.com>	
 <1421403335.2546.14.camel@ag-ott-thomas.physik.uni-kl.de>	
 <54B9074B.5020903@ti.com>
 <1421420798.2546.22.camel@ag-ott-thomas.physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1421420798.2546.22.camel@ag-ott-thomas.physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: niederp@physik.uni-kl.de
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org

T24gMDEvMTYvMjAxNSAwNTowNiBQTSwgVGhvbWFzIE5pZWRlcnByw7xtIHdyb3RlOgo+PiBVbmZv
cnR1bmF0ZWx5IHRoZSBvbWFwLW1jYnNwIGRyaXZlciBvbmx5IHN1cHBvcnRzIHN5bmNocm9ub3Vz
IGNvbmZpZ3VyYXRpb24KPj4gZm9yIHR4L3J4IChzaW5jZSBhbG1vc3QgYWxsIE1jQlNQIGluc3Rh
bmNlIGNhbiBvbmx5IGJlIHVzZWQgdGhpcyB3YXkpLiBUaGUKPj4gZmlyc3Qgc3RyZWFtIHdpbGwg
Y29uZmlndXJlIGJvdGggdHggYW5kIHJ4IHRvIGhhdmUgdGhlIHNhbWUgcHJvcGVydGllcy4gRXZl
bgo+PiBpZiB5b3UgYXJlIHVzaW5nIE1jQlNQMSB3aGljaCBoYXMgc2VwYXJhdGUgRlNYIGFuZCBG
U1IgbGluZXMsIHRoZSBkcml2ZXIgZG9lcwo+PiBub3QgaGF2ZSBzdXBwb3J0IGZvciB0aGlzLgo+
PiBGcm9tIEhXIHBvaW50IG9mIHZpZXcgdGhpcyBjb25maWd1cmF0aW9uIGlzIHZhbGlkIChub3Qg
c29tZXRoaW5nIEkgd291bGQKPj4gZXhwZWN0IGluIGFueSBwcm9kdWN0KS4gSSBkb24ndCB0aGlu
ayB0aGVyZSBhcmUgb3Igd2lsbCBiZSBvdGhlciBkZXNpZ25zIHRoYW4KPj4geW91ciB1c2luZyB0
aGlzIG1vZGUuLi4gQnV0LCBpZiB5b3UgYWRkIHNvbWUgY29tbWVudCBhcm91bmQgdGhlIG1hc2tp
bmcgb2YKPj4gQ0xLWE0gYW5kIENMS1JNIGJpdHMgdGhhdCB3b3VsZCBiZSBncmVhdC4KPiAKPiBE
byB5b3UgbWVhbiBhZGRpbmcgaXQgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIG9yIHRvIHRoZSBjb2Rl
PyBvciBib3RoPwoKU2luY2UgdGhpcyBpcyBzb21ldGhpbmcgdGhhdCB0aGUgZHJpdmVyIGhhcyBu
b3QgbWVhbnQgdG8gc3VwcG9ydCBvZmZpY2lhbGx5LCBJCnByZWZlciBib3RoLiBJIGp1c3QgaG9w
ZSB0aGF0IEhXIGRlc2lnbmVycyB3aWxsIG5vdCBnZXQgaWRlYXMgYmFzZWQgb24gdGhpcyA7KQoK
LS0gClDDqXRlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
