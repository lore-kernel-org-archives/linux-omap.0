From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for build
 break because of clktrctrl_mask
Date: Fri, 7 Jan 2011 14:10:50 +0530
Message-ID: <3f76fc53e9b50d75480bcfe1d2b6312e@mail.gmail.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com><87fwt7z1p3.fsf@ti.com><alpine.DEB.2.00.1101061059590.22048@utopia.booyaka.com>
 <87ipy1vqdi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517478c1086211304993d93fe
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:48020 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753703Ab1AGIk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 03:40:56 -0500
Received: by eyf5 with SMTP id 5so6951042eyf.29
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 00:40:54 -0800 (PST)
In-Reply-To: <87ipy1vqdi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

--001517478c1086211304993d93fe
Content-Type: text/plain; charset=ISO-8859-1

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Thursday, January 06, 2011 11:58 PM
> To: Paul Walmsley
> Cc: Santosh Shilimkar; linux-omap@vger.kernel.org; tony@atomide.com;
linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 1/5] omap2plus: clockdomain: Trivial fix for
build break because of clktrctrl_mask
>
> Paul Walmsley <paul@pwsan.com> writes:
>
> > On Wed, 5 Jan 2011, Kevin Hilman wrote:
> >
> >> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> >>
> >> > struct clockdomain member clktrctrl_mask is available for only for
OMAP2
> >> > and OMAP3 architectures. Technially it is also used only for these
archs
> >> > but this breaks the build with custom OMAP4 configuration.
> >>
> >> I'll queue patches 3-5 for the 2.6.38-rc fixes cycle.
> >>
> >> With Paul's ack, I can queue the others too, or Paul can decide to
take
> >> them via his tree.  Paul can decide.
> >
> > I've acked one and requested minor changes on the other, after which
it
> > can be acked by me.  You're welcome to take them at that point.  Just
a
> > request, maybe you can post a branch with just these patches in them;
that
> > way Rajendra and/or I can rebase his new clockdomain changes on it
until
> > -rc1 comes out.
>
> Sure, will do.

Just another trivial fix.

>From bb46b74d2b0ab3d35e72b760da7e123a891e6813 Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Fri, 7 Jan 2011 14:07:25 +0530
Subject: [PATCH] OMAP: powerdomain: remove unused func declaration

Trivial fix to remove the unused function declaration
from the powerdomain header.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomain.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.h
b/arch/arm/mach-omap2/powerdomain.h
index c66431e..0b7a357 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -165,7 +165,6 @@ struct pwrdm_ops {
 	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
 };

-void pwrdm_fw_init(void);
 void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_ops
*custom_funcs);

 struct powerdomain *pwrdm_lookup(const char *name);
-- 
1.7.0.4

>
> I currently have a 'fixes-for-tony' branch in my tree which has all the
> fixes I've collected for the -rc cycle.
>
> If you prefer something separate with only the prm and clockdomain
> patches from this series, I can do that as well.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--001517478c1086211304993d93fe
Content-Type: application/octet-stream;
	name="0001-OMAP-powerdomain-remove-unused-func-declaration.patch"
Content-Disposition: attachment;
	filename="0001-OMAP-powerdomain-remove-unused-func-declaration.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 98bf8ae8cb917994_0.1

RnJvbSBiYjQ2Yjc0ZDJiMGFiM2QzNWU3MmI3NjBkYTdlMTIzYTg5MWU2ODEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWplbmRyYSBOYXlhayA8cm5heWFrQHRpLmNvbT4KRGF0ZTog
RnJpLCA3IEphbiAyMDExIDE0OjA3OjI1ICswNTMwClN1YmplY3Q6IFtQQVRDSF0gT01BUDogcG93
ZXJkb21haW46IHJlbW92ZSB1bnVzZWQgZnVuYyBkZWNsYXJhdGlvbgoKVHJpdmlhbCBmaXggdG8g
cmVtb3ZlIHRoZSB1bnVzZWQgZnVuY3Rpb24gZGVjbGFyYXRpb24KZnJvbSB0aGUgcG93ZXJkb21h
aW4gaGVhZGVyLgoKU2lnbmVkLW9mZi1ieTogUmFqZW5kcmEgTmF5YWsgPHJuYXlha0B0aS5jb20+
Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9wb3dlcmRvbWFpbi5oIHwgICAgMSAtCiAxIGZpbGVz
IGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9h
cmNoL2FybS9tYWNoLW9tYXAyL3Bvd2VyZG9tYWluLmggYi9hcmNoL2FybS9tYWNoLW9tYXAyL3Bv
d2VyZG9tYWluLmgKaW5kZXggYzY2NDMxZS4uMGI3YTM1NyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9wb3dlcmRvbWFpbi5oCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvcG93ZXJk
b21haW4uaApAQCAtMTY1LDcgKzE2NSw2IEBAIHN0cnVjdCBwd3JkbV9vcHMgewogCWludAkoKnB3
cmRtX3dhaXRfdHJhbnNpdGlvbikoc3RydWN0IHBvd2VyZG9tYWluICpwd3JkbSk7CiB9OwogCi12
b2lkIHB3cmRtX2Z3X2luaXQodm9pZCk7CiB2b2lkIHB3cmRtX2luaXQoc3RydWN0IHBvd2VyZG9t
YWluICoqcHdyZG1fbGlzdCwgc3RydWN0IHB3cmRtX29wcyAqY3VzdG9tX2Z1bmNzKTsKIAogc3Ry
dWN0IHBvd2VyZG9tYWluICpwd3JkbV9sb29rdXAoY29uc3QgY2hhciAqbmFtZSk7Ci0tIAoxLjcu
MC40Cgo=
--001517478c1086211304993d93fe--
