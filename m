From: Bryan O'Donoghue <pure.logic-SyKdqv6vbfZdzvEItQ6vdLNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 01/33] clk_ops: change round_rate() to
 return unsigned long
Date: Sun, 31 Dec 2017 13:40:07 +0000
Message-ID: <6d83a5c3-6589-24bc-4ca5-4d1bbca47432@nexus-software.ie>
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
 <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
 <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3-/1wQRMveznE@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: uclinux-h8-devel-5NWGOfrQmneRv+LV9MX5uooqe+aC9MnS@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

T24gMzAvMTIvMTcgMTY6MzYsIE1pa2tvIFBlcnR0dW5lbiB3cm90ZToKPiBGV0lXLCB3ZSBoYWQg
dGhpcyBwcm9ibGVtIHNvbWUgeWVhcnMgYWdvIHdpdGggdGhlIFRlZ3JhIENQVSBjbG9jayAtIHRo
ZW4gCj4gaXQgd2FzIGRldGVybWluZWQgdGhhdCBhIHNpbXBsZXIgc29sdXRpb24gd2FzIHRvIGhh
dmUgdGhlIGRldGVybWluZV9yYXRlIAo+IGNhbGxiYWNrIHN1cHBvcnQgdW5zaWduZWQgbG9uZyBy
YXRlcyAtIHNvIGNsb2NrIGRyaXZlcnMgdGhhdCBuZWVkIHRvIAo+IHJldHVybiByYXRlcyBoaWdo
ZXIgdGhhbiAyXjMxIGNhbiBpbnN0ZWFkIGltcGxlbWVudCB0aGUgZGV0ZXJtaW5lX3JhdGUgCj4g
Y2FsbGJhY2suIFRoYXQgaXMgd2hhdCdzIGN1cnJlbnRseSBpbXBsZW1lbnRlZC4KPiAKPiBNaWtr
bwoKR3JhbnRlZCB3ZSBjb3VsZCB3b3JrIGFyb3VuZCBpdCBidXQsIGhhdmluZyBib3RoIHplcm8g
YW5kIGxlc3MgdGhhbiB6ZXJvIAppbmRpY2F0ZSBlcnJvciBtZWFucyB5b3UgY2FuJ3Qgc3VwcG9y
dCBsYXJnZXIgdGhhbiBMT05HX01BWCB3aGljaCBpcyBJIAp0aGluayB3b3J0aCBmaXhpbmcuCgot
LS0KYm9kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZy
ZWVkcmVubyBtYWlsaW5nIGxpc3QKRnJlZWRyZW5vQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ZyZWVkcmVubwo=
