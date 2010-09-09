From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/7] omap4: Temporary fix silicon version detection
Date: Thu, 9 Sep 2010 18:54:12 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD17ED7D@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
 <20100909114255.GK21060@legolas.emea.dhcp.ti.com> <4C88C940.6070000@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD0D3A37@dbde02.ent.ti.com>
 <20100909120746.GB17000@legolas.emea.dhcp.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CD17ED5E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD17ED7Ddbde02enttico_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48255 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab0IINYT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 09:24:19 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD17ED5E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Balbi, Felipe" <balbi@ti.com>

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD17ED7Ddbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Thursday, September 09, 2010 6:32 PM
> To: Balbi, Felipe
> Cc: Cousson, Benoit; linux-omap@vger.kernel.org; tony@atomide.com;
> khilman@deeprootsystems.com
> Subject: RE: [PATCH 2/7] omap4: Temporary fix silicon version detection
>=20
> > -----Original Message-----
> > From: Balbi, Felipe
> > Sent: Thursday, September 09, 2010 5:38 PM
> > To: Shilimkar, Santosh
> > Cc: Cousson, Benoit; Balbi, Felipe; linux-omap@vger.kernel.org;
> > tony@atomide.com; khilman@deeprootsystems.com
> > Subject: Re: [PATCH 2/7] omap4: Temporary fix silicon version detection
> >
> > Hi Santosh,
> >
> > On Thu, Sep 09, 2010 at 07:02:46AM -0500, Shilimkar, Santosh wrote:
> > >Felipe is suggesting not to add this support where as you want to
> > >have this support.
> > >
> > >Sorry if I haven't understood the comment. Care to clarify
> >
> > no, I suggested not to revert :-) So, just change the comment saying wh=
y
> > you need that extra check and remove the "this patch should be reverted
> > later" part :-)
> >
> Ok. I agree. We can actually keep this code.
>=20
> Will change the comment and send V2
>=20
Updated version attached.=20

Regards,
Santosh

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD17ED7Ddbde02enttico_
Content-Type: application/octet-stream;
	name="0002-omap4-Fix-silicon-version-detection-for-early-sampl.patch"
Content-Description: 0002-omap4-Fix-silicon-version-detection-for-early-sampl.patch
Content-Disposition: attachment;
	filename="0002-omap4-Fix-silicon-version-detection-for-early-sampl.patch";
	size=1093; creation-date="Thu, 09 Sep 2010 19:00:58 GMT";
	modification-date="Thu, 09 Sep 2010 19:00:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1NGFjZDZlMjc4ZmQ1OGExMTlhMjM4Yjk4MjE2MDRlN2EzMjk5NDkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBUaHUsIDkgU2VwIDIwMTAgMTM6MTE6MTIgKzA1MzAKU3ViamVjdDogW1BB
VENIIDIvNyB2Ml0gb21hcDQ6IEZpeCBzaWxpY29uIHZlcnNpb24gZGV0ZWN0aW9uIGZvciBlYXJs
eSBzYW1wbGVzCgpGZXcgaW5pdGlhbCBvbWFwNCBlczIgc2FtcGxlcyBJRENPREUgaXMgc2FtZSBh
cyBlczEuIFRoaXMgcGF0Y2gKdXNlcyBBUk0gY3B1aWQgcmVnaXN0ZXIgdG8gZGV0ZWN0IHRoZSBF
UyB2ZXJzaW9uIGZvciBzdWNoIHNhbXBsZXMKClNpZ25lZC1vZmYtYnk6IFNhbnRvc2ggU2hpbGlt
a2FyIDxzYW50b3NoLnNoaWxpbWthckB0aS5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMi9p
ZC5jIHwgICAgOSArKysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAw
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvaWQuYyBiL2Fy
Y2gvYXJtL21hY2gtb21hcDIvaWQuYwppbmRleCBhNDIzYzdmLi45MWQ3ZGY0IDEwMDY0NAotLS0g
YS9hcmNoL2FybS9tYWNoLW9tYXAyL2lkLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9pZC5j
CkBAIC0zMDgsNiArMzA4LDE1IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBvbWFwNF9jaGVja19yZXZp
c2lvbih2b2lkKQogCWhhd2tleWUgPSAoaWRjb2RlID4+IDEyKSAmIDB4ZmZmZjsKIAlyZXYgPSAo
aWRjb2RlID4+IDI4KSAmIDB4ZmY7CiAKKwkvKgorCSAqIEZldyBpbml0aWFsIEVTMi4wIHNhbXBs
ZXMgSURDT0RFIGlzIHNhbWUgYXMgRVMxLjAKKwkgKiBVc2UgQVJNIHJlZ2lzdGVyIHRvIGRldGVj
dCB0aGUgY29ycmVjdCBFUyB2ZXJzaW9uCisJICovCisJaWYgKCFyZXYpIHsKKwkJaWRjb2RlID0g
cmVhZF9jcHVpZChDUFVJRF9JRCk7CisJCXJldiA9IChpZGNvZGUgJiAweGYpIC0gMTsKKwl9CisK
IAlzd2l0Y2ggKGhhd2tleWUpIHsKIAljYXNlIDB4Yjg1MjoKIAkJc3dpdGNoIChyZXYpIHsKLS0g
CjEuNi4wLjQKCg==

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD17ED7Ddbde02enttico_--
