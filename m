From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: Old DSS code broken as module (was "RE: [PATCH 11/11]
 omap2/3/4: Disable CONFIG_FB_OMAP in omap3_defconfig")
Date: Wed, 5 May 2010 13:23:46 -0500
Message-ID: <A24693684029E5489D1D202277BE894455257A6A@dlee02.ent.ti.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
 <20100430203411.25812.30019.stgit@baageli.muru.com>
 <A24693684029E5489D1D202277BE8944552579A3@dlee02.ent.ti.com>
 <20100505174335.GZ29604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE894455257A6Adlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50873 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350Ab0EESXz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 May 2010 14:23:55 -0400
In-Reply-To: <20100505174335.GZ29604@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

--_002_A24693684029E5489D1D202277BE894455257A6Adlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



From: Tony Lindgren [mailto:tony@atomide.com]
Sent: Wednesday, May 05, 2010 12:44 PM
> * Aguirre, Sergio <saaguirre@ti.com> [100505 10:27]:
> > Tony,
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > > Sent: Friday, April 30, 2010 3:34 PM
> > > To: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-omap@vger.kernel.org
> > > Subject: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in
> > > omap3_defconfig
> > >
> > > Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> > > at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> > > omap FB code is fixed.
> > >
> > > This allows booting omap3_defconfig on various omaps. Tested on
> > > 2420-n8x0, 3430-n900, 3630-zoom3 and 4430-blaze. Note that n8x0
> > > still has issues with starting user space because of TLS and
> > > VFP.
> >
> > (Looping Tomi)
> >
> > Unfortunately, your patch is uncovering an issue with old DSS code to
> > compile it as module, which I think is caused by this:
> >
> > A single omapfb.ko is attempted to be created in drivers/video/omap/
> folder,
> > but the included source files (DSS code + lcd drivers), results in
> multiple
> > module_init entries added in a single module, and therefore giving
> errors of
> > duplicate init_module entries between omapfb_main.c and the lcd_*.c
> files.
> >
> > So, either you disable old DSS driver completely, or you have it as
> > built-in.
>=20
> OK thanks for pointing that out. I'll disable it so we have a
> booting omap3_defconfig (with the modules compiling).

In my local tree, I just have created this simple change, which could be
reverted IF old DSS is intended to be used as a module in the future.

I don't know how acceptable is to have it officially applied though.

Regards,
Sergio

>=20
> Regards,
>=20
> Tony

--_002_A24693684029E5489D1D202277BE894455257A6Adlee02entticom_
Content-Type: application/octet-stream;
	name="0001-omapfb-Remove-tristate-option-in-Kconfig.patch"
Content-Description: 0001-omapfb-Remove-tristate-option-in-Kconfig.patch
Content-Disposition: attachment;
	filename="0001-omapfb-Remove-tristate-option-in-Kconfig.patch"; size=836;
	creation-date="Wed, 05 May 2010 13:25:08 GMT";
	modification-date="Wed, 05 May 2010 13:25:08 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyYjUxNzQ5YWI2NmUxN2ZiYzQ4MTU3ZjdjNDc3M2Q5Y2U2YWViOTNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogV2VkLCA1IE1heSAyMDEwIDEyOjIxOjU3IC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gb21hcGZi
OiBSZW1vdmUgdHJpc3RhdGUgb3B0aW9uIGluIEtjb25maWcKCkNvbXBpbGluZyBhcyBtb2R1bGUg
aXMgYnJva2VuLCBhbmQgc2hvdWxkIGJlIGZpeGVkIGZpcnN0LApiZWZvcmUgaGF2aW5nIHRoZSBv
cHRpb24gYXZhaWxhYmxlLgoKU2lnbmVkLW9mZi1ieTogU2VyZ2lvIEFndWlycmUgPHNhYWd1aXJy
ZUB0aS5jb20+Ci0tLQogZHJpdmVycy92aWRlby9vbWFwL0tjb25maWcgfCAgICAyICstCiAxIGZp
bGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpZGVvL29tYXAvS2NvbmZpZyBiL2RyaXZlcnMvdmlkZW8vb21hcC9LY29uZmln
CmluZGV4IDQ1NWM2MDUuLjQyMGIwMDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vb21hcC9L
Y29uZmlnCisrKyBiL2RyaXZlcnMvdmlkZW8vb21hcC9LY29uZmlnCkBAIC0xLDUgKzEsNSBAQAog
Y29uZmlnIEZCX09NQVAKLQl0cmlzdGF0ZSAiT01BUCBmcmFtZSBidWZmZXIgc3VwcG9ydCAoRVhQ
RVJJTUVOVEFMKSIKKwlib29sICJPTUFQIGZyYW1lIGJ1ZmZlciBzdXBwb3J0IChFWFBFUklNRU5U
QUwpIgogCWRlcGVuZHMgb24gRkIgJiYgQVJDSF9PTUFQICYmIChPTUFQMl9EU1MgPSAibiIpCiAK
IAlzZWxlY3QgRkJfQ0ZCX0ZJTExSRUNUCi0tIAoxLjYuMy4zCgo=

--_002_A24693684029E5489D1D202277BE894455257A6Adlee02entticom_--
