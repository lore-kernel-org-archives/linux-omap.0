From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
Date: Mon, 7 Feb 2011 07:57:17 -0800
Message-ID: <20110207155717.GE20795@atomide.com>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
	<AANLkTi=qtRP1tAs1wPnGugE2rGBTERgHuUKKBWhbs=ST@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=qtRP1tAs1wPnGugE2rGBTERgHuUKKBWhbs=ST@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Kevin Hilman <khilman@deeprootsystems.com>, Anton Vorontsov <avorontsov@mvista.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kukjin Kim <kgene.kim@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Erik Gilling <konkers@android.com>, linux-sh@vger.kernel.org, Vincent Sanders <support@simtec.co.uk>, "Hans J. Koch" <hjk@linutronix.de>, Marc Singer <elf@buici.com>, David Brown <davidb@codeaurora.org>, Alessandro Rubini <rubini@unipv.it>, Jiandong Zheng <jdzheng@broadcom.com>, Wan ZongShun <mcuos.com@gmail.com>, linux-arm-msm@vger.kernel.org, Olof Johansson <olof@lixom.net>, Ryan Mallon <ryan@bluewatersys.com>, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBNYWdudXMgRGFtbSA8bWFnbnVzLmRhbW1AZ21haWwuY29tPiBbMTEwMTA1IDIxOjEwXToKPiBP
biBXZWQsIEphbiA1LCAyMDExIGF0IDU6MjIgQU0sIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eAo+
IDxsaW51eEBhcm0ubGludXgub3JnLnVrPiB3cm90ZToKPiA+IFRoaXMgdW5jb3VwbGUgUEhZU19P
RkZTRVQgZnJvbSB0aGUgcGxhdGZvcm0gZGVmaW5pdGlvbnMsIHRoZXJlYnkKPiA+IGZhY2lsaXRh
dGluZyBydW4tdGltZSBjb21wdXRhdGlvbiBvZiB0aGUgcGh5c2ljYWwgbWVtb3J5IG9mZnNldC4K
PiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBSdXNzZWxsIEtpbmcgPHJtaytrZXJuZWxAYXJtLmxpbnV4
Lm9yZy51az4KPiA+IC0tLQo+ID4gwqBhcmNoL2FybS9pbmNsdWRlL2FzbS9tZW1vcnkuaCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgwqAgwqAyICsrCj4gPiDCoGFyY2gvYXJtL2tlcm5lbC90
Y20uYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgwqAgwqAyICstCj4g
Li4uCj4gPiDCoGFyY2gvYXJtL21hY2gtc2htb2JpbGUvaW5jbHVkZS9tYWNoL21lbW9yeS5oIMKg
IHwgwqAgwqAyICstCj4gCj4gQXBwbGllZCBvbiB0b3Agb2Ygc2gtMi42IGdpdCBjNDIyYTU5OTJl
OWNhMDcyZThlNDcyZWU4ZjUxODY0OWZiMDc0NzBlCj4gYW5kIHN1Y2Nlc3NmdWxseSBib290ZWQg
b24gYSBzaDczNzItYmFzZWQgTWFja2VyZWwgYm9hcmQuCj4gCj4gQWNrZWQtYnk6IE1hZ251cyBE
YW1tIDxkYW1tQG9wZW5zb3VyY2Uuc2U+CgpBY2tlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueUBh
dG9taWRlLmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
