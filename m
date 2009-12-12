From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: Conflict in irqs.h
Date: Fri, 11 Dec 2009 19:09:11 -0600
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B88A174F9@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_2256F256009DAA4CBE661E9F41EAC84B88A174F9dlee01entticom_"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47684 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762750AbZLLBJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 20:09:07 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBC19ERJ020463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 19:09:14 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id nBC19Elj011242
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 19:09:14 -0600 (CST)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBC19DtT025625
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 19:09:13 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--_002_2256F256009DAA4CBE661E9F41EAC84B88A174F9dlee01entticom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to get some patches pushed upstream. These patches are for OMAP=
4 McPDM driver and concern both linux-omap and alsa trees IMO. One of the p=
atches (attached) modifies irqs.h to add McPDM irq number. The problem is i=
rqs.h file is in a different path and the patches apply differently in each=
 tree.

I was planning on sending the set to both alsa and linux-omap list, but the=
re will be a conflict for your linux-omap tree. Is there a procedure to fol=
low in these cases?

I have also considered sending two different sets of patches individually: =
one to you and the other to Mark Brown.=20

Can you advice?

Thanks,
Jorge=

--_002_2256F256009DAA4CBE661E9F41EAC84B88A174F9dlee01entticom_
Content-Type: application/octet-stream;
	name="0001-OMAP4-IRQ-Add-McPDM-IRQ-definition.patch"
Content-Description: 0001-OMAP4-IRQ-Add-McPDM-IRQ-definition.patch
Content-Disposition: attachment;
	filename="0001-OMAP4-IRQ-Add-McPDM-IRQ-definition.patch"; size=945;
	creation-date="Fri, 11 Dec 2009 17:12:53 GMT";
	modification-date="Fri, 11 Dec 2009 17:12:53 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4ZTM1NjM2N2NiNDgwYzk1MDExYzhjNjJiYjA1ZTk2OGI5M2Y4OWEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb3JnZSBFZHVhcmRvIENhbmRlbGFyaWEgPHgwMTA3MjA5QHRp
LmNvbT4KRGF0ZTogVHVlLCA4IERlYyAyMDA5IDIzOjA2OjU1IC0wNjAwClN1YmplY3Q6IFtQQVRD
SF0gT01BUDQ6IElSUTogQWRkIE1jUERNIElSUSBkZWZpbml0aW9uLgoKU3VwcG9ydCBmb3IgTWNQ
RE0gSVJRcyBpbiBPTUFQNAoKU2lnbmVkLW9mZi1ieTogSm9yZ2UgRWR1YXJkbyBDYW5kZWxhcmlh
IDx4MDEwNzIwOUB0aS5jb20+Ci0tLQogYXJjaC9hcm0vcGxhdC1vbWFwL2luY2x1ZGUvbWFjaC9p
cnFzLmggfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9wbGF0LW9tYXAvaW5jbHVkZS9tYWNoL2ly
cXMuaCBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL21hY2gvaXJxcy5oCmluZGV4IDI4YTE2
NTAuLjc0Y2RkYzAgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL21hY2gv
aXJxcy5oCisrKyBiL2FyY2gvYXJtL3BsYXQtb21hcC9pbmNsdWRlL21hY2gvaXJxcy5oCkBAIC01
MTMsNyArNTEzLDcgQEAKICNkZWZpbmUgSU5UXzQ0WFhfUEFSVEhBU0hfSVJRCSg3OSArIElSUV9H
SUNfU1RBUlQpCiAjZGVmaW5lIElOVF80NFhYX01NQzNfSVJRCSg5NCArIElSUV9HSUNfU1RBUlQp
CiAjZGVmaW5lIElOVF80NFhYX01NQzRfSVJRCSg5NiArIElSUV9HSUNfU1RBUlQpCi0KKyNkZWZp
bmUgSU5UXzQ0WFhfTUNQRE1fSVJRCSgxMTIgKyBJUlFfR0lDX1NUQVJUKQogCiAvKiBNYXguIDEy
OCBsZXZlbCAyIElSUXMgKE9NQVAxNjEwKSwgMTkyIEdQSU9zIChPTUFQNzMwLzg1MCkgYW5kCiAg
KiAxNiBNUFVJTyBsaW5lcyAqLwotLSAKMS42LjAuNAoK

--_002_2256F256009DAA4CBE661E9F41EAC84B88A174F9dlee01entticom_--
