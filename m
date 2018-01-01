From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 01/33] clk_ops: change round_rate() to return unsigned long
Date: Tue, 2 Jan 2018 02:01:18 +0800
Message-ID: <201801020112.PEMNifTo%fengguang.wu@intel.com>
References: <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Cc: linux-mips@linux-mips.org, mturquette@baylibre.com, dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, pure.logic@nexus-software.ie, linux-omap@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, kbuild-all@01.org, freedreno@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

SGkgQnJ5YW4sCgpJIGxvdmUgeW91ciBwYXRjaCEgUGVyaGFwcyBzb21ldGhpbmcgdG8gaW1wcm92
ZToKClthdXRvIGJ1aWxkIHRlc3QgV0FSTklORyBvbiB0ZWdyYS9mb3ItbmV4dF0KW2Fsc28gYnVp
bGQgdGVzdCBXQVJOSU5HIG9uIHY0LjE1LXJjNl0KW2Nhbm5vdCBhcHBseSB0byBjbGsvY2xrLW5l
eHQgbmV4dC0yMDE3MTIyMl0KW2lmIHlvdXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3Jvbmcg
Z2l0IHRyZWUsIHBsZWFzZSBkcm9wIHVzIGEgbm90ZSB0byBoZWxwIGltcHJvdmUgdGhlIHN5c3Rl
bV0KCnVybDogICAgaHR0cHM6Ly9naXRodWIuY29tLzBkYXktY2kvbGludXgvY29tbWl0cy9Ccnlh
bi1PLURvbm9naHVlL2NoYW5nZS1jbGtfb3BzLXJvdW5kX3JhdGUtdG8tc2NhbGUtcGFzdC1MT05H
X01BWC8yMDE4MDEwMS0yMTI5MDcKYmFzZTogICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90ZWdyYS9saW51eC5naXQgZm9yLW5leHQKcmVwcm9kdWNlOgog
ICAgICAgICMgYXB0LWdldCBpbnN0YWxsIHNwYXJzZQogICAgICAgIG1ha2UgQVJDSD14ODZfNjQg
YWxsbW9kY29uZmlnCiAgICAgICAgbWFrZSBDPTEgQ0Y9LURfX0NIRUNLX0VORElBTl9fCgoKc3Bh
cnNlIHdhcm5pbmdzOiAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pCgoKdmltICszMjEgZHJpdmVy
cy9jbGsvY2xrLXZlcnNhY2xvY2s1LmMKCjhjMWViZTk3IE1hcmVrIFZhc3V0IDIwMTctMDctMDkg
IDMxOCAgCjhjMWViZTk3IE1hcmVrIFZhc3V0IDIwMTctMDctMDkgIDMxOSAgc3RhdGljIGNvbnN0
IHN0cnVjdCBjbGtfb3BzIHZjNV9kYmxfb3BzID0gewo4YzFlYmU5NyBNYXJlayBWYXN1dCAyMDE3
LTA3LTA5ICAzMjAgIAkucmVjYWxjX3JhdGUJPSB2YzVfZGJsX3JlY2FsY19yYXRlLAo4YzFlYmU5
NyBNYXJlayBWYXN1dCAyMDE3LTA3LTA5IEAzMjEgIAkucm91bmRfcmF0ZQk9IHZjNV9kYmxfcm91
bmRfcmF0ZSwKOGMxZWJlOTcgTWFyZWsgVmFzdXQgMjAxNy0wNy0wOSAgMzIyICAJLnNldF9yYXRl
CT0gdmM1X2RibF9zZXRfcmF0ZSwKOGMxZWJlOTcgTWFyZWsgVmFzdXQgMjAxNy0wNy0wOSAgMzIz
ICB9Owo4YzFlYmU5NyBNYXJlayBWYXN1dCAyMDE3LTA3LTA5ICAzMjQgIAoKOjo6Ojo6IFRoZSBj
b2RlIGF0IGxpbmUgMzIxIHdhcyBmaXJzdCBpbnRyb2R1Y2VkIGJ5IGNvbW1pdAo6Ojo6OjogOGMx
ZWJlOTc2MjY3MDE1OWNhOTgyMTY3MTMxYWY2M2M5NGZmMTU3MSBjbGs6IHZjNTogQWRkIHN1cHBv
cnQgZm9yIHRoZSBpbnB1dCBmcmVxdWVuY3kgZG91YmxlcgoKOjo6Ojo6IFRPOiBNYXJlayBWYXN1
dCA8bWFyZWsudmFzdXRAZ21haWwuY29tPgo6Ojo6OjogQ0M6IFN0ZXBoZW4gQm95ZCA8c2JveWRA
Y29kZWF1cm9yYS5vcmc+CgotLS0KMC1EQVkga2VybmVsIHRlc3QgaW5mcmFzdHJ1Y3R1cmUgICAg
ICAgICAgICAgICAgT3BlbiBTb3VyY2UgVGVjaG5vbG9neSBDZW50ZXIKaHR0cHM6Ly9saXN0cy4w
MS5vcmcvcGlwZXJtYWlsL2tidWlsZC1hbGwgICAgICAgICAgICAgICAgICAgSW50ZWwgQ29ycG9y
YXRpb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJp
LWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
