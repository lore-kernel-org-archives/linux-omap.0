From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RESEND][PATCH] ASoC: ams-delta: Convert to use
	snd_soc_register_card()
Date: Wed, 03 Oct 2012 15:51:23 +0200
Message-ID: <6691562.6MvWD9K1dk@vclass>
References: <20120906073633.GC22330@opensource.wolfsonmicro.com>
 <1582731.dIkBtAuyKn@vclass>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1582731.dIkBtAuyKn@vclass>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

TWFyaywKUGxlYXNlIG5vdGUgd2UgaGF2ZSBhbiBBY2sgZnJvbSBUb255LgpodHRwOi8vbWFpbG1h
bi5hbHNhLXByb2plY3Qub3JnL3BpcGVybWFpbC9hbHNhLWRldmVsLzIwMTItU2VwdGVtYmVyLzA1
NTQ5My5odG1sCgpUaGFua3MsCkphbnVzegoKLS0tClN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFTb0M6
IGFtcy1kZWx0YTogQ29udmVydCB0byB1c2Ugc25kX3NvY19yZWdpc3Rlcl9jYXJkKCkKRGF0ZTog
bmllZHppZWxhLCAxNiB3cnplxZtuaWEgMjAxMiwgMTM6NDQ6MjMKRnJvbTogVG9ueSBMaW5kZ3Jl
biA8dG9ueUBhdG9taWRlLmNvbT4KVG86IEphbnVzeiBLcnp5c3p0b2ZpayA8amtyenlzenRAdGlz
LmljbmV0LnBsPgpDYzogTWFyayBCcm93biA8YnJvb25pZUBvcGVuc291cmNlLndvbGZzb25taWNy
by5jb20+LCBMaWFtIEdpcmR3b29kIDxscmdAdGkuY29tPiwgbGludXgtb21hcEB2Z2VyLmtlcm5l
bC5vcmcsIGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZywgYWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCgoqIEphbnVzeiBLcnp5c3p0b2ZpayA8amtyenlzenRAdGlzLmljbmV0
LnBsPiBbMTIwOTE2IDEyOjE4XToKPiAKPiBUb255LAo+IFBsZWFzZSBnaXZlIHlvdXIgYWNrIG9u
IHRoZSBhcmNoL2FybS9tYWNoLW9tYXAxIGJpdHMgaWYgYWNjZXB0YWJsZS4gSQo+IGJlbGlldmUg
dGhlcmUgc2hvdWxkIGJlIG5vIG1lcmdlIGNvbmZsaWN0cyBpZiB0aGlzIGNoYW5nZSBnb2VzIHRo
cm91Z2gKPiBzb3VuZC9zb2MuCgpZZXMgbG9va3MgZ29vZCB0byBtZToKCkFja2VkLWJ5OiBUb255
IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxA
YWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
