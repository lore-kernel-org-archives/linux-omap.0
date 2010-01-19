From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] [PATCH] watchdog_info separation and
	constify
Date: Tue, 19 Jan 2010 16:52:21 -0500
Message-ID: <8bd0f97a1001191352n4968bebep2342912c571595fa@mail.gmail.com>
References: <20100119211759.GE3804@infomag.iguana.be>
	<1263937351.18117.69.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1263937351.18117.69.camel-AkRN8/LKpobuYGix6ZUp1Q@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

T24gVHVlLCBKYW4gMTksIDIwMTAgYXQgMTY6NDIsIEpvZSBQZXJjaGVzIHdyb3RlOgo+IE9uIFR1
ZSwgMjAxMC0wMS0xOSBhdCAyMjoxNyArMDEwMCwgV2ltIFZhbiBTZWJyb2VjayB3cm90ZToKPj4g
LXN0YXRpYyBzdHJ1Y3Qgd2F0Y2hkb2dfaW5mbyBhdDMyX3dkdF9pbmZvID0gewo+PiArc3RhdGlj
IGNvbnN0IHN0cnVjdCB3YXRjaGRvZ19pbmZvIGF0MzJfd2R0X2luZm8gPSB7Cj4KPiBJdCdkIGJl
IGdvb2QgdG8gdXNlIGEgY29uc2lzdGVudCBzdHJ1Y3R1cmUgbmFtZToKPgo+IHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgd2F0Y2hkb2dfaW5mbyBpZGVudCA9IHsKPiDCoCDCoCDCoCDCoGV0Yy4uLgo+IH0K
CmknZCBhZ3JlZSAob2J2aW91c2x5IGknbSBwYXJ0aWFsIHRvIHRoZSAieHh4X3dkdF9pbmZvIiBm
b3JtKSwgYnV0IGknZAp3b3JyeSBhYm91dCB0aGlzIGFmdGVyIHRoZSB3YXRjaGRvZyBpbXBsZW1l
bnRhdGlvbnMgYXJlIGZpbmFsbHkKdW5pZmllZCAuLi4gbWlnaHQgYmUgbGVzcyBjb2RlIG5lZWRp
bmcgc3RhbmRhcmRpemF0aW9uIGF0IHRoYXQgcG9pbnQKLW1pa2UKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVWNsaW51eC1kaXN0LWRldmVsIG1haWxpbmcg
bGlzdApVY2xpbnV4LWRpc3QtZGV2ZWxAYmxhY2tmaW4udWNsaW51eC5vcmcKaHR0cHM6Ly9ibGFj
a2Zpbi51Y2xpbnV4Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3VjbGludXgtZGlzdC1kZXZlbA==
