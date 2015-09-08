From: Grazvydas Ignotas <notasas@gmail.com>
Subject: mysterious crashes on OMAP5 uevm
Date: Tue, 8 Sep 2015 14:46:48 +0200
Message-ID: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

SGksCgp0aGlzIGlzIGEgbG9uZ3N0YW5kaW5nIHByb2JsZW0gSSdtIHNlZWluZyBzaW5jZSB0aGUg
dmVyeSBiZWdpbm5pbmcsCndoaWNoIHdhcyBhcm91bmQgMy4xMiBvciBzbyAod2hlbiBJJ3ZlIGZp
cnN0IGdvdCB0aGUgaGFyZHdhcmUpIGFuZCBpdApzZWVtcyA0LjIgaXMgYWZmZWN0ZWQgYnkgaXQg
c3RpbGwuIEJhc2ljYWxseSB3aGF0IGhhcHBlbnMgaXMgWG9yZwpyYW5kb21seSBzZWdmYXVsdHMg
YXQgc29tZSAiaW1wb3NzaWJsZSIgbG9jYXRpb24uIEkgZG9uJ3QgaGF2ZSB0aGUKZGV0YWlscyBh
dCB0aGUgbW9tZW50IChjb3VsZCBnZXQgdGhlbSBpcyBuZWVkZWQpLCBidXQgZnJvbSB3aGF0IEkK
ZXhhbWluZWQgd2l0aCBnZGIgc29tZSB0aW1lIGFnbyB0aGUgc2l0dWF0aW9uIGRpZCBub3QgbWFr
ZSBhbnkgc2Vuc2UuCgpUaGVyZSBhcmUgMiB3b3JrYXJvdW5kcyB0aGF0IEkga25vdyB3aGljaCBt
YWtlIHRoZSBwcm9ibGVtIGdvIGF3YXkKKG9uZSBpcyBlbm91Z2gpOgotIHJlY29tcGlsZSBYb3Jn
IHdpdGggLW1hcm0gKEknbSB1c2luZyBEZWJpYW4gYXJtaGYgc28gaXQncyB0aHVtYjIgYnkgZGVm
YXVsdCkKLSBkaXNhYmxlIEFSQ0hfTVVMVElfVjYgaW4gdGhlIGtlcm5lbCBjb25maWcKCkJlY2F1
c2Ugb2YgdGhlIGFib3ZlIHdvcmthcm91bmRzIEkgaGF2ZSBmb3Jnb3R0ZW4gYWJvdXQgaXQgc2V2
ZXJhbAp0aW1lcywgYnV0IGl0IHJlZ3VsYXJseSBjb21lcyBiYWNrIGFuZCBiaXRlcyBhZ2Fpbi4g
SXQgd291bGQgbG9vayBsaWtlCnNvbWUgbWlzc2luZyBlcnJhdHVtIHdvcmthcm91bmQsIGJ1dCBJ
IGhhdmUgYWxsIG9mIHRoZW0gZW5hYmxlZCBpbiB0aGUKa2VybmVsLgoKRG9lcyBhbnlvbmUga25v
dyBhYm91dCB0aGlzPyBQZXJoYXBzIHNvbWUgbWlzc2luZyBlcnJhdHVtIHdvcmthcm91bmQKaW4g
dGhlIGJvb3Rsb2FkZXI/IHUtYm9vdCBpc24ndCB0b28gb2xkIGhlcmUgKDIwMTUuMDcpLgoKR3Jh
xb52eWRhcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
