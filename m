From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH net-next 1/3] net: ethernet: support of_get_mac_address
 new ERR_PTR error
Date: Mon, 6 May 2019 18:07:13 +0300
Message-ID: <20190506150713.GH2269@kadam>
References: <1557136717-531-1-git-send-email-ynezz@true.cz>
 <1557136717-531-2-git-send-email-ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1557136717-531-2-git-send-email-ynezz@true.cz>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: Andrew Lunn <andrew@lunn.ch>, Thor Thayer <thor.thayer@linux.intel.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Andreas Larsson <andreas@gaisler.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pantelis Antoniou <pantelis.antoniou@gmail.com>, Byungho An <bh74.an@samsung.com>, Frank Rowand <frowand.list@gmail.com>, John Linn <John.Linn@xilinx.com>, Alexandre Torgue <alexandre.torgue@st.com>, Vipul Pandya <vipul.pandya@samsung.com>, linux-renesas-soc@vger.kernel.org, Felix Fietkau <nbd@openwrt.org>, Florian Fainelli <f.fainelli@gmail.com>, Madalin Bucur <madalin.bucur@nxp.com>, Michal Simek <michal.simek@xilinx.com>, linux-stm32@st-md-mailman.stormreply.com, Chen-Yu Tsai <wens@csie.org>, Jose Abreu <joabreu@synopsys.com>, bcm-kernel-feedback-list@broadcom.com, Sylvain Lemieux <slemieux.tyco@gmail.com>, Sunil
List-Id: linux-omap@vger.kernel.org

T24gTW9uLCBNYXkgMDYsIDIwMTkgYXQgMTE6NTg6MzVBTSArMDIwMCwgUGV0ciDFoHRldGlhciB3
cm90ZToKPiBUaGVyZSB3YXMgTlZNRU0gc3VwcG9ydCBhZGRlZCB0byBvZl9nZXRfbWFjX2FkZHJl
c3MsIHNvIGl0IGNvdWxkIG5vdyByZXR1cm4KPiBFUlJfUFRSIGVuY29kZWQgZXJyb3IgdmFsdWVz
LCBzbyB3ZSBuZWVkIHRvIGFkanVzdCBhbGwgY3VycmVudCB1c2VycyBvZgo+IG9mX2dldF9tYWNf
YWRkcmVzcyB0byB0aGlzIG5ldyBmYWN0LgoKV2UgbmVlZCBhIEZpeGVzIHRhZyBzbyB3ZSBjYW4g
bG9vayBhdCB0aGUgY29tbWl0IHdoaWNoIGFkZHMgTlZNRU0Kc3VwcG9ydC4KCkl0J3Mgbm90IGNs
ZWFyIHRvIG1lIHRoYXQgYW55b25lIGV2ZXIgYXBwbGllZCB0aGF0IHBhdGNoLiAgSWYgbm90IHRo
ZW4Kd2hvIGhvbyEgIExldCdzIG5vdCBhcHBseSBpdC4gIEJ1dCBpZiBpdCBoYXMgYmVlbiBjb21t
aXR0ZWQgdGhlbiBpdCBoYXMKYSBnaXQgaGFzaC4KCnJlZ2FyZHMsCmRhbiBjYXJwZW50ZXIKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRldmVsQGxpbnV4ZHJpdmVycHJvamVjdC5vcmcKaHR0cDovL2RyaXZlcmRldi5saW51
eGRyaXZlcnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vZHJpdmVyZGV2LWRldmVsCg==
