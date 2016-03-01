From: Jyri Sarha <jsarha@ti.com>
Subject: Alternative binding proposal for tda998x audio (Was: Re: [PATCH RFC
 v5 4/8] drm/i2c: tda998x: Add support of a DT graph of ports)
Date: Tue, 1 Mar 2016 16:26:50 +0200
Message-ID: <56D5A6AA.2030907@ti.com>
References: <cover.1455720381.git.jsarha@ti.com>
 <842e221030a0b14bc862790eb2f5bc97bb29c012.1455720381.git.jsarha@ti.com>
 <20160218143530.GB9654@rob-hp-laptop> <56CF04DA.8080905@ti.com>
 <20160226004311.GM5783@n2100.arm.linux.org.uk> <56D02594.4020407@ti.com>
 <20160226112159.GO5783@n2100.arm.linux.org.uk> <56D41F1A.2030100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <56D41F1A.2030100@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, devicetree@vger.kernel.org, tomi.valkeinen@ti.com, arnaud.pouliquen@st.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

T2ssIGhlcmUgaXMganVzdCBvbmUgbW9yZSBzaW1wbGUgYWx0ZXJuYXRpdmUgZm9yIHRkYTk5OHgg
YXVkaW8gYmluZGluZy4gCkkgZmVlbCB0aGF0IHRoZSBncmFwaCBwb3J0cyBiaW5kaW5nIGZvciBh
dWRpbyBkb2VzIG5vdCBtYWtlIHNlbnNlIAp3aXRob3V0IGEgZ3JhcGggYmFzZWQgQVNvQyBtYWNo
aW5lIGRyaXZlciBpbXBsZW1lbnRhdGlvbi4gVGhlIEFTb0MgCnNpbXBsZS1jYXJkIGlzIGFscmVh
ZHkgaGVyZSBhbmQgaXQgc28gd2lkZWx5IHVzZWQgdGhhdCB0aGVyZSBpcyBubyAKZ2V0dGluZyBy
aWQgb2YgdGhhdCBhbnkgdGltZSBzb29uLiBUaGlzIHByb3Bvc2FsIHByb3ZpZGVzIHRoZSBzYW1l
IApmdW5jdGlvbmFsaXR5IGFzIHRoZSBwYXRjaCBpbiB0aGUgcm9vdCBvZiB0aGlzIHRocmVhZCwg
YnV0IGluIGEgc2ltcGxlciAKd2F5IGFuZCBpcyBlcXVhbGx5IGNvbXBhdGlibGUgd2l0aCBzaW1w
bGUtY2FyZC4KClRoZSBleGFtcGxlIGFzc3VtZXMgYSBkdC1pbmNsdWRlIGZpbGUgd2l0aCBpbnRl
Z2VyIGRlZmluaXRpb25zIGZvciAKVERBOTk4eF9TUERJRiBhbmQgVERBOTk4eF9JMlMuCgoKCXRk
YTE5OTg4IHsKCQljb21wYXRpYmxlID0gIm54cCx0ZGE5OTh4IjsKCQlyZWcgPSA8MHg3MD47CgkJ
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IiwgIm9mZiI7CgkJcGluY3RybC0wID0gPCZueHBfaGRt
aV9ib25lbHRfcGlucz47CgkJcGluY3RybC0xID0gPCZueHBfaGRtaV9ib25lbHRfb2ZmX3BpbnM+
OwoJCXZpZGVvLXBvcnRzID0gPDB4MjMwMTQ1PjsKCgkJLyogUmVxdWlyZWQgYnkgc2ltcGxlLWNh
cmQuIFRoZSBudW1iZXIgb2Ygc291bmQtZGFpCgkJICAgY2VsbHMgbXVzdCBhZ3JlZSB3aXRoIHRo
ZSBudW1iZXIgb2YgYXVkaW8gcG9ydHMKCQkgICBkZXNjcmliZWQgaW4gYXVkaW8tcG9ydHMgcHJv
cGVydHkuICovCgkJI3NvdW5kLWRhaS1jZWxscyA9IDwyPjsKCgkJCSAgICAgLyoJREFJLWZvcm1h
dAlBUF9FTkEgcmVnIHZhbHVlICovCgkJYXVkaW8tcG9ydHMgPSA8CVREQTk5OHhfU1BESUYJMHgw
NAoJCQkJVERBOTk4eF9JMlMJMHgwMz47CgoJCXBvcnQgewoJCQloZG1pXzA6IGVuZHBvaW50QDAg
ewoJCQkJcmVtb3RlLWVuZHBvaW50ID0gPCZsY2RjXzA+OwoJCQl9OwoJCX07Cgl9OwoKUnVzc2Vs
bCwgUm9iPyBXaGljaCBvbmUgd291bGQgeW91IHByZWZlciwgdGhlIG9sZCBncmFwaCBwb3J0cyBi
aW5kaW5nIG9yIAp0aGlzIHNpbXBsZXIgdmVyc2lvbj8KCkJlc3QgcmVnYXJkcywKSnlyaQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
