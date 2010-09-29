From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 05/11] omap3: Remove non-existent config option
Date: Wed, 29 Sep 2010 22:12:24 +0300
Message-ID: <AANLkTinZqx2nFuoYoCYpD4+PG7_J=ACLBxAwOvpVm4c9@mail.gmail.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
	<AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233C361B4@dbde02.ent.ti.com>
	<AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E5F6A365B@dlee03.ent.ti.com>
	<AANLkTimD_MRbuTnBMPzAKPTmrDwjLkLVmr9bTSNROb5L@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234006B4C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368e224bd9269904916abdd8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53743 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab0I2TM0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 15:12:26 -0400
Received: by bwz11 with SMTP id 11so816078bwz.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 12:12:24 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930234006B4C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Marathe, Yogesh" <yogesh_marathe@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--0016368e224bd9269904916abdd8
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 29, 2010 at 4:28 PM, Marathe, Yogesh <yogesh_marathe@ti.com> wrote:
> dsplink and syslink (two drivers who use iommu) should not enable
> CONFIG_MPU_BRIDGE_IOMMU as dspbridge and dsplink /syslink
> can not co-exist as they are using same resources. Not applying patch
> breaks dsplink/sylink any one which is being used. Defining this config
> makes them co-exist.

No, for dsp-link you would have:
CONFIG_TIDSPBRIDGE=n
CONFIG_OMAP_IOMMU_IVA2=y

It would be exactly the same as applying your patch.

And tidspbridge is not using iommu right now.

And AFAIK syslink is not for omap3, so omap3_devices is not relevant.

> I'm ok with changing name to CONFIG_OMAP_IOMMU_IVA2 but ideally
> then that will also break the dspbridge.

No, grep for MPU_BRIDGE_IOMMU on the current tidspbridge in mainline;
it's not defined anywhere, so CONFIG_OMAP_IOMMU_IVA2, or
CONFIG_FOOBAR, it doesn't matter for tidspbridge right now. And
MPU_BRIDGE_IOMMU doesn't depend on tidspbridge on any way.

> One more way would be to soure revert the patch and apply on dspbridge branch if it breaks the builds on that branch rather than
> breaking others in master.

There is no tidspbrige branch; it's in mainline:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=drivers/staging/tidspbridge

But that doesn't matter, even if it was in a branch, iommu should not
break either tidspbridge, or dsp-link, and driver branches should not
modify anything outside their domain (ideally).

All you need to do is 'select OMAP_IOMMU_IVA2', although the attached
patch would be needed.

-- 
Felipe Contreras

--0016368e224bd9269904916abdd8
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-omap-iommu-make-iva2-iommu-selectable.patch"
Content-Disposition: attachment;
	filename="0001-omap-iommu-make-iva2-iommu-selectable.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_geokmwdu0

RnJvbSAyNzk1OTQ4ZjExY2IyMThlYjdmNGJlMjZmZDc0NzcyN2JhNWMzMWRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQG5v
a2lhLmNvbT4KRGF0ZTogV2VkLCAyOSBTZXAgMjAxMCAyMjowNTo0NiArMDMwMApTdWJqZWN0OiBb
UEFUQ0hdIG9tYXA6IGlvbW11OiBtYWtlIGl2YTIgaW9tbXUgc2VsZWN0YWJsZQoKSXQgc2VlbXMg
ZHNwLWxpbmsgd2lsbCBkbyB0aGlzLCBhbmQgdGlkc3BicmlkZ2UgdG9vIGF0IHNvbWUgcG9pbnQs
IGJ1dApyaWdodCBub3cgaXQncyBub3QgcG9zc2libGUgdG8gc2VsZWN0IENPTkZJR19NUFVfQlJJ
REdFX0lPTU1VLgoKU2lnbmVkLW9mZi1ieTogRmVsaXBlIENvbnRyZXJhcyA8ZmVsaXBlLmNvbnRy
ZXJhc0Bub2tpYS5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwLWlvbW11LmMgfCAg
ICAyICstCiBhcmNoL2FybS9wbGF0LW9tYXAvS2NvbmZpZyAgICAgICB8ICAgIDMgKysrCiAyIGZp
bGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXAtaW9tbXUuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIv
b21hcC1pb21tdS5jCmluZGV4IGY1YTFhYWQuLmFkYzA5MDQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJt
L21hY2gtb21hcDIvb21hcC1pb21tdS5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcC1p
b21tdS5jCkBAIC0zNSw3ICszNSw3IEBAIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZGV2aWNlIG9tYXAz
X2RldmljZXNbXSA9IHsKIAkJCS5jbGtfbmFtZSA9ICJjYW1faWNrIiwKIAkJfSwKIAl9LAotI2lm
IGRlZmluZWQoQ09ORklHX01QVV9CUklER0VfSU9NTVUpCisjaWYgZGVmaW5lZChDT05GSUdfT01B
UF9JT01NVV9JVkEyKQogCXsKIAkJLmJhc2UgPSAweDVkMDAwMDAwLAogCQkuaXJxID0gMjgsCmRp
ZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvS2NvbmZpZyBiL2FyY2gvYXJtL3BsYXQtb21h
cC9LY29uZmlnCmluZGV4IGUzOWE0MTcuLmUwYjQxYjYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3Bs
YXQtb21hcC9LY29uZmlnCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9LY29uZmlnCkBAIC0xMDks
NiArMTA5LDkgQEAgY29uZmlnIE9NQVBfSU9NTVVfREVCVUcKIAogICAgICAgICAgU2F5IE4gdW5s
ZXNzIHlvdSBrbm93IHlvdSBuZWVkIHRoaXMuCiAKK2NvbmZpZyBPTUFQX0lPTU1VX0lWQTIKKwli
b29sCisKIGNob2ljZQogCXByb21wdCAiU3lzdGVtIHRpbWVyIgogCWRlZmF1bHQgT01BUF8zMktf
VElNRVIgaWYgIUFSQ0hfT01BUDE1WFgKLS0gCjEuNy4zLjIuZzllNjA1Cgo=
--0016368e224bd9269904916abdd8--
