From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
 frequency
Date: Thu, 16 Sep 2010 11:54:15 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD26018C@dbde02.ent.ti.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE896716203D6E954B9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD26018Cdbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54275 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab0IPGYk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 02:24:40 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203D6E954B9@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD26018Cdbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Woodruff, Richard
> Sent: Thursday, September 16, 2010 11:36 AM
> To: Paul Walmsley; Hunter, Jon
> Cc: linux-omap; khilman@deeprootsystems.com; tony@atomide.com
> Subject: RE: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing
> frequency
>=20
>=20
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Wednesday, September 15, 2010 2:15 PM
>=20
> > > This patch fixes this problem by ensuring the branch prediction logic
> is
> > > disabled while changing the L3 clock frequency. The branch prediction
> logic
> > > is disabled by clearing the Z-bit in the ARM AUX CTRL register.
>=20
> Small correction, Z bit is in CR register. AUX CTRL figures in with the
> ASA feature.
>=20
> > Really nice changelog.  I wish every patch had a description this good.
> > Patch looks really good, too.  Queued for 2.6.37.
>=20
> It is system specific if this change is required. It is probably safer to
> have it than not.
>=20
> If the AUX CTRL register has the ASA bit/feature active to allow
> speculative accesses to propagate past the L2 boundary the Z bit should b=
e
> cleared as in the patch.
>=20
> However, if ASA bit is not activated then Z bit clearing should not be
> necessary as speculation will be squashed if there is no L2 hit (so no DD=
R
> request will be generated).
>=20
> It is not recommended to enable ASA bit as it is known to cause some
> issues on EMU/HS devices. It was also projected as loosing more than it
> gained across some benchmarks.
>=20
> Early boot loaders used to set the ASA.  It was removed long back.  Some
> kernels kept the value and opened up the lockup window.  I don't recall
> the linux-omap open kernel having the issue. Some vendor ones did over
> time.
>=20
The code seems to be correct but just the description has typo. The code
is using control register. I just corrected the description and white
space issue. Here is updated patch.=20

Paul,
You can use this version if you like

>From fd4250671a1ae8deb718ac3688ea8971df7524cf Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Thu, 16 Sep 2010 12:03:23 +0530
Subject: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing frequency

When changing the L3 clock frequency, the CPU is executing from internal RA=
M
and the SDRC clock is disabled. During this time accesses made to external
DDR are stalled. If the ARM subsystem attempts to access the DDR while the
SDRC clock is disabled this will stall the CPU until the access to the SDRC
timeouts. A timeout on the SDRC should never occur. Once a timeout occurs a=
ll
the following accesses will be aborted and the DDR is no longer accessible.

Although the code being executed in the internal RAM does not directly acce=
ss
the DDR, it was found that the branch prediction logic in the CPU may cause
the CPU to prefetch code from a DDR location while the SDRC clock is disabl=
ed.
This was causing an SDRC timeout which resulted in a system hang.

This patch fixes this problem by ensuring the branch prediction logic is
disabled while changing the L3 clock frequency. The branch prediction logic
is disabled by clearing the Z-bit in the ARM CTRL register.

