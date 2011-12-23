From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 23 Dec 2011 14:15:21 +0530
Message-ID: <CAMQu2gwKgpH_dOBQovgxBR_yTGAiXu=2yPhwgoERv+YD+pO_Sg@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
 <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
 <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
 <CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com> <CACVXFVOOQVe8u5TFZDYrNqvga-=RJ1mueaaqkBNB-s4BwkhiOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00248c70fe793b7c4804b4be7199
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53347 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751680Ab1LWIpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Dec 2011 03:45:45 -0500
Received: by qcha6 with SMTP id a6so5704876qch.12
        for <linux-omap@vger.kernel.org>; Fri, 23 Dec 2011 00:45:43 -0800 (PST)
In-Reply-To: <CACVXFVOOQVe8u5TFZDYrNqvga-=RJ1mueaaqkBNB-s4BwkhiOw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>, Miguel Vadillo <vadillo@ti.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

--00248c70fe793b7c4804b4be7199
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2011 at 2:00 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Hi Shilimkar,
>
> Sorry for the delay.
>
> On Mon, Dec 19, 2011 at 2:17 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>
>> The patches are fine but I am surprised that 'dyndep.patch' is helping y=
ou.
>> L3_2 dependency is always enabled with ISS or Camera and it
>> should have worked.
>> clkdm_add_wkdep(iss_clkdm, l3_2_clkdm), shoudn't do anything since
>> the bit is read-only.
>
> Yes, you are right. After some investigating, I found that
> clkdm_add_wkdep(iss_clkdm, l3_2_clkdm) returns failure, so clkdms_setup
> is bypassed and the issue is avoided.
>
Good.

>>
>> Can you check value of CM_CAM_STATICDEP [ 0x4A009004],
>
> The value is 0x40 after and before the patch.
>
>> after your patch. I am suspecting that for some reason l3_1 dep.
>> is getting enabled which might be helping your case.
>
> Seems no changes after adding clkdm_add_wkdep(iss_clkdm, l3_1_clkdm)
> on the problem.
>
> The only change on iss(CAM) clock domain setting in your commit[1] is to
> configure CLKTRCTRL as HW_AUTO, instead of previous =A0SW_WKUP.
> Once I change flags of iss to CLKDM_CAN_SWSUP [2], the issue can be
> fixed, so I am wondering if something is wrong about HW_AUTO mode
> of CAM clock domain.
>
Now I recollect the issue and also track a patch in the internal product tr=
ee.
Same is attached and also in the end of the email.

I am lopping Miguel who wrote the patch and Benoit who acked it.
This should sort out your issue as you have already verified it works.

Regards
Santosh

>From 972d7bb544d3197d7fc1a6c6eb0e2c9cc08d5e9d Mon Sep 17 00:00:00 2001
From: Miguel Vadillo <vadillo@ti.com>
Date: Tue, 21 Jun 2011 09:59:45 -0500
Subject: [PATCH 1/2] OMAP: clockdomain: set iss clk domain to just SWSUP

Since CAM domain(ISS) has no module wake-up dependency
with any other clock domain of the device and the dynamic
dependency from L3_main_2 is always disabled, the domain
needs to be in force wakeup in order to be able to access
it for configure(sysconfig) it or use it.

Also since there is no clock in the domain managed automatically
by the hardware, there is no use to configure automatic
clock domain transition. SW should keep the SW_WKUP domain
transition as long as a module in the domain is required to
be functional.

Signed-off-by: Miguel Vadillo <vadillo@ti.com>
Acked-by: Benoit Cousson<b-cousson@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 6ac8fe2..8d1a061 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -605,7 +605,7 @@ static struct clockdomain iss_44xx_clkdm =3D {
 	.clkdm_offs	  =3D OMAP4430_CM2_CAM_CAM_CDOFFS,
 	.wkdep_srcs	  =3D iss_wkup_sleep_deps,
 	.sleepdep_srcs	  =3D iss_wkup_sleep_deps,
-	.flags		  =3D CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  =3D CLKDM_CAN_SWSUP,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
 };

--=20
1.7.4.1

--00248c70fe793b7c4804b4be7199
Content-Type: application/octet-stream;
	name="0001-OMAP-clockdomain-set-iss-clk-domain-to-just-SWSUP.patch"
Content-Disposition: attachment;
	filename="0001-OMAP-clockdomain-set-iss-clk-domain-to-just-SWSUP.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gwiyf18z0

