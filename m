From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v11 2/4] PM / Domains: add setter for dev.pm_domain
Date: Fri, 08 Jan 2016 01:20:08 +0100
Message-ID: <1638223.v1Ed2MLOOC@vostro.rjw.lan>
References: <1445956731-6304-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAGS+omBMJXOgsd2x9agtt7yi-y+EPgHWSTr7B3JqbN9Hg_2W5A@mail.gmail.com>
 <CAAObsKC1jTzLWmMtwGWVStuMtzZwvMuA_731dsn4YX7aKMtFKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAAObsKC1jTzLWmMtwGWVStuMtzZwvMuA_731dsn4YX7aKMtFKQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, dri-devel <dri-devel@lists.freedesktop.org>, Pavel Machek <pavel@ucw.cz>, Tomas Winkler <tomas.winkler@intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-omap@vger.kernel.org

T24gVGh1cnNkYXksIEphbnVhcnkgMDcsIDIwMTYgMDM6NDc6MDEgUE0gVG9tZXUgVml6b3NvIHdy
b3RlOgo+IE9uIDEwIE5vdmVtYmVyIDIwMTUgYXQgMTA6MzMsIERhbmllbCBLdXJ0eiA8ZGprdXJ0
ekBjaHJvbWl1bS5vcmc+IHdyb3RlOgo+IFtzbmlwXQo+ID4KPiA+IFRoZSBwcm9ibGVtIGFwcGVh
cnMgdG8gYmUgdGhhdDoKPiA+ICAgKiBPbiBib290LCBwbGF0Zm9ybV9kcnZfcHJvYmUoKSBjYWxs
cyBkZXZfcG1fZG9tYWluX2F0dGFjaCgpIGJlZm9yZQo+ID4gZHJ2LT5wcm9iZSgpOyB0aHVzLCBp
dCBjYWxscyBkZXZfcG1fZG9tYWluX2F0dGFjaCgpIHdoaWxlIHRoZSBkZXZpY2UKPiA+IGlzIHVu
Ym91bmQuCj4gPgo+ID4gICogSG93ZXZlciwgZm9yIGEgcGxhdGZvcm1fZGV2aWNlLCB0aGUgcmVi
b290IHBhdGggY2FsbHMKPiA+IGRldmljZV9zaHV0ZG93bigpLCBidXQgbm90IF9fZGV2aWNlX3Jl
bGVhc2VfZHJpdmVyKCk6Cj4gPiBkZXZpY2Vfc2h1dGRvd24oKQo+ID4gICBkZXYtPmRyaXZlci0+
c2h1dGRvd24gPT4gcGxhdGZvcm1fZHJ2X3NodXRkb3duKCkKPiA+ICAgICBkZXZfcG1fZG9tYWlu
X2RldGFjaCgpCj4gPiAgICAgICAgZGV2LT5wbV9kb21haW4tPmRldGFjaCgpID0+IGdlbnBkX2Rl
dl9wbV9kZXRhY2goKQo+ID4gICAgICAgICAgcG1fZ2VucGRfcmVtb3ZlX2RldmljZSgpCj4gPiAg
ICAgICAgICAgICBkZXZfcG1fZG9tYWluX3NldChkZXYsIE5VTEwpOwo+ID4KPiA+IFNvLCBmb3Ig
YSBwbGF0Zm9ybV9kZXZpY2UgaW4gYSBnZW5wZCBwb3dlciBkb21haW4gd2l0aCAuc2h1dGRvd24K
PiA+IGluc3RhbGxlZCwgcGxhdGZvcm1fZHJ2X3NodXRkb3duKCkgY2FsbHMgZGV2X3BtX2RvbWFp
bl9kZXRhY2goKSB3aGlsZQo+ID4gdGhlIGRldmljZSBpcyBzdGlsbCBib3VuZCwgd2hpY2ggdHJp
Z2dlcnMgdGhlIFdBUk4oKS4KPiAKPiBIaSBSYWZhZWwsIEFsYW4gYW5kIFVsZiwKPiAKPiBkbyB5
b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbiBhYm91dCB0aGlzPyBJIGRvbid0IHJlYWxseSB1bmRlcnN0
YW5kIHdoeQo+IHRoZSBkZXZpY2UgaXMgZGV0YWNoZWQgZnJvbSB0aGUgZG9tYWluIG9uIHNodXRk
b3duLgoKV2VsbCwgdGhpcyBsb29rcyBsaWtlIGEgYnVnIHRvIG1lLgoKVGhhbmtzLApSYWZhZWwK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
