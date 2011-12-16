From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 16 Dec 2011 21:50:46 +0800
Message-ID: <CACVXFVNOpfWxod_pN-kiQPoQ7n=XSFeV6WK6sf+8hYSiZ2rDBA@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d044280ce51a37204b435e31d
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37337 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759212Ab1LPNut (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 08:50:49 -0500
Received: by faar15 with SMTP id r15so2929340faa.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 05:50:48 -0800 (PST)
In-Reply-To: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

--f46d044280ce51a37204b435e31d
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Fri, Dec 16, 2011 at 9:24 PM, Ming Lei <tom.leiming@gmail.com> wrote:

> [1], add static dependency

Sorry for the mess, see attachment for the change.

thanks,
-- 
Ming Lei

--f46d044280ce51a37204b435e31d
Content-Type: text/x-patch; charset=US-ASCII; name="dyndep.patch"
Content-Disposition: attachment; filename="dyndep.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gw99954n0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDIvcG00NHh4LmMgYi9hcmNoL2FybS9tYWNo
LW9tYXAyL3BtNDR4eC5jCmluZGV4IGMyNjRlZjcuLjIzZTFmOGMgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL21hY2gtb21hcDIvcG00NHh4LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9wbTQ0eHgu
YwpAQCAtMTk4LDYgKzE5OCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IG9tYXA0X3BtX2luaXQodm9p
ZCkKIAlpbnQgcmV0OwogCXN0cnVjdCBjbG9ja2RvbWFpbiAqZW1pZl9jbGtkbSwgKm1wdXNzX2Ns
a2RtLCAqbDNfMV9jbGtkbTsKIAlzdHJ1Y3QgY2xvY2tkb21haW4gKmR1Y2F0aV9jbGtkbSwgKmwz
XzJfY2xrZG0sICpsNF9wZXJfY2xrZG07CisJc3RydWN0IGNsb2NrZG9tYWluICppc3NfY2xrZG07
CiAKIAlpZiAoIWNwdV9pc19vbWFwNDR4eCgpKQogCQlyZXR1cm4gLUVOT0RFVjsKQEAgLTIyNyw4
ICsyMjgsMTAgQEAgc3RhdGljIGludCBfX2luaXQgb21hcDRfcG1faW5pdCh2b2lkKQogCWwzXzJf
Y2xrZG0gPSBjbGtkbV9sb29rdXAoImwzXzJfY2xrZG0iKTsKIAlsNF9wZXJfY2xrZG0gPSBjbGtk
bV9sb29rdXAoImw0X3Blcl9jbGtkbSIpOwogCWR1Y2F0aV9jbGtkbSA9IGNsa2RtX2xvb2t1cCgi
ZHVjYXRpX2Nsa2RtIik7CisJaXNzX2Nsa2RtID0gY2xrZG1fbG9va3VwKCJpc3NfY2xrZG0iKTsK
IAlpZiAoKCFtcHVzc19jbGtkbSkgfHwgKCFlbWlmX2Nsa2RtKSB8fCAoIWwzXzFfY2xrZG0pIHx8
Ci0JCSghbDNfMl9jbGtkbSkgfHwgKCFkdWNhdGlfY2xrZG0pIHx8ICghbDRfcGVyX2Nsa2RtKSkK
KwkJKCFsM18yX2Nsa2RtKSB8fCAoIWR1Y2F0aV9jbGtkbSkgfHwgKCFsNF9wZXJfY2xrZG0pIHx8
CisJCSghaXNzX2Nsa2RtKSkKIAkJZ290byBlcnIyOwogCiAJcmV0ID0gY2xrZG1fYWRkX3drZGVw
KG1wdXNzX2Nsa2RtLCBlbWlmX2Nsa2RtKTsKQEAgLTIzNyw2ICsyNDAsNyBAQCBzdGF0aWMgaW50
IF9faW5pdCBvbWFwNF9wbV9pbml0KHZvaWQpCiAJcmV0IHw9IGNsa2RtX2FkZF93a2RlcChtcHVz
c19jbGtkbSwgbDRfcGVyX2Nsa2RtKTsKIAlyZXQgfD0gY2xrZG1fYWRkX3drZGVwKGR1Y2F0aV9j
bGtkbSwgbDNfMV9jbGtkbSk7CiAJcmV0IHw9IGNsa2RtX2FkZF93a2RlcChkdWNhdGlfY2xrZG0s
IGwzXzJfY2xrZG0pOworCXJldCB8PSBjbGtkbV9hZGRfd2tkZXAoaXNzX2Nsa2RtLCBsM18yX2Ns
a2RtKTsKIAlpZiAocmV0KSB7CiAJCXByX2VycigiRmFpbGVkIHRvIGFkZCBNUFVTUyAtPiBMMy9F
TUlGL0w0UEVSLCBEVUNBVEkgLT4gTDMgIgogCQkJCSJ3YWtldXAgZGVwZW5kZW5jeVxuIik7Cg==
--f46d044280ce51a37204b435e31d--