RnJvbSA5NzJkN2JiNTQ0ZDMxOTdkN2ZjMWE2YzZlYjBlMmM5Y2MwOGQ1ZTlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWd1ZWwgVmFkaWxsbyA8dmFkaWxsb0B0aS5jb20+CkRhdGU6
IFR1ZSwgMjEgSnVuIDIwMTEgMDk6NTk6NDUgLTA1MDAKU3ViamVjdDogW1BBVENIIDEvMl0gT01B
UDogY2xvY2tkb21haW46IHNldCBpc3MgY2xrIGRvbWFpbiB0byBqdXN0IFNXU1VQCgpTaW5jZSBD
QU0gZG9tYWluKElTUykgaGFzIG5vIG1vZHVsZSB3YWtlLXVwIGRlcGVuZGVuY3kKd2l0aCBhbnkg
b3RoZXIgY2xvY2sgZG9tYWluIG9mIHRoZSBkZXZpY2UgYW5kIHRoZSBkeW5hbWljCmRlcGVuZGVu
Y3kgZnJvbSBMM19tYWluXzIgaXMgYWx3YXlzIGRpc2FibGVkLCB0aGUgZG9tYWluCm5lZWRzIHRv
IGJlIGluIGZvcmNlIHdha2V1cCBpbiBvcmRlciB0byBiZSBhYmxlIHRvIGFjY2VzcwppdCBmb3Ig
Y29uZmlndXJlKHN5c2NvbmZpZykgaXQgb3IgdXNlIGl0LgoKQWxzbyBzaW5jZSB0aGVyZSBpcyBu
byBjbG9jayBpbiB0aGUgZG9tYWluIG1hbmFnZWQgYXV0b21hdGljYWxseQpieSB0aGUgaGFyZHdh
cmUsIHRoZXJlIGlzIG5vIHVzZSB0byBjb25maWd1cmUgYXV0b21hdGljCmNsb2NrIGRvbWFpbiB0
cmFuc2l0aW9uLiBTVyBzaG91bGQga2VlcCB0aGUgU1dfV0tVUCBkb21haW4KdHJhbnNpdGlvbiBh
cyBsb25nIGFzIGEgbW9kdWxlIGluIHRoZSBkb21haW4gaXMgcmVxdWlyZWQgdG8KYmUgZnVuY3Rp
b25hbC4KClNpZ25lZC1vZmYtYnk6IE1pZ3VlbCBWYWRpbGxvIDx2YWRpbGxvQHRpLmNvbT4KQWNr
ZWQtYnk6IEJlbm9pdCBDb3Vzc29uPGItY291c3NvbkB0aS5jb20+Ci0tLQogYXJjaC9hcm0vbWFj
aC1vbWFwMi9jbG9ja2RvbWFpbnM0NHh4X2RhdGEuYyB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtb21hcDIvY2xvY2tkb21haW5zNDR4eF9kYXRhLmMgYi9hcmNoL2FybS9tYWNoLW9tYXAy
L2Nsb2NrZG9tYWluczQ0eHhfZGF0YS5jCmluZGV4IDZhYzhmZTIuLjhkMWEwNjEgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL21hY2gtb21hcDIvY2xvY2tkb21haW5zNDR4eF9kYXRhLmMKKysrIGIvYXJj
aC9hcm0vbWFjaC1vbWFwMi9jbG9ja2RvbWFpbnM0NHh4X2RhdGEuYwpAQCAtNjA1LDcgKzYwNSw3
IEBAIHN0YXRpYyBzdHJ1Y3QgY2xvY2tkb21haW4gaXNzXzQ0eHhfY2xrZG0gPSB7CiAJLmNsa2Rt
X29mZnMJICA9IE9NQVA0NDMwX0NNMl9DQU1fQ0FNX0NET0ZGUywKIAkud2tkZXBfc3JjcwkgID0g
aXNzX3drdXBfc2xlZXBfZGVwcywKIAkuc2xlZXBkZXBfc3JjcwkgID0gaXNzX3drdXBfc2xlZXBf
ZGVwcywKLQkuZmxhZ3MJCSAgPSBDTEtETV9DQU5fSFdTVVBfU1dTVVAsCisJLmZsYWdzCQkgID0g
Q0xLRE1fQ0FOX1NXU1VQLAogCS5vbWFwX2NoaXAJICA9IE9NQVBfQ0hJUF9JTklUKENISVBfSVNf
T01BUDQ0WFgpLAogfTsKIAotLSAKMS43LjQuMQoK
--00248c70fe793b7c4804b4be7199--
