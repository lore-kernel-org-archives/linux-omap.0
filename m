From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 0/7] omap3: serial code for 3630 and zoom2/3 fixes
Date: Mon, 15 Mar 2010 16:50:35 -0500
Message-ID: <A24693684029E5489D1D202277BE894454054155@dlee02.ent.ti.com>
References: <1268424009-18974-1-git-send-email-saaguirre@ti.com>
 <A24693684029E5489D1D202277BE89445405400C@dlee02.ent.ti.com>
 <20100315211525.GF2900@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE894454054155dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54827 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936925Ab0COVup (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Mar 2010 17:50:45 -0400
In-Reply-To: <20100315211525.GF2900@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>

--_002_A24693684029E5489D1D202277BE894454054155dlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



From: Tony Lindgren [mailto:tony@atomide.com]
Sent: Monday, March 15, 2010 4:15 PM
> * Aguirre, Sergio <saaguirre@ti.com> [100315 13:33]:
> > Tony,
> >
> > Please find attached pull request for your convenience.
>=20
> <snip>
>=20
> > The following changes since commit
> a842b5f9ce70e1b738eabb4d719860070180ed1c:
> >   Tony Lindgren (1):
> >         Revert "omap: Add DSI regulator supply to OMAP3EVM board file"
> >
> > are available in the git repository at:
> >
> >   git://dev.omapzoom.org/pub/scm/saaguirre/linux-omap-camera.git omap-
> fixes
>=20
> Please base all the branches against the recent tag in Linus' tree,
> in this case against v2.6.34-rc1. What we have in the linux-omap master
> branch is a merge of various development branches, and we don't want
> to merge that history to the mainline tree.
>=20
> If the recent mainline tag won't work as the base, then please
> rebase it on omap-fixes-for-linus or omap-for-linus. In this case,
> omap-fixes-for-linus at commit 29b2ee5af5f3a02846bd38a1e2121d62ee5f6aca.
> The omap-for-linus branch will contain things going into the next
> merge window, currently it's empty.
>=20
> In general, the commits ins omap-fixes-for-linus and omap-for-linus
> should stay around unless something goes wrong. But please use
> the recent mainline tag where possible, that's the most flexible
> option for merging.

Understood,

Please find updated pull request, rebased on omap-fixes-for-linux.

I tried it on master, but they don't apply clean, since "OMAP2: serial.c: F=
ix number of uarts in early_init" is not upstream, and there's a small clea=
nup change in it, which makes patch 0002 don't apply (printk to dev_* patch=
).

Thanks for your attention.

Regards,
Sergio

>=20
> Regards,
>=20
> Tony

--_002_A24693684029E5489D1D202277BE894454054155dlee02entticom_
Content-Type: text/plain; name="pullreq_tony_20100315_v2.txt"
Content-Description: pullreq_tony_20100315_v2.txt
Content-Disposition: attachment; filename="pullreq_tony_20100315_v2.txt";
	size=1114; creation-date="Mon, 15 Mar 2010 16:38:53 GMT";
	modification-date="Mon, 15 Mar 2010 16:38:53 GMT"
Content-Transfer-Encoding: base64

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyOWIyZWU1YWY1ZjNhMDI4NDZiZDM4
YTFlMjEyMWQ2MmVlNWY2YWNhOgogIEFuZHJldyBDbGF5dG9uICgxKToKICAgICAgICBBUk0vT01B
UDogUmVtb3ZlIHRoZSAreCBiaXQgZnJvbSBhIGNvdXBsZSBvZiBzb3VyY2UgZmlsZXMKCmFyZSBh
dmFpbGFibGUgaW4gdGhlIGdpdCByZXBvc2l0b3J5IGF0OgoKICBnaXQ6Ly9kZXYub21hcHpvb20u
b3JnL3B1Yi9zY20vc2FhZ3VpcnJlL2xpbnV4LW9tYXAtY2FtZXJhLmdpdCBvbWFwLWZpeGVzLWZv
ci10b255CgpTZXJnaW8gQWd1aXJyZSAoNyk6CiAgICAgIE9NQVAzOiBzZXJpYWw6IENoZWNrIGZv
ciB6ZXJvLWJhc2VkIHBoeXNpY2FsIGFkZHIKICAgICAgT01BUDM6IHNlcmlhbDogVXNlIGRldl8q
IG1hY3JvcyBpbnN0ZWFkIG9mIHByaW50awogICAgICBvbWFwMi8zLzQ6IHNlcmlhbDogUmVtb3Zl
IGNvbmRpdGlvbiBmb3IgZ2V0dGluZyB1YXJ0NF9waHlzCiAgICAgIG9tYXAzOiB6b29tMi8zIC8g
MzYzMHNkcDogRG9uJ3QgaW5pdCBhbHdheXMgYWxsIHVhcnRzCiAgICAgIG9tYXAzOiAzNjMwc2Rw
OiBFeHBsaWNpdGx5IGVuYWJsZSBhbGwgVUFSVHMKICAgICAgb21hcDM6IHpvb20gMi8zOiBDaGFu
Z2UgZGVidWdib2FyZCBzZXJpYWwgcG9ydCBpZAogICAgICBvbWFwMzogem9vbTIvMzogUmVnaXN0
ZXIgb25seSAxIDgyNTAgcG9ydAoKIGFyY2gvYXJtL2NvbmZpZ3Mvb21hcF96b29tMl9kZWZjb25m
aWcgICAgICAgIHwgICAgMiArLQogYXJjaC9hcm0vY29uZmlncy9vbWFwX3pvb20zX2RlZmNvbmZp
ZyAgICAgICAgfCAgICAyICstCiBhcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLTM2MzBzZHAuYyAg
ICAgICAgICB8ICAgIDEgKwogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC16b29tLWRlYnVnYm9h
cmQuYyAgfCAgICAyICstCiBhcmNoL2FybS9tYWNoLW9tYXAyL2JvYXJkLXpvb20tcGVyaXBoZXJh
bHMuYyB8ICAgIDEgLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9zZXJpYWwuYyAgICAgICAgICAgICAg
ICAgfCAgIDM1ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0KIDYgZmlsZXMgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCg==

--_002_A24693684029E5489D1D202277BE894454054155dlee02entticom_--