Disabling the branch prediction logic does not have any noticable impact
on the execution time of this code section. The hardware observability
signals were used to monitor the sdrc idle time with and without this
patch when operating at different CPU frequencies (150MHz, 500MHz and
600MHz) and the total sdrc idle time when changing frequenct was in
the range of 9-11us. This was measured on an omap3430 SDP running the
omapzoom p-android-omap-2.6.29 branch.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/sram34xx.S |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.=
S
index de99ba2..3637274 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -129,8 +129,11 @@ ENTRY(omap3_sram_configure_core_dpll)
 	ldr	r4, [sp, #80]
 	str     r4, omap_sdrc_mr_1_val
 skip_cs1_params:
+	mrc	p15, 0, r8, c1, c0, 0	@ read ctrl register
+	bic	r10, r8, #0x800		@ clear Z-bit, disable branch prediction
+	mcr	p15, 0, r10, c1, c0, 0	@ write ctrl register
 	dsb				@ flush buffered writes to interconnect
-
+	isb				@ prevent speculative exec past here
 	cmp	r3, #1			@ if increasing SDRC clk rate,
 	bleq	configure_sdrc		@ program the SDRC regs early (for RFR)
 	cmp	r1, #SDRC_UNLOCK_DLL	@ set the intended DLL state
@@ -148,6 +151,7 @@ skip_cs1_params:
 	beq	return_to_sdram		@ return to SDRAM code, otherwise,
 	bl	configure_sdrc		@ reprogram SDRC regs now
 return_to_sdram:
+	mcr	p15, 0, r8, c1, c0, 0	@ restore ctrl register
 	isb				@ prevent speculative exec past here
 	mov 	r0, #0 			@ return value
 	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
--=20
1.6.0.4



--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD26018Cdbde02enttico_
Content-Type: application/octet-stream;
	name="0001-omap3-Prevent-SDRC-deadlock-when-L3-is-changing-fre.patch"
Content-Description: 0001-omap3-Prevent-SDRC-deadlock-when-L3-is-changing-fre.patch
Content-Disposition: attachment;
	filename="0001-omap3-Prevent-SDRC-deadlock-when-L3-is-changing-fre.patch";
	size=2892; creation-date="Thu, 16 Sep 2010 12:03:32 GMT";
	modification-date="Thu, 16 Sep 2010 12:03:32 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmZDQyNTA2NzFhMWFlOGRlYjcxOGFjMzY4OGVhODk3MWRmNzUyNGNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb24gSHVudGVyIDxqb24taHVudGVyQHRpLmNvbT4KRGF0ZTog
VGh1LCAxNiBTZXAgMjAxMCAxMjowMzoyMyArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIG9tYXAzOiBQ
cmV2ZW50IFNEUkMgZGVhZGxvY2sgd2hlbiBMMyBpcyBjaGFuZ2luZyBmcmVxdWVuY3kKCldoZW4g
Y2hhbmdpbmcgdGhlIEwzIGNsb2NrIGZyZXF1ZW5jeSwgdGhlIENQVSBpcyBleGVjdXRpbmcgZnJv
bSBpbnRlcm5hbCBSQU0KYW5kIHRoZSBTRFJDIGNsb2NrIGlzIGRpc2FibGVkLiBEdXJpbmcgdGhp
cyB0aW1lIGFjY2Vzc2VzIG1hZGUgdG8gZXh0ZXJuYWwKRERSIGFyZSBzdGFsbGVkLiBJZiB0aGUg
QVJNIHN1YnN5c3RlbSBhdHRlbXB0cyB0byBhY2Nlc3MgdGhlIEREUiB3aGlsZSB0aGUKU0RSQyBj
bG9jayBpcyBkaXNhYmxlZCB0aGlzIHdpbGwgc3RhbGwgdGhlIENQVSB1bnRpbCB0aGUgYWNjZXNz
IHRvIHRoZSBTRFJDCnRpbWVvdXRzLiBBIHRpbWVvdXQgb24gdGhlIFNEUkMgc2hvdWxkIG5ldmVy
IG9jY3VyLiBPbmNlIGEgdGltZW91dCBvY2N1cnMgYWxsCnRoZSBmb2xsb3dpbmcgYWNjZXNzZXMg
d2lsbCBiZSBhYm9ydGVkIGFuZCB0aGUgRERSIGlzIG5vIGxvbmdlciBhY2Nlc3NpYmxlLgoKQWx0
aG91Z2ggdGhlIGNvZGUgYmVpbmcgZXhlY3V0ZWQgaW4gdGhlIGludGVybmFsIFJBTSBkb2VzIG5v
dCBkaXJlY3RseSBhY2Nlc3MKdGhlIEREUiwgaXQgd2FzIGZvdW5kIHRoYXQgdGhlIGJyYW5jaCBw
cmVkaWN0aW9uIGxvZ2ljIGluIHRoZSBDUFUgbWF5IGNhdXNlCnRoZSBDUFUgdG8gcHJlZmV0Y2gg
Y29kZSBmcm9tIGEgRERSIGxvY2F0aW9uIHdoaWxlIHRoZSBTRFJDIGNsb2NrIGlzIGRpc2FibGVk
LgpUaGlzIHdhcyBjYXVzaW5nIGFuIFNEUkMgdGltZW91dCB3aGljaCByZXN1bHRlZCBpbiBhIHN5
c3RlbSBoYW5nLgoKVGhpcyBwYXRjaCBmaXhlcyB0aGlzIHByb2JsZW0gYnkgZW5zdXJpbmcgdGhl
IGJyYW5jaCBwcmVkaWN0aW9uIGxvZ2ljIGlzCmRpc2FibGVkIHdoaWxlIGNoYW5naW5nIHRoZSBM
MyBjbG9jayBmcmVxdWVuY3kuIFRoZSBicmFuY2ggcHJlZGljdGlvbiBsb2dpYwppcyBkaXNhYmxl
ZCBieSBjbGVhcmluZyB0aGUgWi1iaXQgaW4gdGhlIEFSTSBDVFJMIHJlZ2lzdGVyLgoKRGlzYWJs
aW5nIHRoZSBicmFuY2ggcHJlZGljdGlvbiBsb2dpYyBkb2VzIG5vdCBoYXZlIGFueSBub3RpY2Fi
bGUgaW1wYWN0Cm9uIHRoZSBleGVjdXRpb24gdGltZSBvZiB0aGlzIGNvZGUgc2VjdGlvbi4gVGhl
IGhhcmR3YXJlIG9ic2VydmFiaWxpdHkKc2lnbmFscyB3ZXJlIHVzZWQgdG8gbW9uaXRvciB0aGUg
c2RyYyBpZGxlIHRpbWUgd2l0aCBhbmQgd2l0aG91dCB0aGlzCnBhdGNoIHdoZW4gb3BlcmF0aW5n
IGF0IGRpZmZlcmVudCBDUFUgZnJlcXVlbmNpZXMgKDE1ME1IeiwgNTAwTUh6IGFuZAo2MDBNSHop
IGFuZCB0aGUgdG90YWwgc2RyYyBpZGxlIHRpbWUgd2hlbiBjaGFuZ2luZyBmcmVxdWVuY3Qgd2Fz
IGluCnRoZSByYW5nZSBvZiA5LTExdXMuIFRoaXMgd2FzIG1lYXN1cmVkIG9uIGFuIG9tYXAzNDMw
IFNEUCBydW5uaW5nIHRoZQpvbWFwem9vbSBwLWFuZHJvaWQtb21hcC0yLjYuMjkgYnJhbmNoLgoK
U2lnbmVkLW9mZi1ieTogSm9uIEh1bnRlciA8am9uLWh1bnRlckB0aS5jb20+Ci0tLQogYXJjaC9h
cm0vbWFjaC1vbWFwMi9zcmFtMzR4eC5TIHwgICAgNiArKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21h
Y2gtb21hcDIvc3JhbTM0eHguUyBiL2FyY2gvYXJtL21hY2gtb21hcDIvc3JhbTM0eHguUwppbmRl
eCBkZTk5YmEyLi4zNjM3Mjc0IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL3NyYW0z
NHh4LlMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9zcmFtMzR4eC5TCkBAIC0xMjksOCArMTI5
LDExIEBAIEVOVFJZKG9tYXAzX3NyYW1fY29uZmlndXJlX2NvcmVfZHBsbCkKIAlsZHIJcjQsIFtz
cCwgIzgwXQogCXN0ciAgICAgcjQsIG9tYXBfc2RyY19tcl8xX3ZhbAogc2tpcF9jczFfcGFyYW1z
OgorCW1yYwlwMTUsIDAsIHI4LCBjMSwgYzAsIDAJQCByZWFkIGN0cmwgcmVnaXN0ZXIKKwliaWMJ
cjEwLCByOCwgIzB4ODAwCQlAIGNsZWFyIFotYml0LCBkaXNhYmxlIGJyYW5jaCBwcmVkaWN0aW9u
CisJbWNyCXAxNSwgMCwgcjEwLCBjMSwgYzAsIDAJQCB3cml0ZSBjdHJsIHJlZ2lzdGVyCiAJZHNi
CQkJCUAgZmx1c2ggYnVmZmVyZWQgd3JpdGVzIHRvIGludGVyY29ubmVjdAotCisJaXNiCQkJCUAg
cHJldmVudCBzcGVjdWxhdGl2ZSBleGVjIHBhc3QgaGVyZQogCWNtcAlyMywgIzEJCQlAIGlmIGlu
Y3JlYXNpbmcgU0RSQyBjbGsgcmF0ZSwKIAlibGVxCWNvbmZpZ3VyZV9zZHJjCQlAIHByb2dyYW0g
dGhlIFNEUkMgcmVncyBlYXJseSAoZm9yIFJGUikKIAljbXAJcjEsICNTRFJDX1VOTE9DS19ETEwJ
QCBzZXQgdGhlIGludGVuZGVkIERMTCBzdGF0ZQpAQCAtMTQ4LDYgKzE1MSw3IEBAIHNraXBfY3Mx
X3BhcmFtczoKIAliZXEJcmV0dXJuX3RvX3NkcmFtCQlAIHJldHVybiB0byBTRFJBTSBjb2RlLCBv
dGhlcndpc2UsCiAJYmwJY29uZmlndXJlX3NkcmMJCUAgcmVwcm9ncmFtIFNEUkMgcmVncyBub3cK
IHJldHVybl90b19zZHJhbToKKwltY3IJcDE1LCAwLCByOCwgYzEsIGMwLCAwCUAgcmVzdG9yZSBj
dHJsIHJlZ2lzdGVyCiAJaXNiCQkJCUAgcHJldmVudCBzcGVjdWxhdGl2ZSBleGVjIHBhc3QgaGVy
ZQogCW1vdiAJcjAsICMwIAkJCUAgcmV0dXJuIHZhbHVlCiAJbGRtZmQJc3AhLCB7cjEtcjEyLCBw
Y30JQCByZXN0b3JlIHJlZ3MgYW5kIHJldHVybgotLSAKMS42LjAuNAoK

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD26018Cdbde02enttico_--
