From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 0/7] omap3: serial code for 3630 and zoom2/3 fixes
Date: Mon, 15 Mar 2010 15:36:55 -0500
Message-ID: <A24693684029E5489D1D202277BE89445405400C@dlee02.ent.ti.com>
References: <1268424009-18974-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_A24693684029E5489D1D202277BE89445405400Cdlee02entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42001 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138Ab0COUhE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Mar 2010 16:37:04 -0400
In-Reply-To: <1268424009-18974-1-git-send-email-saaguirre@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>

--_002_A24693684029E5489D1D202277BE89445405400Cdlee02entticom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Tony,

Please find attached pull request for your convenience.

Regards,
Sergio

> -----Original Message-----
> From: Aguirre, Sergio
> Sent: Friday, March 12, 2010 2:00 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Pandita, Vikram; Paul
> Walmsley; Felipe Balbi; Aguirre, Sergio
> Subject: [PATCH 0/7] omap3: serial code for 3630 and zoom2/3 fixes
>=20
> Hi,
>=20
> This series contains fixes for omap2/3/4 serial code, and are
> fixing:
>  - Avoid doing ioremapp of a zero-based physical address.
>    (causing a kernel panic during early init on 3630boards)
>  - Unproper omap_revision check during uart globals setup.
>    (omap_revision is not yet filled at that point)
>  - Don't try to enable all uarts generically for zoom2/3
>    and 3630sdp.
>  - Make zoom2/3 just register one serial port (ttyS0).
>=20
> This is a subset of the original series found here: [1]
>=20
> Thanks to:
>  - Vikram Pandita
>  - Paul Walmsley
>  - Kevin Hilman
>  - Manjunath Kondaiah
>  - Felipe Balbi
>  - Tony Lindgreen
>=20
> For all the feedback recieved so far.
>=20
> Regards,
> Sergio
>=20
> Sergio Aguirre (7):
>   OMAP3: serial: Check for zero-based physical addr
>   OMAP3: serial: Use dev_* macros instead of printk
>   omap2/3/4: serial: Remove condition for getting uart4_phys
>   omap3: zoom2/3 / 3630sdp: Don't init always all uarts
>   omap3: 3630sdp: Explicitly enable all UARTs
>   omap3: zoom 2/3: Change debugboard serial port id
>   omap3: zoom2/3: Register only 1 8250 port
>=20
>  arch/arm/configs/omap_zoom2_defconfig        |    2 +-
>  arch/arm/configs/omap_zoom3_defconfig        |    2 +-
>  arch/arm/mach-omap2/board-3630sdp.c          |    1 +
>  arch/arm/mach-omap2/board-zoom-debugboard.c  |    2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
>  arch/arm/mach-omap2/serial.c                 |   35 +++++++++++++-------=
-
> ----
>  6 files changed, 22 insertions(+), 21 deletions(-)
>=20
> [1] http://marc.info/?l=3Dlinux-omap&m=3D126826639903105&w=3D2


--_002_A24693684029E5489D1D202277BE89445405400Cdlee02entticom_
Content-Type: text/plain; name="pullreq_tony_20100315.txt"
Content-Description: pullreq_tony_20100315.txt
Content-Disposition: attachment; filename="pullreq_tony_20100315.txt";
	size=1109; creation-date="Mon, 15 Mar 2010 15:36:19 GMT";
	modification-date="Mon, 15 Mar 2010 15:36:19 GMT"
Content-Transfer-Encoding: base64

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBhODQyYjVmOWNlNzBlMWI3MzhlYWJi
NGQ3MTk4NjAwNzAxODBlZDFjOgogIFRvbnkgTGluZGdyZW4gKDEpOgogICAgICAgIFJldmVydCAi
b21hcDogQWRkIERTSSByZWd1bGF0b3Igc3VwcGx5IHRvIE9NQVAzRVZNIGJvYXJkIGZpbGUiCgph
cmUgYXZhaWxhYmxlIGluIHRoZSBnaXQgcmVwb3NpdG9yeSBhdDoKCiAgZ2l0Oi8vZGV2Lm9tYXB6
b29tLm9yZy9wdWIvc2NtL3NhYWd1aXJyZS9saW51eC1vbWFwLWNhbWVyYS5naXQgb21hcC1maXhl
cwoKU2VyZ2lvIEFndWlycmUgKDcpOgogICAgICBPTUFQMzogc2VyaWFsOiBDaGVjayBmb3IgemVy
by1iYXNlZCBwaHlzaWNhbCBhZGRyCiAgICAgIE9NQVAzOiBzZXJpYWw6IFVzZSBkZXZfKiBtYWNy
b3MgaW5zdGVhZCBvZiBwcmludGsKICAgICAgb21hcDIvMy80OiBzZXJpYWw6IFJlbW92ZSBjb25k
aXRpb24gZm9yIGdldHRpbmcgdWFydDRfcGh5cwogICAgICBvbWFwMzogem9vbTIvMyAvIDM2MzBz
ZHA6IERvbid0IGluaXQgYWx3YXlzIGFsbCB1YXJ0cwogICAgICBvbWFwMzogMzYzMHNkcDogRXhw
bGljaXRseSBlbmFibGUgYWxsIFVBUlRzCiAgICAgIG9tYXAzOiB6b29tIDIvMzogQ2hhbmdlIGRl
YnVnYm9hcmQgc2VyaWFsIHBvcnQgaWQKICAgICAgb21hcDM6IHpvb20yLzM6IFJlZ2lzdGVyIG9u
bHkgMSA4MjUwIHBvcnQKCiBhcmNoL2FybS9jb25maWdzL29tYXBfem9vbTJfZGVmY29uZmlnICAg
ICAgICB8ICAgIDIgKy0KIGFyY2gvYXJtL2NvbmZpZ3Mvb21hcF96b29tM19kZWZjb25maWcgICAg
ICAgIHwgICAgMiArLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC0zNjMwc2RwLmMgICAgICAg
ICAgfCAgICAxICsKIGFyY2gvYXJtL21hY2gtb21hcDIvYm9hcmQtem9vbS1kZWJ1Z2JvYXJkLmMg
IHwgICAgMiArLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9ib2FyZC16b29tLXBlcmlwaGVyYWxzLmMg
fCAgICAxIC0KIGFyY2gvYXJtL21hY2gtb21hcDIvc2VyaWFsLmMgICAgICAgICAgICAgICAgIHwg
ICAzNSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiA2IGZpbGVzIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQo=

--_002_A24693684029E5489D1D202277BE89445405400Cdlee02entticom_--
