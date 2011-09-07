From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
Date: Wed, 07 Sep 2011 05:32:32 -0700
Message-ID: <87sjo8ttwf.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
	<CAC83Zv+sX1G4saFsU=bOUYjedcM6eYEOCVMKqMZ-5pxkBc6x2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAC83Zv+sX1G4saFsU=bOUYjedcM6eYEOCVMKqMZ-5pxkBc6x2A@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Wed, 7 Sep 2011 10:34:43 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

IkRlYkJhcm1hLCBUYXJ1biBLYW50aSIgPHRhcnVuLmthbnRpQHRpLmNvbT4gd3JpdGVzOgoKPiBb
Li4uXQo+Pj4gKyDCoCDCoCAvKgo+Pj4gKyDCoCDCoCDCoCogSWYgdGhpcyBpcyB0aGUgZmlyc3Qg
Z3Bpb19yZXF1ZXN0IGZvciB0aGUgYmFuaywKPj4+ICsgwqAgwqAgwqAqIGVuYWJsZSB0aGUgYmFu
ayBtb2R1bGUuCj4+PiArIMKgIMKgIMKgKi8KPj4+ICsgwqAgwqAgaWYgKCFiYW5rLT5tb2RfdXNh
Z2UpCj4+PiArIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChJU19FUlJfVkFMVUUocG1fcnVudGltZV9n
ZXRfc3luYyhiYW5rLT5kZXYpIDwgMCkpIHsKPj4KPj4gQWxsIG9mIHRoZSBJU19FUlJfVkFMVUUo
KSB1c2FnZSBpcyB3cm9uZyBoZXJlLiDCoFlvdSdyZSBjaGVja2luZyBpZiB0aGUKPj4gcmVzdWx0
IG9mIElTX0VSUl9WQUxVRSgpIGlzIDwgMCB3aGljaCB3aWxsIG5ldmVyIGhhcHBlbi4KPiBOby4K
PiBJU19FUlJfVkFMVUUgaXMgYXBwbGllZCBvbiB0aGUgcmV0dXJuIHZhbHVlIG9mIHBtX3J1bnRp
bWVfZ2V0X3N5bmMKPiB3aGljaCBpcyA8ICAwLgoKLi4uYW5kIGlzIHN0aWxsIG5vdCBjb3JyZWN0
LgoKVGhlIHJlc3VsdCBvZiB0aGUgJzwgMCcgY2hlY2sgd2lsbCBiZSB6ZXJvIG9yIG9uZSwgc28g
SVNfRVJSX1ZBTFVFKCkKd2lsbCBuZXZlciBiZSB0cnVlLgoKS2V2aW4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
