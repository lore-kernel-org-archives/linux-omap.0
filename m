From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Mon, 27 Nov 2017 22:48:26 +0100
Message-ID: <d82fbab2-865f-3051-f487-d310ee819cf3@users.sourceforge.net>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <1511809633.32426.70.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1511809633.32426.70.camel@perches.com>
Content-Language: en-GB
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Joe Perches <joe@perches.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-omap@vger.kernel.org

PiBUaGVyZSBpcyB0aGUgZ2VuZXJpYyBzdGFjayBkdW1wIG9uIE9PTSBzbyB0aGUgbW9kdWxlL2xp
bmUKPiBpcyBhbHJlYWR5IGtub3duLgoKQ2FuIHN1Y2ggYW4gaW1wbGVtZW50YXRpb24gZGV0YWls
IGJlY29tZSBiZXR0ZXIgZG9jdW1lbnRlZAp0aGFuIGluIEMgc291cmNlIGNvZGU/CgoKPiBUaGUg
ZXhpc3RlbmNlIG9mIHRoZXNlIG1lc3NhZ2VzIGluY3JlYXNlcyBjb2RlIHNpemUgd2hpY2gKPiBh
bHNvIG1ha2UgdGhlIE9PTSBjb25kaXRpb24gc2xpZ2h0bHkgbW9yZSBsaWtlbHkuCgpJbnRlcmVz
dGluZyB2aWV3IOKApgoKCj4gTWFya3VzJyBjb21taXQgbWVzc2FnZXMgYXJlIGFsd2F5cyByZWFs
bHkgcG9vciBkZXNjcmlwdGlvbnMKPiBvZiB3aHkgdGhlc2UgcmVtb3ZhbHMgYXJlIHNvbWV3aGF0
IHVzZWZ1bCBhbmQgdGhlIGNvbW1pdAo+IGNvdWxkL3Nob3VsZC9taWdodCBiZSBhcHBsaWVkLgoK
SSBhZ3JlZSB0aGF0IHRoZXkgY291bGQgYmUgaW1wcm92ZWQgZm9yIHRoaXMgdHJhbnNmb3JtYXRp
b24KcGF0dGVybiBpZiBvdGhlciBpbmZvcm1hdGlvbiBzb3VyY2VzIHdvdWxkIGJlY29tZSBjbGVh
cmVyCmZvciBjb3JyZXNwb25kaW5nIHJlZmVyZW5jZXMuCkl0IHNlZW1zIHRoYXQgSSBnb3Qgbm8g
cmVzcG9uc2VzIHNvIGZhciBmb3IgY2xhcmlmaWNhdGlvbiByZXF1ZXN0cwphY2NvcmRpbmcgdG8g
dGhlIGRvY3VtZW50YXRpb24gaW4gYSBkaXJlY3Rpb24gSSBob3BlZCBmb3IuCgpSZWdhcmRzLApN
YXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJp
LWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
