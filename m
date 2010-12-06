From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work
	with CONFIG_THUMB2_KERNEL
Date: Mon, 6 Dec 2010 18:17:05 +0000
Message-ID: <AANLkTi=OhchW6rqMmTP5dpUF7aKwy9iArETaHdwi5cjN@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1291656937-24992-2-git-send-email-dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

T24gNiBEZWNlbWJlciAyMDEwIDE3OjM1LCBEYXZlIE1hcnRpbiA8ZGF2ZS5tYXJ0aW5AbGluYXJv
Lm9yZz4gd3JvdGU6Cj4gwqAqIEV4cGxpY2l0bHkgYnVpbGQgYSBmZXcgcGFydHMgb2Ygc2xlZXAz
NHh4LlMgYXMgQVJNLgo+Cj4gwqAgwqAgwqAqIGxvY2tfc2NyYXRjaHBhZF9zZW0gaXMga2VwdCBh
cyBBUk0gYmVjYXVzZSBvZiB0aGUgbmVlZCB0bwo+IMKgIMKgIMKgIMKgc3luY2hyb25pc2Ugd2l0
aCBoYXJkd2FyZSAoPykgdXNpbmcgdGhlIFNXUCBpbnN0cnVjdGlvbi4KPgo+IMKgIMKgIMKgKiBz
YXZlX3NlY3VyZV9yYW1fY29udGV4dCBhbmQgb21hcDM0eHhfY3B1X3N1c3BlbmQgYXJlIGJ1aWx0
Cj4gwqAgwqAgwqAgwqBhcyBBUk0gaW4gY2FzZSB0aGUgU2VjdXJlIFdvcmxkIGZpcm13YXJlIGV4
cGVjdHMgdG8gZGVjb2RlCj4gwqAgwqAgwqAgwqB0aGUgY29tbWVudCBmaWVsZCBmcm9tIHRoZSBT
TUMgKGFrYSBzbWkpIGluc3RydWN0aW9ucy4KPgo+IMKgIMKgIMKgIMKgVGhpcyBjYW4gYmUgdW5k
b25lIGxhdGVyIGlmIHRoZSBmaXJtd2FyZSBpcyBjb25maXJtZWQgYXMKPiDCoCDCoCDCoCDCoGFi
bGUgdG8gZGVjb2RlIHRoZSBUaHVtYiBTTUMgZW5jb2RpbmcgKG9yIGlnbm9yZXMgdGhlCj4gwqAg
wqAgwqAgwqBjb21tZW50IGZpZWxkKS4KPgo+IMKgIMKgIMKgKiBlczNfc2RyY19maXggc2hvdWxk
IHByZXN1bWFibHkgb25seSBiZSBjYWxsZWQgZnJvbSB0aGUKPiDCoCDCoCDCoCDCoGxvdy1sZXZl
bCB3YWtldXAgY29kZS4gwqBUbyBtaW5pbWlzZSB0aGUgZGlmZiwgc3dpdGNoZWQgdGhpcwo+IMKg
IMKgIMKgIMKgdG8gQVJNIGFuZCBkZW1vdGVkIGl0IHRvIGJlIGEgbG9jYWwgc3ltYm9sLCBzaW5j
ZSBJIGJlbGlldmUKPiDCoCDCoCDCoCDCoGl0IHNob3VsZG4ndCBiZSBjYWxsZWQgZnJvbSBvdXRz
aWRlIGFueXdheS4KCkkgaGF2ZW4ndCBjaGVja2VkIHRoZSBjb2RlIGJ1dCBkb2VzIHRoaXMgYWx3
YXlzIHdvcms/IFRoZSBrZXJuZWwgaXNuJ3QKYnVpbHQgd2l0aCBpbnRlcndvcmtpbmcgZW5hYmxl
ZCwgc28gaXQncyBlaXRoZXIgQVJNIG9yIFRodW1iLTIuCgotLSAKQ2F0YWxpbgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGluYXJvLWRldiBtYWlsaW5n
IGxpc3QKbGluYXJvLWRldkBsaXN0cy5saW5hcm8ub3JnCmh0dHA6Ly9saXN0cy5saW5hcm8ub3Jn
L21haWxtYW4vbGlzdGluZm8vbGluYXJvLWRldgo=
