From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Unbalanced IRQ wake disable during resume from static suspend
Date: Thu, 2 Dec 2010 16:40:28 +0530
Message-ID: <09fd160109a43efec9a472055d541c9e@mail.gmail.com>
References: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com>
 <alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com> <1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com>
 <AANLkTikqvVK2BWpiik5SVWPRzC6NMKs=Udvrtru5BfR-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175caa8048a5a504966b7856
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:57488 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755394Ab0LBLKb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 06:10:31 -0500
Received: by mail-qy0-f180.google.com with SMTP id 29so8537935qyk.18
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 03:10:30 -0800 (PST)
In-Reply-To: <AANLkTikqvVK2BWpiik5SVWPRzC6NMKs=Udvrtru5BfR-@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

--0015175caa8048a5a504966b7856
Content-Type: text/plain; charset=ISO-8859-1

Thanks Govind for testing it.

> -----Original Message-----
> From: Govindraj [mailto:govindraj.ti@gmail.com]
> Sent: Thursday, December 02, 2010 4:05 PM
> To: Santosh Shilimkar
> Cc: Paul Walmsley; linux-omap@vger.kernel.org;
khilman@deeprootsystems.com
> Subject: Re: Unbalanced IRQ wake disable during resume from static
suspend
>
> On Thu, Dec 2, 2010 at 2:38 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> > Paul,
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> >> Sent: Thursday, December 02, 2010 1:44 PM
> >> To: linux-omap@vger.kernel.org; Govindraj
> >> Cc: khilman@deeprootsystems.com
> >> Subject: Re: Unbalanced IRQ wake disable during resume from static
> > suspend
> >>
> >> On Thu, 2 Dec 2010, Paul Walmsley wrote:
> >>
> >> > On current linux-omap master (commit
> >> > 7fd1cffc56ca9944fec583eb2ecda5ce88b36bff "Linux-omap rebuilt:
Updated
> > to
> >> > -rc4"), when resuming from static suspend, several "Unbalanced IRQ
> >> > wake disable" warnings are generated, one for each of the serial
> > ports.
> >> > This is on Beagle 35xx rev C2.
> >>
> >> Just to follow up on this, these messages are not logged when
> >> /sys/devices/platform/omap/omap-hsuart.*/tty/ttyO*/power/wakeup are
set
> > to
> >> 'disabled'.
> >>
> >> Also this is with omap2plus_defconfig.
> >>
> > Just a wild guess here but is this because the 'set_wake' is
> > not setup and then fw might be returning some error whenever
> > driver invoke this API as part of enable_irq_wake() callback
> >
> > If that being the case, below patch might might help. Can
> > somebody try this out ?
> >
>
> Tested on 3630SDP.
> The below patch helps to avoid the warnings.
>

Here is the refreshed version with change log. Also
attached the patch in case google mails raps it up.

>From 0170159ae34957efb839d9143123f7ced795f62e Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 2 Dec 2010 14:36:17 +0530
Subject: [PATCH] omap: irq: Dummy handler for enable_irq_wake

With PM enabled, enable_irq_wake() has a callback for
interrupt controllers. But since omap INTC handler did not had this
call back associated, it was always returning -ENXIO, which was
breaking the existing drivers. This patch adds dummy handlers in
in order to avoid breaking of existing drivers.

Without this patch you get below warnings with wakeup enabled on devices

------------[ cut here ]------------
WARNING: at kernel/irq/manage.c:382 set_irq_wake+0x80/0xe4()
Unbalanced IRQ 72 wake disable
Modules linked in:
[<c0062a28>] (unwind_backtrace+0x0/0xec) from [<c0092260>]
(warn_slowpath_common+0x4c/0x64)
[<c0092260>] (warn_slowpath_common+0x4c/0x64) from [<c00922f8>]
(warn_slowpath_fmt+0x2c/0x3c

[<c00922f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00d3238>]
(set_irq_wake+0x80/0xe4)
[<c00d3238>] (set_irq_wake+0x80/0xe4) from [<c029dd60>]
(uart_resume_port+0x84/0x248)
[<c029dd60>] (uart_resume_port+0x84/0x248) from [<c02a2338>]
(serial_omap_resume+0x20/0x2c)
[<c02a2338>] (serial_omap_resume+0x20/0x2c) from [<c02a92d4>]
(platform_pm_resume+0x48/0x54)
[<c02a92d4>] (platform_pm_resume+0x48/0x54) from [<c02abd1c>]
(pm_op+0x6c/0xac)
[<c02abd1c>] (pm_op+0x6c/0xac) from [<c02ac0fc>]
(device_resume+0x58/0x10c)
[<c02ac0fc>] (device_resume+0x58/0x10c) from [<c02ac2ec>]
(dpm_resume_end+0xf4/0x360)
[<c02ac2ec>] (dpm_resume_end+0xf4/0x360) from [<c00cf58c>]
(suspend_devices_and_enter+0x1ac/
0x200)
[<c00cf58c>] (suspend_devices_and_enter+0x1ac/0x200) from [<c00cf6c0>]
(enter_state+0xe0/0x1
38)
[<c00cf6c0>] (enter_state+0xe0/0x138) from [<c00ced18>]
(state_store+0x90/0xb8)
[<c00ced18>] (state_store+0x90/0xb8) from [<c0243b98>]
(kobj_attr_store+0x18/0x1c)
[<c0243b98>] (kobj_attr_store+0x18/0x1c) from [<c0176128>]
(sysfs_write_file+0x10c/0x144)
[<c0176128>] (sysfs_write_file+0x10c/0x144) from [<c0125528>]
(vfs_write+0xac/0x134)
[<c0125528>] (vfs_write+0xac/0x134) from [<c012565c>]
(sys_write+0x3c/0x68)
[<c012565c>] (sys_write+0x3c/0x68) from [<c005bb00>]
(ret_fast_syscall+0x0/0x3c)
---[ end trace 19fe50b7b47ba94f ]---

Reported-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/irq.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 32eeabe..6a964d3 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -143,11 +143,21 @@ static void omap_mask_ack_irq(unsigned int irq)
 	omap_ack_irq(irq);
 }

+#ifdef CONFIG_PM
+static int omap_set_wake(unsigned int irq, unsigned int on)
+{
+	return 0;
+}
+#else
+#define omap_set_wake NULL
+#endif
+
 static struct irq_chip omap_irq_chip = {
 	.name	= "INTC",
 	.ack	= omap_mask_ack_irq,
 	.mask	= omap_mask_irq,
 	.unmask	= omap_unmask_irq,
+	.set_wake = omap_set_wake,
 };

 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
-- 
1.6.0.4

--0015175caa8048a5a504966b7856
Content-Type: application/octet-stream;
	name="0001-omap-irq-Dummy-handler-for-enable_irq_wake.patch"
Content-Disposition: attachment;
	filename="0001-omap-irq-Dummy-handler-for-enable_irq_wake.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4103fb62e3042dbf_0.1

RnJvbSAwMTcwMTU5YWUzNDk1N2VmYjgzOWQ5MTQzMTIzZjdjZWQ3OTVmNjJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBUaHUsIDIgRGVjIDIwMTAgMTQ6MzY6MTcgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBvbWFwOiBpcnE6IER1bW15IGhhbmRsZXIgZm9yIGVuYWJsZV9pcnFfd2FrZQoKV2l0aCBQ
TSBlbmFibGVkLCBlbmFibGVfaXJxX3dha2UoKSBoYXMgYSBjYWxsYmFjayBmb3IKaW50ZXJydXB0
IGNvbnRyb2xsZXJzLiBCdXQgc2luY2Ugb21hcCBJTlRDIGhhbmRsZXIgZGlkIG5vdCBoYWQgdGhp
cwpjYWxsIGJhY2sgYXNzb2NpYXRlZCwgaXQgd2FzIGFsd2F5cyByZXR1cm5pbmcgLUVOWElPLCB3
aGljaCB3YXMKYnJlYWtpbmcgdGhlIGV4aXN0aW5nIGRyaXZlcnMuIFRoaXMgcGF0Y2ggYWRkcyBk
dW1teSBoYW5kbGVycyBpbgppbiBvcmRlciB0byBhdm9pZCBicmVha2luZyBvZiBleGlzdGluZyBk
cml2ZXJzLgoKV2l0aG91dCB0aGlzIHBhdGNoIHlvdSBnZXQgYmVsb3cgd2FybmluZ3Mgd2l0aCB3
YWtldXAgZW5hYmxlZCBvbiBkZXZpY2VzCgotLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0t
LS0tLS0KV0FSTklORzogYXQga2VybmVsL2lycS9tYW5hZ2UuYzozODIgc2V0X2lycV93YWtlKzB4
ODAvMHhlNCgpClVuYmFsYW5jZWQgSVJRIDcyIHdha2UgZGlzYWJsZQpNb2R1bGVzIGxpbmtlZCBp
bjoKWzxjMDA2MmEyOD5dICh1bndpbmRfYmFja3RyYWNlKzB4MC8weGVjKSBmcm9tIFs8YzAwOTIy
NjA+XSAod2Fybl9zbG93cGF0aF9jb21tb24rMHg0Yy8weDY0KQpbPGMwMDkyMjYwPl0gKHdhcm5f
c2xvd3BhdGhfY29tbW9uKzB4NGMvMHg2NCkgZnJvbSBbPGMwMDkyMmY4Pl0gKHdhcm5fc2xvd3Bh
dGhfZm10KzB4MmMvMHgzYwoKWzxjMDA5MjJmOD5dICh3YXJuX3Nsb3dwYXRoX2ZtdCsweDJjLzB4
M2MpIGZyb20gWzxjMDBkMzIzOD5dIChzZXRfaXJxX3dha2UrMHg4MC8weGU0KQpbPGMwMGQzMjM4
Pl0gKHNldF9pcnFfd2FrZSsweDgwLzB4ZTQpIGZyb20gWzxjMDI5ZGQ2MD5dICh1YXJ0X3Jlc3Vt
ZV9wb3J0KzB4ODQvMHgyNDgpCls8YzAyOWRkNjA+XSAodWFydF9yZXN1bWVfcG9ydCsweDg0LzB4
MjQ4KSBmcm9tIFs8YzAyYTIzMzg+XSAoc2VyaWFsX29tYXBfcmVzdW1lKzB4MjAvMHgyYykKWzxj
MDJhMjMzOD5dIChzZXJpYWxfb21hcF9yZXN1bWUrMHgyMC8weDJjKSBmcm9tIFs8YzAyYTkyZDQ+
XSAocGxhdGZvcm1fcG1fcmVzdW1lKzB4NDgvMHg1NCkKWzxjMDJhOTJkND5dIChwbGF0Zm9ybV9w
bV9yZXN1bWUrMHg0OC8weDU0KSBmcm9tIFs8YzAyYWJkMWM+XSAocG1fb3ArMHg2Yy8weGFjKQpb
PGMwMmFiZDFjPl0gKHBtX29wKzB4NmMvMHhhYykgZnJvbSBbPGMwMmFjMGZjPl0gKGRldmljZV9y
ZXN1bWUrMHg1OC8weDEwYykKWzxjMDJhYzBmYz5dIChkZXZpY2VfcmVzdW1lKzB4NTgvMHgxMGMp
IGZyb20gWzxjMDJhYzJlYz5dIChkcG1fcmVzdW1lX2VuZCsweGY0LzB4MzYwKQpbPGMwMmFjMmVj
Pl0gKGRwbV9yZXN1bWVfZW5kKzB4ZjQvMHgzNjApIGZyb20gWzxjMDBjZjU4Yz5dIChzdXNwZW5k
X2RldmljZXNfYW5kX2VudGVyKzB4MWFjLwoweDIwMCkKWzxjMDBjZjU4Yz5dIChzdXNwZW5kX2Rl
dmljZXNfYW5kX2VudGVyKzB4MWFjLzB4MjAwKSBmcm9tIFs8YzAwY2Y2YzA+XSAoZW50ZXJfc3Rh
dGUrMHhlMC8weDEKMzgpCls8YzAwY2Y2YzA+XSAoZW50ZXJfc3RhdGUrMHhlMC8weDEzOCkgZnJv
bSBbPGMwMGNlZDE4Pl0gKHN0YXRlX3N0b3JlKzB4OTAvMHhiOCkKWzxjMDBjZWQxOD5dIChzdGF0
ZV9zdG9yZSsweDkwLzB4YjgpIGZyb20gWzxjMDI0M2I5OD5dIChrb2JqX2F0dHJfc3RvcmUrMHgx
OC8weDFjKQpbPGMwMjQzYjk4Pl0gKGtvYmpfYXR0cl9zdG9yZSsweDE4LzB4MWMpIGZyb20gWzxj
MDE3NjEyOD5dIChzeXNmc193cml0ZV9maWxlKzB4MTBjLzB4MTQ0KQpbPGMwMTc2MTI4Pl0gKHN5
c2ZzX3dyaXRlX2ZpbGUrMHgxMGMvMHgxNDQpIGZyb20gWzxjMDEyNTUyOD5dICh2ZnNfd3JpdGUr
MHhhYy8weDEzNCkKWzxjMDEyNTUyOD5dICh2ZnNfd3JpdGUrMHhhYy8weDEzNCkgZnJvbSBbPGMw
MTI1NjVjPl0gKHN5c193cml0ZSsweDNjLzB4NjgpCls8YzAxMjU2NWM+XSAoc3lzX3dyaXRlKzB4
M2MvMHg2OCkgZnJvbSBbPGMwMDViYjAwPl0gKHJldF9mYXN0X3N5c2NhbGwrMHgwLzB4M2MpCi0t
LVsgZW5kIHRyYWNlIDE5ZmU1MGI3YjQ3YmE5NGYgXS0tLQoKUmVwb3J0ZWQtYnk6IFBhdWwgV2Fs
bXNsZXkgPHBhdWxAcHdzYW4uY29tPgpUZXN0ZWQtYnk6IEdvdmluZHJhai5SIDxnb3ZpbmRyYWou
cmFqYUB0aS5jb20+CgpTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5z
aGlsaW1rYXJAdGkuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvaXJxLmMgfCAgIDEwICsr
KysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2lycS5jIGIvYXJjaC9hcm0vbWFj
aC1vbWFwMi9pcnEuYwppbmRleCAzMmVlYWJlLi42YTk2NGQzIDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9tYWNoLW9tYXAyL2lycS5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvaXJxLmMKQEAgLTE0
MywxMSArMTQzLDIxIEBAIHN0YXRpYyB2b2lkIG9tYXBfbWFza19hY2tfaXJxKHVuc2lnbmVkIGlu
dCBpcnEpCiAJb21hcF9hY2tfaXJxKGlycSk7CiB9CiAKKyNpZmRlZiBDT05GSUdfUE0KK3N0YXRp
YyBpbnQgb21hcF9zZXRfd2FrZSh1bnNpZ25lZCBpbnQgaXJxLCB1bnNpZ25lZCBpbnQgb24pCit7
CisJcmV0dXJuIDA7Cit9CisjZWxzZQorI2RlZmluZSBvbWFwX3NldF93YWtlIE5VTEwKKyNlbmRp
ZgorCiBzdGF0aWMgc3RydWN0IGlycV9jaGlwIG9tYXBfaXJxX2NoaXAgPSB7CiAJLm5hbWUJPSAi
SU5UQyIsCiAJLmFjawk9IG9tYXBfbWFza19hY2tfaXJxLAogCS5tYXNrCT0gb21hcF9tYXNrX2ly
cSwKIAkudW5tYXNrCT0gb21hcF91bm1hc2tfaXJxLAorCS5zZXRfd2FrZSA9IG9tYXBfc2V0X3dh
a2UsCiB9OwogCiBzdGF0aWMgdm9pZCBfX2luaXQgb21hcF9pcnFfYmFua19pbml0X29uZShzdHJ1
Y3Qgb21hcF9pcnFfYmFuayAqYmFuaykKLS0gCjEuNi4wLjQKCg==
--0015175caa8048a5a504966b7856--
