From: Sergey Lapin <slapinid@gmail.com>
Subject: OMAP3515 vs 3525 inversion
Date: Mon, 16 Nov 2009 13:28:30 +0300
Message-ID: <48239d390911160228y61e3c3dbk11b7a819f266b4bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174be4fc8c2bde04787a78ed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:49032 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbZKPK20 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 05:28:26 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1910522eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 16 Nov 2009 02:28:30 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--0015174be4fc8c2bde04787a78ed
Content-Type: text/plain; charset=ISO-8859-1

Hi, all!
I think I found a bug in processor detection code.
as I see,
> > +	/* OMAP3430 and OMAP3530 are assumed to be same.
> > +	 *
> > +	 * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
> > +	 * on available features. Upon detection, update the CPU id
> > +	 * and CPU class bits.
> > +	 */
> > +	if (omap3_has_iva() && omap3_has_sgx()) {
> > +		strcpy(cpu_name, "3430/3530");
> > +	}
> > +	else if (omap3_has_sgx()) {
> > +		omap_revision = OMAP3525_REV (rev);
> > +		strcpy(cpu_name, "3525");
> > +	}
> > +	else if (omap3_has_iva()) {
> > +		omap_revision = OMAP3515_REV (rev);
> > +		strcpy(cpu_name, "3515");
> > +	}
> > +	else {
> > +		omap_revision = OMAP3503_REV (rev);
> > +		strcpy(cpu_name, "3503");
> > +	}

But, actually, 3515 has no DSP, but has PowerVR,
and 3525 has no PowerVR but has DSP. In-tree code inverses this detection.

Please consider applying attached patch. (sorry, no git-send-email
available here).

--0015174be4fc8c2bde04787a78ed
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-OMAP3-id-code-detection-3525-vs-3515.patch"
Content-Disposition: attachment;
	filename="0001-OMAP3-id-code-detection-3525-vs-3515.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g233c5mx0

RnJvbSA5M2FjOWM2YjJkY2NiMGNlZGIyODQxNDYxMmVkMmIxYjc3NTM3ZGVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnZXkgTGFwaW4gPHNsYXBpbkBvc3NmYW5zLm9yZz4KRGF0
ZTogTW9uLCAxNiBOb3YgMjAwOSAxMzoyMzo0NSArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIE9NQVAz
OiBpZCBjb2RlIGRldGVjdGlvbiAzNTI1IHZzIDM1MTUKCkluIGN1cnJlbnQgdHJlZSBDUFUgZGV0
ZWN0aW9uIG9mIDM1MjUgdnMgMzUxNSBpcyByZXZlcnNlZAoKClNpZ25lZC1vZmYtYnk6IFNlcmdl
eSBMYXBpbiA8c2xhcGluQG9zc2ZhbnMub3JnPgotLS0KIGFyY2gvYXJtL21hY2gtb21hcDIvaWQu
YyB8ICAgIDYgKysrLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9tYXAyL2lkLmMgYi9hcmNoL2Fy
bS9tYWNoLW9tYXAyL2lkLmMKaW5kZXggZjQ4YTRiMi4uMmY5NzU3NyAxMDA2NDQKLS0tIGEvYXJj
aC9hcm0vbWFjaC1vbWFwMi9pZC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvaWQuYwpAQCAt
Mjc4LDExICsyNzgsMTEgQEAgdm9pZCBfX2luaXQgb21hcDNfY3B1aW5mbyh2b2lkKQogCQkvKiBP
TUFQMzQzMCwgT01BUDM1MjUsIE9NQVAzNTE1LCBPTUFQMzUwMyBkZXZpY2VzICovCiAJCXN0cmNw
eShjcHVfbmFtZSwgIk9NQVAzNDMwLzM1MzAiKTsKIAl9IGVsc2UgaWYgKG9tYXAzX2hhc19zZ3go
KSkgewotCQlvbWFwX3JldmlzaW9uID0gT01BUDM1MjVfUkVWKHJldik7Ci0JCXN0cmNweShjcHVf
bmFtZSwgIk9NQVAzNTI1Iik7Ci0JfSBlbHNlIGlmIChvbWFwM19oYXNfaXZhKCkpIHsKIAkJb21h
cF9yZXZpc2lvbiA9IE9NQVAzNTE1X1JFVihyZXYpOwogCQlzdHJjcHkoY3B1X25hbWUsICJPTUFQ
MzUxNSIpOworCX0gZWxzZSBpZiAob21hcDNfaGFzX2l2YSgpKSB7CisJCW9tYXBfcmV2aXNpb24g
PSBPTUFQMzUyNV9SRVYocmV2KTsKKwkJc3RyY3B5KGNwdV9uYW1lLCAiT01BUDM1MjUiKTsKIAl9
IGVsc2UgewogCQlvbWFwX3JldmlzaW9uID0gT01BUDM1MDNfUkVWKHJldik7CiAJCXN0cmNweShj
cHVfbmFtZSwgIk9NQVAzNTAzIik7Ci0tIAoxLjYuNQoK
--0015174be4fc8c2bde04787a78ed--
