From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 16:54:46 +0300 (EEST)
Message-ID: <20090518.165446.232765807.Hiroshi.DOYU@nokia.com>
References: <1242468350-23190-4-git-send-email-felipe.contreras@gmail.com>
	<20090518121113.GB3067@n2100.arm.linux.org.uk>
	<20090518.163533.28796680.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Mon_May_18_16_54_46_2009_541)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42142 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbZERNzk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:55:40 -0400
In-Reply-To: <20090518.163533.28796680.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: felipe.contreras@gmail.com, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

----Next_Part(Mon_May_18_16_54_46_2009_541)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 16:35:33 +0300 (EEST)

> From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
> Date: Mon, 18 May 2009 14:11:13 +0200
> 
> > On Sat, May 16, 2009 at 01:05:50PM +0300, Felipe Contreras wrote:
> > > This allows devices to be registered only when they are used. The
> > > current dsp-bridge driver for example is not using iommu so registering
> > > the iommu iva2 device would conflict. By allowing remote registration
> > > the dsp-bridge can decide when the iommu iva2 device is registered.
> > 
> > I don't think that this is a good idea - what happens if two people
> > call omap_iommu_add() for the same IOMMU device independently?
> > 
> > The real problem here seems to be the TI DSP bridge code, and if that's
> > the case why can't we just avoid registering IVA2 if the TI DSP bridge
> > code is enabled.  That solves your stated problem without creating
> > additional management issues.
> 
> How about the attached patch? I think this is enough.

Oops, CONFIG_NAME was wrong. Attached new one.


----Next_Part(Mon_May_18_16_54_46_2009_541)--
Content-Type: Application/Octet-Stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-omap-iommu-disable-iva2-iommu-device-registration-i.patch"

RnJvbSAzNzg4NmQzZDg1ZDNiNDJiNjJlZGFhN2ZhYzIyZTAwMTg5NWI3NjE3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIaXJvc2hpIERPWVUgPEhpcm9zaGkuRE9ZVUBub2tpYS5jb20+
CkRhdGU6IE1vbiwgMTggTWF5IDIwMDkgMTY6MzE6MzUgKzAzMDAKU3ViamVjdDogW1BBVENIIDEv
MV0gb21hcCBpb21tdTogZGlzYWJsZSBpdmEyIGlvbW11IGRldmljZSByZWdpc3RyYXRpb24gaWYg
dGlkc3BicmlkZ2UgZW5hYmxlZAoKdGlkc3BicmlkZ2Ugd2lsbCB1c2Ugb21hcCBpb21tdSBldmVu
dHVhbGx5LiBVbnRpbCBpdCdzIHJlYWR5LCBkaXNhYmxlIGl0LgoKU2lnbmVkLW9mZi1ieTogSGly
b3NoaSBET1lVIDxIaXJvc2hpLkRPWVVAbm9raWEuY29tPgotLS0KIGFyY2gvYXJtL21hY2gtb21h
cDIvb21hcDMtaW9tbXUuYyB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvb21h
cDMtaW9tbXUuYyBiL2FyY2gvYXJtL21hY2gtb21hcDIvb21hcDMtaW9tbXUuYwppbmRleCA5MWVl
MzhhLi43ZmQ4ZTRlIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL29tYXAzLWlvbW11
LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9vbWFwMy1pb21tdS5jCkBAIC0zNiwxMSArMzYs
MTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpb21tdV9wbGF0Zm9ybV9kYXRhIG9tYXAzX2lvbW11
X3BkYXRhW10gX19pbml0Y29uc3QgPSB7CiAJCS5ucl90bGJfZW50cmllcyA9IDgsCiAJCS5jbGtf
bmFtZSA9ICJjYW1faWNrIiwKIAl9LAorI2lmICFkZWZpbmVkKENPTkZJR19NUFVfQlJJREdFKSAm
JiAhZGVmaW5lZChDT05GSUdfTVBVX0JSSURHRV9NT0RVTEUpCiAJewogCQkubmFtZSA9ICJpdmEy
IiwKIAkJLm5yX3RsYl9lbnRyaWVzID0gMzIsCiAJCS5jbGtfbmFtZSA9ICJpdmEyX2NrIiwKIAl9
LAorI2VuZGlmCiB9OwogI2RlZmluZSBOUl9JT01NVV9ERVZJQ0VTIEFSUkFZX1NJWkUob21hcDNf
aW9tbXVfcGRhdGEpCiAKLS0gCjEuNi4wLjQKCg==

----Next_Part(Mon_May_18_16_54_46_2009_541)----
