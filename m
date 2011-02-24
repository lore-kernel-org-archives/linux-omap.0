From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 0/3] OMAP2+: voltage: first pass at cleanup/reorganization
Date: Thu, 24 Feb 2011 17:27:52 +0530
Message-ID: <553cd99ec29ee91e4a4b324d0f4a0be7@mail.gmail.com>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30433eeccc95c2049d05ecaa
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:54470 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751754Ab1BXL6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Feb 2011 06:58:23 -0500
Received: by mail-fx0-f52.google.com with SMTP id 17so521987fxm.39
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 03:58:22 -0800 (PST)
In-Reply-To: <20110221020231.7598.14024.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>, Benoit Cousson <b-cousson@ti.com>, Mike Turquette <mturquette@ti.com>

--20cf30433eeccc95c2049d05ecaa
Content-Type: text/plain; charset=ISO-8859-1

Hi Paul,

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org
[mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf
> Of Paul Walmsley
> Sent: Monday, February 21, 2011 7:39 AM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: khilman@ti.com; nm@ti.com; b-cousson@ti.com; mturquette@ti.com
> Subject: [PATCH 0/3] OMAP2+: voltage: first pass at
cleanup/reorganization
>
> Hello,
>
> this patch set does an initial round of cleanup on the OMAP "voltage"
code
> in arch/arm/mach-omap2/voltage.c.  As part of this process, the header
files
> for the voltage code and SmartReflex are moved into arch/arm/mach-omap2,
since
> they are currently OMAP2+-specific.
>
> There is still quite a bit of cleanup left to do; hopefully someone else
will
> get to it before I do.  More details are in the last patch.
>
> This series was built-tested for an OSK5912-specific config,
omap1_defconfig,
> a N800-specific config, omap2plus_defconfig, an OMAP3-specific config,
and
> an OMAP4-specific config.  It was boot-tested on an OMAP35xx
Beagleboard.
> Further testing assistance is, of course, appreciated.

I found these abort on my 4430SDP. The below changes I found
are needed for it to bootup..
I tested the 'integration-2.6.39' branch of
git://git.pwsan.com/linux-integration and the patch is
based on this branch.

---
>From e3d5e2bb09ecb7a958c1f79b86d1917f0becb8d2 Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Thu, 24 Feb 2011 16:42:25 +0530
Subject: [PATCH] OMAP4: voltage: Populate missing .vp/.vc_common pointers

The common_data for vp and vc on OMAP4 is defined
but not hooked up with the corresponding
vp/vc_data.
This causes an abort at bootup on OMAP4, as the
framework api's assumes these to be present.

While here, also rename omap4_vp_data to
omap4_vp_common and omap4_vc_data to
omap4_vc_common to maintain consistency in
naming structs across all OMAPs.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/vc44xx_data.c |    5 ++++-
 arch/arm/mach-omap2/vp44xx_data.c |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/vc44xx_data.c
b/arch/arm/mach-omap2/vc44xx_data.c
index 548cb06..a98da8d 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -30,7 +30,7 @@
  * VC data common to 44xx chips
  * XXX This stuff presumably belongs in the vc3xxx.c or vc.c file.
  */
-static const struct omap_vc_common_data omap4_vc_data = {
+static const struct omap_vc_common_data omap4_vc_common = {
 	.smps_sa_reg = OMAP4_PRM_VC_SMPS_SA_OFFSET,
 	.smps_volra_reg = OMAP4_PRM_VC_VAL_SMPS_RA_VOL_OFFSET,
 	.bypass_val_reg = OMAP4_PRM_VC_VAL_BYPASS_OFFSET,
@@ -47,6 +47,7 @@ static const struct omap_vc_common_data omap4_vc_data =
{

 /* VC instance data for each controllable voltage line */
 struct omap_vc_instance_data omap4_vc_mpu_data = {
+	.vc_common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
 	.smps_sa_shift = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_SHIFT,
 	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
@@ -55,6 +56,7 @@ struct omap_vc_instance_data omap4_vc_mpu_data = {
 };

 struct omap_vc_instance_data omap4_vc_iva_data = {
+	.vc_common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_IVA_L_OFFSET,
 	.smps_sa_shift = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_SHIFT,
 	.smps_sa_mask = OMAP4430_SA_VDD_IVA_L_PRM_VC_SMPS_SA_MASK,
@@ -63,6 +65,7 @@ struct omap_vc_instance_data omap4_vc_iva_data = {
 };

 struct omap_vc_instance_data omap4_vc_core_data = {
+	.vc_common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_CORE_L_OFFSET,
 	.smps_sa_shift = OMAP4430_SA_VDD_CORE_L_0_6_SHIFT,
 	.smps_sa_mask = OMAP4430_SA_VDD_CORE_L_0_6_MASK,
diff --git a/arch/arm/mach-omap2/vp44xx_data.c
b/arch/arm/mach-omap2/vp44xx_data.c
index 7b26f75..65d1ad6 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -31,7 +31,7 @@
  * VP data common to 44xx chips
  * XXX This stuff presumably belongs in the vp44xx.c or vp.c file.
  */
-static const struct omap_vp_common_data omap4_vp_data = {
+static const struct omap_vp_common_data omap4_vp_common = {
 	.vpconfig_erroroffset_shift = OMAP4430_ERROROFFSET_SHIFT,
 	.vpconfig_errorgain_mask = OMAP4430_ERRORGAIN_MASK,
 	.vpconfig_errorgain_shift = OMAP4430_ERRORGAIN_SHIFT,
@@ -56,6 +56,7 @@ static const struct omap_vp_prm_irqst_data
omap4_vp_mpu_prm_irqst_data = {
 };

 struct omap_vp_instance_data omap4_vp_mpu_data = {
+	.vp_common = &omap4_vp_common,
 	.vpconfig = OMAP4_PRM_VP_MPU_CONFIG_OFFSET,
 	.vstepmin = OMAP4_PRM_VP_MPU_VSTEPMIN_OFFSET,
 	.vstepmax = OMAP4_PRM_VP_MPU_VSTEPMAX_OFFSET,
@@ -71,6 +72,7 @@ static const struct omap_vp_prm_irqst_data
omap4_vp_iva_prm_irqst_data = {
 };

 struct omap_vp_instance_data omap4_vp_iva_data = {
+	.vp_common = &omap4_vp_common,
 	.vpconfig = OMAP4_PRM_VP_IVA_CONFIG_OFFSET,
 	.vstepmin = OMAP4_PRM_VP_IVA_VSTEPMIN_OFFSET,
 	.vstepmax = OMAP4_PRM_VP_IVA_VSTEPMAX_OFFSET,
@@ -86,6 +88,7 @@ static const struct omap_vp_prm_irqst_data
omap4_vp_core_prm_irqst_data = {
 };

 struct omap_vp_instance_data omap4_vp_core_data = {
+	.vp_common = &omap4_vp_common,
 	.vpconfig = OMAP4_PRM_VP_CORE_CONFIG_OFFSET,
 	.vstepmin = OMAP4_PRM_VP_CORE_VSTEPMIN_OFFSET,
 	.vstepmax = OMAP4_PRM_VP_CORE_VSTEPMAX_OFFSET,
-- 
1.7.0.4

>
> This series is available from git://git.pwsan.com/linux-2.6 in the
> 'voltage_split_2.6.39' branch.
>
>
> - Paul
>
>
> ---
>
> voltage_split_2.6.39
>    text	   data	    bss	    dec	    hex	filename
> 5766071	 488104	5596920	11851095	 b4d557
vmlinux.omap2plus_defconfig.orig
> 5765631	 487848	5596920	11850399	 b4d29f
vmlinux.omap2plus_defconfig
>
>
> Paul Walmsley (3):
>       OMAP: smartreflex: move plat/smartreflex.h to
mach-omap2/smartreflex.h
>       OMAP: voltage: move plat/voltage.h to mach-omap2/voltage.h
>       OMAP2+: voltage: reorganize, split code from data
>
>
>  arch/arm/mach-omap2/Makefile                  |   20
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2
>  arch/arm/mach-omap2/omap_opp_data.h           |   12
>  arch/arm/mach-omap2/omap_twl.c                |    2
>  arch/arm/mach-omap2/opp3xxx_data.c            |   44 +
>  arch/arm/mach-omap2/opp4xxx_data.c            |   30 +
>  arch/arm/mach-omap2/pm.c                      |    2
>  arch/arm/mach-omap2/smartreflex-class3.c      |    2
>  arch/arm/mach-omap2/smartreflex.c             |    2
>  arch/arm/mach-omap2/smartreflex.h             |    3
>  arch/arm/mach-omap2/sr_device.c               |    4
>  arch/arm/mach-omap2/vc.h                      |   83 ++
>  arch/arm/mach-omap2/vc3xxx_data.c             |   63 ++
>  arch/arm/mach-omap2/vc44xx_data.c             |   72 ++
>  arch/arm/mach-omap2/voltage.c                 | 1019
+++++++------------------
>  arch/arm/mach-omap2/voltage.h                 |   66 ++
>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |  104 +++
>  arch/arm/mach-omap2/voltagedomains44xx_data.c |  108 +++
>  arch/arm/mach-omap2/vp.h                      |  143 ++++
>  arch/arm/mach-omap2/vp3xxx_data.c             |   82 ++
>  arch/arm/mach-omap2/vp44xx_data.c             |   97 ++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1
>  22 files changed, 1203 insertions(+), 758 deletions(-)
>  rename arch/arm/{plat-omap/include/plat/smartreflex.h =>
mach-omap2/smartreflex.h} (99%)
>  create mode 100644 arch/arm/mach-omap2/vc.h
>  create mode 100644 arch/arm/mach-omap2/vc3xxx_data.c
>  create mode 100644 arch/arm/mach-omap2/vc44xx_data.c
>  rename arch/arm/{plat-omap/include/plat/voltage.h =>
mach-omap2/voltage.h} (68%)
>  create mode 100644 arch/arm/mach-omap2/voltagedomains3xxx_data.c
>  create mode 100644 arch/arm/mach-omap2/voltagedomains44xx_data.c
>  create mode 100644 arch/arm/mach-omap2/vp.h
>  create mode 100644 arch/arm/mach-omap2/vp3xxx_data.c
>  create mode 100644 arch/arm/mach-omap2/vp44xx_data.c
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--20cf30433eeccc95c2049d05ecaa
Content-Type: application/octet-stream;
	name="0001-OMAP4-voltage-Populate-missing-.vp-.vc_common-pointe.patch"
Content-Disposition: attachment;
	filename="0001-OMAP4-voltage-Populate-missing-.vp-.vc_common-pointe.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1b3fedf59da6051c_0.1

RnJvbSBlM2Q1ZTJiYjA5ZWNiN2E5NThjMWY3OWI4NmQxOTE3ZjBiZWNiOGQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWplbmRyYSBOYXlhayA8cm5heWFrQHRpLmNvbT4KRGF0ZTog
VGh1LCAyNCBGZWIgMjAxMSAxNjo0MjoyNSArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIE9NQVA0OiB2
b2x0YWdlOiBQb3B1bGF0ZSBtaXNzaW5nIC52cC8udmNfY29tbW9uIHBvaW50ZXJzCgpUaGUgY29t
bW9uX2RhdGEgZm9yIHZwIGFuZCB2YyBvbiBPTUFQNCBpcyBkZWZpbmVkCmJ1dCBub3QgaG9va2Vk
IHVwIHdpdGggdGhlIGNvcnJlc3BvbmRpbmcKdnAvdmNfZGF0YS4KVGhpcyBjYXVzZXMgYW4gYWJv
cnQgYXQgYm9vdHVwIG9uIE9NQVA0LCBhcyB0aGUKZnJhbWV3b3JrIGFwaSdzIGFzc3VtZXMgdGhl
c2UgdG8gYmUgcHJlc2VudC4KCldoaWxlIGhlcmUsIGFsc28gcmVuYW1lIG9tYXA0X3ZwX2RhdGEg
dG8Kb21hcDRfdnBfY29tbW9uIGFuZCBvbWFwNF92Y19kYXRhIHRvCm9tYXA0X3ZjX2NvbW1vbiB0
byBtYWludGFpbiBjb25zaXN0ZW5jeSBpbgpuYW1pbmcgc3RydWN0cyBhY3Jvc3MgYWxsIE9NQVBz
LgoKU2lnbmVkLW9mZi1ieTogUmFqZW5kcmEgTmF5YWsgPHJuYXlha0B0aS5jb20+Ci0tLQogYXJj
aC9hcm0vbWFjaC1vbWFwMi92YzQ0eHhfZGF0YS5jIHwgICAgNSArKysrLQogYXJjaC9hcm0vbWFj
aC1vbWFwMi92cDQ0eHhfZGF0YS5jIHwgICAgNSArKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1v
bWFwMi92YzQ0eHhfZGF0YS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi92YzQ0eHhfZGF0YS5jCmlu
ZGV4IDU0OGNiMDYuLmE5OGRhOGQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvdmM0
NHh4X2RhdGEuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3ZjNDR4eF9kYXRhLmMKQEAgLTMw
LDcgKzMwLDcgQEAKICAqIFZDIGRhdGEgY29tbW9uIHRvIDQ0eHggY2hpcHMKICAqIFhYWCBUaGlz
IHN0dWZmIHByZXN1bWFibHkgYmVsb25ncyBpbiB0aGUgdmMzeHh4LmMgb3IgdmMuYyBmaWxlLgog
ICovCi1zdGF0aWMgY29uc3Qgc3RydWN0IG9tYXBfdmNfY29tbW9uX2RhdGEgb21hcDRfdmNfZGF0
YSA9IHsKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb21hcF92Y19jb21tb25fZGF0YSBvbWFwNF92Y19j
b21tb24gPSB7CiAJLnNtcHNfc2FfcmVnID0gT01BUDRfUFJNX1ZDX1NNUFNfU0FfT0ZGU0VULAog
CS5zbXBzX3ZvbHJhX3JlZyA9IE9NQVA0X1BSTV9WQ19WQUxfU01QU19SQV9WT0xfT0ZGU0VULAog
CS5ieXBhc3NfdmFsX3JlZyA9IE9NQVA0X1BSTV9WQ19WQUxfQllQQVNTX09GRlNFVCwKQEAgLTQ3
LDYgKzQ3LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvbWFwX3ZjX2NvbW1vbl9kYXRhIG9tYXA0
X3ZjX2RhdGEgPSB7CiAKIC8qIFZDIGluc3RhbmNlIGRhdGEgZm9yIGVhY2ggY29udHJvbGxhYmxl
IHZvbHRhZ2UgbGluZSAqLwogc3RydWN0IG9tYXBfdmNfaW5zdGFuY2VfZGF0YSBvbWFwNF92Y19t
cHVfZGF0YSA9IHsKKwkudmNfY29tbW9uID0gJm9tYXA0X3ZjX2NvbW1vbiwKIAkuY21kdmFsX3Jl
ZyA9IE9NQVA0X1BSTV9WQ19WQUxfQ01EX1ZERF9NUFVfTF9PRkZTRVQsCiAJLnNtcHNfc2Ffc2hp
ZnQgPSBPTUFQNDQzMF9TQV9WRERfTVBVX0xfUFJNX1ZDX1NNUFNfU0FfU0hJRlQsCiAJLnNtcHNf
c2FfbWFzayA9IE9NQVA0NDMwX1NBX1ZERF9NUFVfTF9QUk1fVkNfU01QU19TQV9NQVNLLApAQCAt
NTUsNiArNTYsNyBAQCBzdHJ1Y3Qgb21hcF92Y19pbnN0YW5jZV9kYXRhIG9tYXA0X3ZjX21wdV9k
YXRhID0gewogfTsKIAogc3RydWN0IG9tYXBfdmNfaW5zdGFuY2VfZGF0YSBvbWFwNF92Y19pdmFf
ZGF0YSA9IHsKKwkudmNfY29tbW9uID0gJm9tYXA0X3ZjX2NvbW1vbiwKIAkuY21kdmFsX3JlZyA9
IE9NQVA0X1BSTV9WQ19WQUxfQ01EX1ZERF9JVkFfTF9PRkZTRVQsCiAJLnNtcHNfc2Ffc2hpZnQg
PSBPTUFQNDQzMF9TQV9WRERfSVZBX0xfUFJNX1ZDX1NNUFNfU0FfU0hJRlQsCiAJLnNtcHNfc2Ff
bWFzayA9IE9NQVA0NDMwX1NBX1ZERF9JVkFfTF9QUk1fVkNfU01QU19TQV9NQVNLLApAQCAtNjMs
NiArNjUsNyBAQCBzdHJ1Y3Qgb21hcF92Y19pbnN0YW5jZV9kYXRhIG9tYXA0X3ZjX2l2YV9kYXRh
ID0gewogfTsKIAogc3RydWN0IG9tYXBfdmNfaW5zdGFuY2VfZGF0YSBvbWFwNF92Y19jb3JlX2Rh
dGEgPSB7CisJLnZjX2NvbW1vbiA9ICZvbWFwNF92Y19jb21tb24sCiAJLmNtZHZhbF9yZWcgPSBP
TUFQNF9QUk1fVkNfVkFMX0NNRF9WRERfQ09SRV9MX09GRlNFVCwKIAkuc21wc19zYV9zaGlmdCA9
IE9NQVA0NDMwX1NBX1ZERF9DT1JFX0xfMF82X1NISUZULAogCS5zbXBzX3NhX21hc2sgPSBPTUFQ
NDQzMF9TQV9WRERfQ09SRV9MXzBfNl9NQVNLLApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1v
bWFwMi92cDQ0eHhfZGF0YS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi92cDQ0eHhfZGF0YS5jCmlu
ZGV4IDdiMjZmNzUuLjY1ZDFhZDYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvdnA0
NHh4X2RhdGEuYworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3ZwNDR4eF9kYXRhLmMKQEAgLTMx
LDcgKzMxLDcgQEAKICAqIFZQIGRhdGEgY29tbW9uIHRvIDQ0eHggY2hpcHMKICAqIFhYWCBUaGlz
IHN0dWZmIHByZXN1bWFibHkgYmVsb25ncyBpbiB0aGUgdnA0NHh4LmMgb3IgdnAuYyBmaWxlLgog
ICovCi1zdGF0aWMgY29uc3Qgc3RydWN0IG9tYXBfdnBfY29tbW9uX2RhdGEgb21hcDRfdnBfZGF0
YSA9IHsKK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb21hcF92cF9jb21tb25fZGF0YSBvbWFwNF92cF9j
b21tb24gPSB7CiAJLnZwY29uZmlnX2Vycm9yb2Zmc2V0X3NoaWZ0ID0gT01BUDQ0MzBfRVJST1JP
RkZTRVRfU0hJRlQsCiAJLnZwY29uZmlnX2Vycm9yZ2Fpbl9tYXNrID0gT01BUDQ0MzBfRVJST1JH
QUlOX01BU0ssCiAJLnZwY29uZmlnX2Vycm9yZ2Fpbl9zaGlmdCA9IE9NQVA0NDMwX0VSUk9SR0FJ
Tl9TSElGVCwKQEAgLTU2LDYgKzU2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvbWFwX3ZwX3By
bV9pcnFzdF9kYXRhIG9tYXA0X3ZwX21wdV9wcm1faXJxc3RfZGF0YSA9IHsKIH07CiAKIHN0cnVj
dCBvbWFwX3ZwX2luc3RhbmNlX2RhdGEgb21hcDRfdnBfbXB1X2RhdGEgPSB7CisJLnZwX2NvbW1v
biA9ICZvbWFwNF92cF9jb21tb24sCiAJLnZwY29uZmlnID0gT01BUDRfUFJNX1ZQX01QVV9DT05G
SUdfT0ZGU0VULAogCS52c3RlcG1pbiA9IE9NQVA0X1BSTV9WUF9NUFVfVlNURVBNSU5fT0ZGU0VU
LAogCS52c3RlcG1heCA9IE9NQVA0X1BSTV9WUF9NUFVfVlNURVBNQVhfT0ZGU0VULApAQCAtNzEs
NiArNzIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9tYXBfdnBfcHJtX2lycXN0X2RhdGEgb21h
cDRfdnBfaXZhX3BybV9pcnFzdF9kYXRhID0gewogfTsKIAogc3RydWN0IG9tYXBfdnBfaW5zdGFu
Y2VfZGF0YSBvbWFwNF92cF9pdmFfZGF0YSA9IHsKKwkudnBfY29tbW9uID0gJm9tYXA0X3ZwX2Nv
bW1vbiwKIAkudnBjb25maWcgPSBPTUFQNF9QUk1fVlBfSVZBX0NPTkZJR19PRkZTRVQsCiAJLnZz
dGVwbWluID0gT01BUDRfUFJNX1ZQX0lWQV9WU1RFUE1JTl9PRkZTRVQsCiAJLnZzdGVwbWF4ID0g
T01BUDRfUFJNX1ZQX0lWQV9WU1RFUE1BWF9PRkZTRVQsCkBAIC04Niw2ICs4OCw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb21hcF92cF9wcm1faXJxc3RfZGF0YSBvbWFwNF92cF9jb3JlX3BybV9p
cnFzdF9kYXRhID0gewogfTsKIAogc3RydWN0IG9tYXBfdnBfaW5zdGFuY2VfZGF0YSBvbWFwNF92
cF9jb3JlX2RhdGEgPSB7CisJLnZwX2NvbW1vbiA9ICZvbWFwNF92cF9jb21tb24sCiAJLnZwY29u
ZmlnID0gT01BUDRfUFJNX1ZQX0NPUkVfQ09ORklHX09GRlNFVCwKIAkudnN0ZXBtaW4gPSBPTUFQ
NF9QUk1fVlBfQ09SRV9WU1RFUE1JTl9PRkZTRVQsCiAJLnZzdGVwbWF4ID0gT01BUDRfUFJNX1ZQ
X0NPUkVfVlNURVBNQVhfT0ZGU0VULAotLSAKMS43LjAuNAoK
--20cf30433eeccc95c2049d05ecaa--
