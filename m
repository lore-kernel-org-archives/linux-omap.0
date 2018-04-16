From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.16 OMAP serial transmit corruption?
Date: Mon, 16 Apr 2018 08:45:45 -0700
Message-ID: <20180416154545.GA5671@atomide.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180416151732.GU16141@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

KiBSdXNzZWxsIEtpbmcgLSBBUk0gTGludXggPGxpbnV4QGFybWxpbnV4Lm9yZy51az4gWzE4MDQx
NiAxNToxOV06Cj4gSGksCj4gCj4gSSdtIG5vdCBlbnRpcmVseSBzdXJlIHdoYXQncyBnb2luZyBv
biwgYnV0IEkgc2VlIGNvcnJ1cHRlZCBjaGFyYWN0ZXJzCj4gd2l0aCB0aGUgc2VyaWFsIGNvbnNv
bGUgb24gdGhlIE9NQVA0NDMwIFNEUCBib2FyZC4gIER1cmluZyBib290LAo+IGV2ZXJ5dGhpbmcg
c2VlbXMgZmluZSwgdGhlIHByb2JsZW0gYXBwZWFycyB0byBiZSB1c2Vyc3BhY2Ugb3V0cHV0Lgo+
IAo+IEZvciBleGFtcGxlLCBpZiBJIGVkaXQgYSBmaWxlLCB0aGVuIHF1aXQgdmk6Cj4gCj4gOnHi
lqDilqAl4pag4pagQuKWoOKWoFrilqByb290QG9tYXAtNDQzMHNkcDp+IwoKSSBkb24ndCB0aGlu
ayBJJ3ZlIHNlZW4gdGhhdCBvbmUuIFdoYXQgSSd2ZSBzZWVuIGZldyB0aW1lcyBpcwp0eXBpbmcg
YSBrZXkgb24gdGhlIHNlcmlhbCBjb25zb2xlIGVjaG9pbmcgYmFjayB0aGUgcHJldmlvdXMKY2hh
cmFjdGVyIHR5cGVkIHdoaWxlIHRoZSBuZXcgY2hhcmFjdGVyIHdvbid0IGdldCBkaXNwbGF5ZWQK
dW50aWwgaGl0dGluZyBrZXlib2FyZCBhZ2Fpbi4gT25seSByZWJvb3RpbmcgdGhlIGRldmljZSBz
ZWVtcwp0byBzb2x2ZSB0aGlzLiBUaGlzIGlzIHdpdGggNDQzMCBFUzIuMyByZXZpc2lvbi4KCkkg
d29uZGVyIGlmIHdlJ3JlIG1pc3Npbmcgc29tZSBwYXJ0cyBvZiBlcnJhdGEgaTIwMiBoYW5kbGlu
ZwppbiBvbWFwXzgyNTBfbWRyMV9lcnJhdGFzZXQoKT8KCkFsc28sIEknbSBzZWVpbmcgYW4gaXNz
dWUgd2hlcmUgdGhlIFVBUlRzIHdvbid0IGlkbGUgb24gaW5pdAp3aXRoIDgyNTBfb21hcCBkcml2
ZXIgaWYgY29ubmVjdGVkIHRvIHRoZSB3bDEyeHggYmx1ZXRvb3RoIHBvcnQKdW5sZXNzIEkgd3Jp
dGUgc29tZSBkYXRhIHRvIHRoZSBwb3J0IGZpcnN0LiBJdCBkb2VzIG5vdCBzZWVtCnRvIGJlIHJl
bGF0ZWQgdG8gdGhlIHJ0cy9jdHMgbGluZXMgYmVpbmcgd2lyZWQgYXMgSSd2ZSB0ZXN0ZWQKbXV4
aW5nIHRoZW0gb3V0IG9mIHRoZSB3YXkuCgpSZWdhcmRzLAoKVG9ueQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
