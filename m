From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 3/7] mtd: onenand: omap2: Remove skip initial unlocking
 support
Date: Fri, 10 Nov 2017 10:18:14 +0200
Message-ID: <22a95dc4-6d93-7ea0-2593-83c1aa02cd7b@ti.com>
References: <20171109091155.6a6azfvjarwvlfh2@lenoch>
 <20171109091407.z4jr2kgdubhd4dpw@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171109091407.z4jr2kgdubhd4dpw@lenoch>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-omap@vger.kernel.org

77u/ClRleGFzIEluc3RydW1lbnRzIEZpbmxhbmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgw
IEhlbHNpbmtpLiBZLXR1bm51cy9CdXNpbmVzcyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0Rv
bWljaWxlOiBIZWxzaW5raQoKT24gMDkvMTEvMTcgMTE6MTQsIExhZGlzbGF2IE1pY2hsIHdyb3Rl
Ogo+IE5vIHBsYXRmb3JtIGRhdGEgdXNlciBzZXRzIHNraXBfaW5pdGlhbF91bmxvY2tpbmcsIHNv
IHJlbW92ZSB0ZXN0Cj4gZm9yIHRoaXMgZmllbGQuCj4gCj4gU2lnbmVkLW9mZi1ieTogTGFkaXNs
YXYgTWljaGwgPGxhZGlzQGxpbnV4LW1pcHMub3JnPgo+IC0tLQo+ICBDaGFuZ2VzOgo+ICAtdjI6
IG5ldyBwYXRjaAo+ICAtdjM6IG5vbmUKPiAKPiAgZHJpdmVycy9tdGQvb25lbmFuZC9vbWFwMi5j
IHwgMyAtLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL29uZW5hbmQvb21hcDIuYyBiL2RyaXZlcnMvbXRkL29uZW5hbmQvb21h
cDIuYwo+IGluZGV4IGEwM2UxZmU0YWE0OC4uOTNiZDk0MzM3YjM1IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvbXRkL29uZW5hbmQvb21hcDIuYwo+ICsrKyBiL2RyaXZlcnMvbXRkL29uZW5hbmQvb21h
cDIuYwo+IEBAIC03MDAsOSArNzAwLDYgQEAgc3RhdGljIGludCBvbWFwMl9vbmVuYW5kX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gIAkJfQo+ICAJfQo+ICAKPiAtCWlmIChw
ZGF0YS0+c2tpcF9pbml0aWFsX3VubG9ja2luZykKPiAtCQl0aGlzLT5vcHRpb25zIHw9IE9ORU5B
TkRfU0tJUF9JTklUSUFMX1VOTE9DS0lORzsKPiAtCj4gIAlpZiAoKHIgPSBvbmVuYW5kX3NjYW4o
JmMtPm10ZCwgMSkpIDwgMCkKPiAgCQlnb3RvIGVycl9yZWxlYXNlX2RtYTsKPiAgCj4gCgpMZXQn
cyBnZXQgcmlkIG9mICdza2lwX2luaXRpYWxfdW5sb2NraW5nJyBmcm9tIHBsYXRmb3JtX2RhdGEg
YXMgd2VsbC4KCi0tIApjaGVlcnMsCi1yb2dlcgoKVGV4YXMgSW5zdHJ1bWVudHMgRmlubGFuZCBP
eSwgUG9ya2thbGFua2F0dSAyMiwgMDAxODAgSGVsc2lua2kuIFktdHVubnVzL0J1c2luZXNzIElE
OiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4IE1URCBkaXNj
dXNzaW9uIG1haWxpbmcgbGlzdApodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW10ZC8K
