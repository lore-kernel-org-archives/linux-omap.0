From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec
	support
Date: Thu, 8 Mar 2018 09:53:15 +0000
Message-ID: <20180308095315.mpcmx2ob6yhsnrm6@dell>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20180308094652.qg4atjw5c3hayaz3@earth.universe>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

T24gVGh1LCAwOCBNYXIgMjAxOCwgU2ViYXN0aWFuIFJlaWNoZWwgd3JvdGU6Cj4gT24gV2VkLCBN
YXIgMDcsIDIwMTggYXQgMDQ6MzI6MTFQTSArMDAwMCwgTGVlIEpvbmVzIHdyb3RlOgo+ID4gT24g
RnJpLCAyMyBGZWIgMjAxOCwgU2ViYXN0aWFuIFJlaWNoZWwgd3JvdGU6Cj4gPiA+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IG1mZF9jZWxsIGNwY2FwX21mZF9kZXZpY2VzW10gPSB7Cj4gCj4gWy4uLl0K
PiAKPiA+ID4gKwl9LCB7Cj4gPiA+ICsJCS5uYW1lICAgICAgICAgID0gImNwY2FwLWxlZCIsCj4g
PiA+ICsJCS5pZCAgICAgICAgICAgID0gNCwKPiA+ID4gKwkJLm9mX2NvbXBhdGlibGUgPSAibW90
b3JvbGEsY3BjYXAtbGVkLWNwIiwKPiA+ID4gKwl9LCB7Cj4gPiA+ICsJCS5uYW1lICAgICAgICAg
ID0gImNwY2FwLWNvZGVjIiwKPiA+ID4gKwl9Cj4gPiA+ICt9Owo+ID4gCj4gPiBXaXRoIG5vbmUg
b2YgdGhlIGVudHJpZXMgY29udGFpbmluZyBwbGF0Zm9ybV9kYXRhIC9tZSB3b25kZXJzIHdoeSB5
b3UKPiA+IGNhbid0IHN0aWxsIHVzZSBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKCk/Cj4gCj4g
QmVjYXVzZSBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlIHdvcmtzIHdpdGggY29tcGF0aWJsZSBw
cm9wZXJ0aWVzIGFuZAo+IGNwY2FwLWNvZGVjIGRvZXMgbm90IGhhdmUgb25lIGFmdGVyIEkgcmVt
b3ZlZCBpdCBmb3IgTWFyay4KClNvcnJ5LCBJIG1pc3NlZCB0aGF0IGNvbnZlcnNhdGlvbi4gIFdo
eSB3YXMgaXQgcmVtb3ZlZD8KCj4gPiA+ICBzdGF0aWMgaW50IGNwY2FwX3Byb2JlKHN0cnVjdCBz
cGlfZGV2aWNlICpzcGkpCj4gPiA+ICB7Cj4gPiA+ICAJY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCAqbWF0Y2g7Cj4gPiA+IEBAIC0yNjAsNyArMzA4LDggQEAgc3RhdGljIGludCBjcGNhcF9wcm9i
ZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQo+ID4gPiAgCWlmIChyZXQpCj4gPiA+ICAJCXJldHVy
biByZXQ7Cj4gPiA+ICAKPiA+ID4gLQlyZXR1cm4gZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZSgm
Y3BjYXAtPnNwaS0+ZGV2KTsKPiA+ID4gKwlyZXR1cm4gZGV2bV9tZmRfYWRkX2RldmljZXMoJnNw
aS0+ZGV2LCAwLCBjcGNhcF9tZmRfZGV2aWNlcywKPiA+ID4gKwkJCQkgICAgQVJSQVlfU0laRShj
cGNhcF9tZmRfZGV2aWNlcyksIE5VTEwsIDAsIE5VTEwpOwo+ID4gPiAgfQo+ID4gPiAgCj4gPiA+
ICBzdGF0aWMgc3RydWN0IHNwaV9kcml2ZXIgY3BjYXBfZHJpdmVyID0gewo+ID4gCgoKCi0tIApM
ZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFkCkxpbmFy
by5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJv
OiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxz
YS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
