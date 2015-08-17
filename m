From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC v2 3/7] ASoC: hdmi-codec: Add hdmi-codec for external
 HDMI-encoders
Date: Mon, 17 Aug 2015 11:39:31 +0300
Message-ID: <55D19DC3.3070704@ti.com>
References: <1432666751-24794-1-git-send-email-jsarha@ti.com>
 <1432666751-24794-4-git-send-email-jsarha@ti.com>
 <20150814192521.GL10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150814192521.GL10748@sirena.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mark Brown <broonie@kernel.org>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T24gMDgvMTQvMTUgMjI6MjUsIE1hcmsgQnJvd24gd3JvdGU6Cj4gT24gVHVlLCBNYXkgMjYsIDIw
MTUgYXQgMDk6NTk6MDdQTSArMDMwMCwgSnlyaSBTYXJoYSB3cm90ZToKPgo+PiArCj4+ICsJbXV0
ZXhfbG9jaygmaGNwLT5jdXJyZW50X3N0cmVhbV9sb2NrKTsKPj4gKwlpZiAoaGNwLT5jdXJyZW50
X3N0cmVhbSAmJiBoY3AtPmN1cnJlbnRfc3RyZWFtLT5ydW50aW1lICYmCj4+ICsJICAgIHNuZF9w
Y21fcnVubmluZyhoY3AtPmN1cnJlbnRfc3RyZWFtKSkgewo+PiArCQlkZXZfaW5mbyhkZXYsICJI
RE1JIGF1ZGlvIHBsYXliYWNrIGFib3J0ZWRcbiIpOwo+Cj4gRG9lcyB0aGlzIHJlYWxseSBuZWVk
IHRvIGJlIGRldl9pbmZvKCk/Cj4KCk5vLCBJJ2xsIGNoYW5nZSB0aGF0IHRvIGRlYnVnIGxldmVs
LgoKPj4gKwlpZiAoaGNwLT5oY2Qub3BzLT5nZXRfZWxkKSB7Cj4+ICsJCWhjcC0+ZWxkID0gaGNw
LT5oY2Qub3BzLT5nZXRfZWxkKGhjcC0+aGNkLmRldik7Cj4+ICsKPj4gKwkJLyogQ2FsbCBzbmRf
cGNtX2h3X2NvbnN0cmFpbnRfZWxkIGhlcmUgKi8KPj4gKwl9Cj4KPiAuLi4KPgo+PiArCWRldl9k
YmcoZGFpLT5kZXYsICIlcygpXG4iLCBfX2Z1bmNfXyk7Cj4+ICsKPj4gKwltdXRleF9sb2NrKCZo
Y3AtPmN1cnJlbnRfc3RyZWFtX2xvY2spOwo+PiArCUJVR19PTihoY3AtPmN1cnJlbnRfc3RyZWFt
ICE9IHN1YnN0cmVhbSk7Cj4+ICsJaGNwLT5jdXJyZW50X3N0cmVhbSA9IE5VTEw7Cj4+ICsJbXV0
ZXhfdW5sb2NrKCZoY3AtPmN1cnJlbnRfc3RyZWFtX2xvY2spOwo+PiArCj4+ICsJaGNwLT5oY2Qu
b3BzLT5hdWRpb19zaHV0ZG93bihoY3AtPmhjZC5kZXYpOwo+Cj4gU2hvdWxkbid0IHRoZSBjYWxs
YmFjayBiZSBpbiBvciBiZWZvcmUgdGhlIGxvY2s/ICBPdGhlcndpc2Ugd2UgY291bGQKPiBwb3Rl
bnRpYWxseSByYWNlIHdpdGggc3RhcnRpbmcgYSBuZXcgc3RyZWFtLgo+CgpZZXMsIGl0IHNob3Vs
ZCBiZSBiZWZvcmUgaXQuIEknbGwgZml4IHRoYXQuCgpJZiBpdCBpcyBpbnNpZGUsIHRoZXJlIGlz
IGEgInBvc3NpYmxlIGRlYWRsb2NrIiB3YXJuaW5nIChhdGxlYXN0IGluIHRoZSAKc2ltaWxhciBw
bGFjZSBpbiBvbWFwLWhkbWktYXVkaW8gdGhlcmUgd2FzKSBpZiB0aG9zZSB3YXJuaW5ncyBhcmUg
dHVybmVkIApvbiBhbmQgdGhlcmUgaXMgYW5vdGhlciBsb2NrIHRoYXQgaXMgdGFrZW4gaW4gdGhl
IHZpZGVvIHNpZGUgY2FsbGJhY2tzLgoKVGhhbmtzLApKeXJpCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
