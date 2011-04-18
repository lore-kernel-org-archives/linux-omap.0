From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 9/14] PM / Blackfin: Use struct syscore_ops instead of
	sysdevs for PM
Date: Sun, 17 Apr 2011 22:34:22 -0400
Message-ID: <BANLkTi=BRXtsG0wK6SbK-6L-xzwMccR3eQ@mail.gmail.com>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
	<201104172311.59289.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201104172311.59289.rjw@sisk.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

T24gU3VuLCBBcHIgMTcsIDIwMTEgYXQgMTc6MTEsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOgo+
IENvbnZlcnQgc29tZSBCbGFja2ZpbiBhcmNoaXRlY3R1cmUncyBjb2RlIHRvIHVzaW5nIHN0cnVj
dCBzeXNjb3JlX29wcwo+IG9iamVjdHMgZm9yIHBvd2VyIG1hbmFnZW1lbnQgaW5zdGVhZCBvZiBz
eXNkZXYgY2xhc3NlcyBhbmQgc3lzZGV2cy4KPgo+IFRoaXMgc2ltcGxpZmllcyB0aGUgY29kZSBh
bmQgcmVkdWNlcyB0aGUga2VybmVsJ3MgbWVtb3J5IGZvb3RwcmludC4KPiBJdCBhbHNvIGlzIG5l
Y2Vzc2FyeSBmb3IgcmVtb3Zpbmcgc3lzZGV2cyBmcm9tIHRoZSBrZXJuZWwgZW50aXJlbHkgaW4K
PiB0aGUgZnV0dXJlLgoKbG9va3Mgc3RyYWlnaHQgZm9yd2FyZCBlbm91Z2ggLi4uCkFja2VkLWJ5
OiBNaWtlIEZyeXNpbmdlciA8dmFwaWVyQGdlbnRvby5vcmc+Cgo+ICtzdGF0aWMgc3RydWN0IHN5
c2NvcmVfb3BzIG5taV9zeXNjb3JlX29wcyA9IHsKPiDCoCDCoCDCoCDCoC5yZXN1bWUgwqAgwqAg
wqAgwqAgPSBubWlfd2R0X3Jlc3VtZSwKPiDCoCDCoCDCoCDCoC5zdXNwZW5kIMKgIMKgIMKgIMKg
PSBubWlfd2R0X3N1c3BlbmQsCj4gwqB9OwoKYSBiaXQgc2FkIHRoaXMgY291bGRudCBiZSBtYWRl
IGNvbnN0Ci1taWtlCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
