From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] arm: Fix .gitignore for boot/compressed folder
Date: Mon, 3 May 2010 10:24:07 -0500
Message-ID: <A24693684029E5489D1D202277BE8944551B8F75@dlee02.ent.ti.com>
References: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
 <20100502122049.GA5553@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE8944551B8F75dlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36218 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751Ab0ECPYc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 May 2010 11:24:32 -0400
In-Reply-To: <20100502122049.GA5553@pengutronix.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Albin Tonnerre <albin.tonnerre@free-electrons.com>, Russell King <rmk@arm.linux.org.uk>

--_002_A24693684029E5489D1D202277BE8944551B8F75dlee02entticom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
Sent: Sunday, May 02, 2010 7:21 AM
> On Thu, Feb 25, 2010 at 09:55:45AM -0600, Sergio Aguirre wrote:
> > This should complements changes done in:
> I think this should read "complement" only, that is, no 's' at the end.
> Other than that,

Oops, typo fixed. Thanks for noticing that!

Also... I added arch/arm/boot/compressed/vmlinux to the list, since when I
build for my OMAP3 board, it shows in the dirty index.

Is it acceptable to add that aswell? If yes, then attached patch contains
your ACK + vmlinux added to the list.

>=20
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks!

Regards,
Sergio

<snip>

--_002_A24693684029E5489D1D202277BE8944551B8F75dlee02entticom_
Content-Type: application/octet-stream;
	name="0001-arm-Fix-.gitignore-for-boot-compressed-folder.patch"
Content-Description: 0001-arm-Fix-.gitignore-for-boot-compressed-folder.patch
Content-Disposition: attachment;
	filename="0001-arm-Fix-.gitignore-for-boot-compressed-folder.patch";
	size=1131; creation-date="Mon, 03 May 2010 10:26:06 GMT";
	modification-date="Mon, 03 May 2010 10:26:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1NGU3NWI1OGE0ODlkMmUyZTEwMTIxYmFmYmU5ZmJmNjFhNmY3OWRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnaW8gQWd1aXJyZSA8c2FhZ3VpcnJlQHRpLmNvbT4KRGF0
ZTogVGh1LCAyNSBGZWIgMjAxMCAwOTo0OTo1MSAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGFybTog
Rml4IC5naXRpZ25vcmUgZm9yIGJvb3QvY29tcHJlc3NlZCBmb2xkZXIKTUlNRS1WZXJzaW9uOiAx
LjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PXV0Zi04CkNvbnRlbnQtVHJhbnNm
ZXItRW5jb2Rpbmc6IDhiaXQKClRoaXMgc2hvdWxkIGNvbXBsZW1lbnQgY2hhbmdlcyBkb25lIGlu
OgoKICBjb21taXQgZTdkYjdiNDI3MGVkMmE2MDZiOGMwYjVmOTQ0YTVmOTJhZGUwZTg0YwogIEF1
dGhvcjogQWxiaW4gVG9ubmVycmUgPGFsYmluLnRvbm5lcnJlQGZyZWUtZWxlY3Ryb25zLmNvbT4K
ICBEYXRlOiAgIEZyaSBKYW4gOCAxNDo0Mjo0MyAyMDEwIC0wODAwCgogICAgICBhcm06IGFkZCBz
dXBwb3J0IGZvciBMWk8tY29tcHJlc3NlZCBrZXJuZWxzCgpJdCBtaXNzZWQgdG8gZG8gdGhlIHJl
c3BlY3RpdmUgY2hhbmdlcyBpbiAnLmdpdGlnbm9yZScgZmlsZS4KClNpZ25lZC1vZmYtYnk6IFNl
cmdpbyBBZ3VpcnJlIDxzYWFndWlycmVAdGkuY29tPgpBY2tlZC1ieTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBhcmNoL2FybS9ib290L2Nv
bXByZXNzZWQvLmdpdGlnbm9yZSB8ICAgIDUgKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvY29t
cHJlc3NlZC8uZ2l0aWdub3JlIGIvYXJjaC9hcm0vYm9vdC9jb21wcmVzc2VkLy5naXRpZ25vcmUK
aW5kZXggYWIyMDRkYi4uM2U3MjhhNiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9jb21wcmVz
c2VkLy5naXRpZ25vcmUKKysrIGIvYXJjaC9hcm0vYm9vdC9jb21wcmVzc2VkLy5naXRpZ25vcmUK
QEAgLTEsMyArMSw2IEBACiBmb250LmMKLXBpZ2d5Lmd6CitwaWdneS5nemlwCitwaWdneS5sem8K
K2xpYjFmdW5jcy5TCiB2bWxpbnV4Lmxkcwordm1saW51eAotLSAKMS42LjMuMwoK

--_002_A24693684029E5489D1D202277BE8944551B8F75dlee02entticom_--
