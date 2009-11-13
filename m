From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address
 instead of user's
Date: Fri, 13 Nov 2009 12:12:12 +0200 (EET)
Message-ID: <20091113.121212.189727725.Hiroshi.DOYU@nokia.com>
References: <1257510861-18627-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Fri_Nov_13_12_12_12_2009_746)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48620 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756205AbZKMKMX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 05:12:23 -0500
In-Reply-To: <1257510861-18627-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, omar.ramirez@ti.com
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, nm@ti.com, Miguel.Verdu@nokia.com, bshah@ti.com, rmk@arm.linux.org.uk

----Next_Part(Fri_Nov_13_12_12_12_2009_746)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Subject: [PATCH 1/1] DSPBRIDGE: cache operation against kernel address instead of user's
Date: Fri, 6 Nov 2009 13:34:21 +0100

> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> Based on the discussion:
>   http://www.spinics.net/lists/arm-kernel/msg72810.html
> 
> HACK: export "follow_page()" for dspbridge cache operation
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/dsp/bridge/rmgr/proc.c |   76 +++++++++++++++++++++++++++++++---------
>  mm/memory.c                    |    1 +
>  2 files changed, 60 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
> index a75b64a..dc37beb 100644
> --- a/drivers/dsp/bridge/rmgr/proc.c
> +++ b/drivers/dsp/bridge/rmgr/proc.c
> @@ -159,6 +159,8 @@
>  #define PWR_TIMEOUT	 500	/* Sleep/wake timout in msec */
>  #define EXTEND	      "_EXT_END"	/* Extmem end addr in DSP binary */
>  
> +#define DSP_CACHE_LINE 128
> +
>  extern char *iva_img;
>  
>  /*  ----------------------------------- Globals */
> @@ -679,8 +681,48 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
>  	return status;
>  }
>  
> +/* Cache operation against kernel address instead of users */
> +static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
> +			    ssize_t len, enum DSP_FLUSHTYPE ftype)
> +{
> +	struct page *page;
> +	void *kaddr;
> +	unsigned long offset;
> +	ssize_t rest;
> +
> +#ifdef CHECK_DSP_CACHE_LINE
> +	if ((start & DSP_CACHE_LINE) || (len & DSP_CACHE_LINE))
> +		pr_warning("%s: not aligned: %08lx(%d)\n", __func__,
> +			   start, len);
> +#endif
> +	while (len) {
> +		page = follow_page(vma, start, FOLL_GET);
> +		if (!page) {
> +			pr_err("%s: no page for %08lx\n", __func__, start);
> +			return -EINVAL;
> +		} else if (IS_ERR(page)) {
> +			pr_err("%s: err page for %08lx(%lu)\n", __func__, start,
> +			       IS_ERR(page));
> +			return IS_ERR(page);
> +		}
> +
> +		offset = start & ~PAGE_SIZE;

should be:

 +		offset = start & ~PAGE_MASK;

The fixed version is attached.

----Next_Part(Fri_Nov_13_12_12_12_2009_746)--
Content-Type: Application/Octet-Stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-DSPBRIDGE-cache-operation-against-kernel-address-in.patch"

RnJvbSA3OGQ5ODQ3ZTdkYzEwYzQ1Njc1NjZlMTU3MTQzOWIyYjhlOWU5MGNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIaXJvc2hpIERPWVUgPEhpcm9zaGkuRE9ZVUBub2tpYS5jb20+
CkRhdGU6IFRodSwgMTUgT2N0IDIwMDkgMTI6MzE6NTAgKzAzMDAKU3ViamVjdDogW1BBVENIIDEv
MV0gRFNQQlJJREdFOiBjYWNoZSBvcGVyYXRpb24gYWdhaW5zdCBrZXJuZWwgYWRkcmVzcyBpbnN0
ZWFkIG9mIHVzZXIncwoKQmFzZWQgb24gdGhlIGRpc2N1c3Npb246CiAgaHR0cDovL3d3dy5zcGlu
aWNzLm5ldC9saXN0cy9hcm0ta2VybmVsL21zZzcyODEwLmh0bWwKCkhBQ0s6IGV4cG9ydCAiZm9s
bG93X3BhZ2UoKSIgZm9yIGRzcGJyaWRnZSBjYWNoZSBvcGVyYXRpb24KClNpZ25lZC1vZmYtYnk6
IEhpcm9zaGkgRE9ZVSA8SGlyb3NoaS5ET1lVQG5va2lhLmNvbT4KLS0tCiBkcml2ZXJzL2RzcC9i
cmlkZ2Uvcm1nci9wcm9jLmMgfCAgIDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0KIG1tL21lbW9yeS5jICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKwogMiBmaWxl
cyBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9wcm9jLmMgYi9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1n
ci9wcm9jLmMKaW5kZXggYTc1YjY0YS4uYzE5NWI2ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9kc3Av
YnJpZGdlL3JtZ3IvcHJvYy5jCisrKyBiL2RyaXZlcnMvZHNwL2JyaWRnZS9ybWdyL3Byb2MuYwpA
QCAtMTU5LDYgKzE1OSw4IEBACiAjZGVmaW5lIFBXUl9USU1FT1VUCSA1MDAJLyogU2xlZXAvd2Fr
ZSB0aW1vdXQgaW4gbXNlYyAqLwogI2RlZmluZSBFWFRFTkQJICAgICAgIl9FWFRfRU5EIgkvKiBF
eHRtZW0gZW5kIGFkZHIgaW4gRFNQIGJpbmFyeSAqLwogCisjZGVmaW5lIERTUF9DQUNIRV9MSU5F
IDEyOAorCiBleHRlcm4gY2hhciAqaXZhX2ltZzsKIAogLyogIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tIEdsb2JhbHMgKi8KQEAgLTY3OSw4ICs2ODEsNDggQEAgRFNQX1NUQVRV
UyBQUk9DX0VudW1Ob2RlcyhEU1BfSFBST0NFU1NPUiBoUHJvY2Vzc29yLCBPVVQgRFNQX0hOT0RF
ICphTm9kZVRhYiwKIAlyZXR1cm4gc3RhdHVzOwogfQogCisvKiBDYWNoZSBvcGVyYXRpb24gYWdh
aW5zdCBrZXJuZWwgYWRkcmVzcyBpbnN0ZWFkIG9mIHVzZXJzICovCitzdGF0aWMgaW50IG1lbW9y
eV9zeW5jX3BhZ2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgc3Rh
cnQsCisJCQkgICAgc3NpemVfdCBsZW4sIGVudW0gRFNQX0ZMVVNIVFlQRSBmdHlwZSkKK3sKKwlz
dHJ1Y3QgcGFnZSAqcGFnZTsKKwl2b2lkICprYWRkcjsKKwl1bnNpZ25lZCBsb25nIG9mZnNldDsK
Kwlzc2l6ZV90IHJlc3Q7CisKKyNpZmRlZiBDSEVDS19EU1BfQ0FDSEVfTElORQorCWlmICgoc3Rh
cnQgJiBEU1BfQ0FDSEVfTElORSkgfHwgKGxlbiAmIERTUF9DQUNIRV9MSU5FKSkKKwkJcHJfd2Fy
bmluZygiJXM6IG5vdCBhbGlnbmVkOiAlMDhseCglZClcbiIsIF9fZnVuY19fLAorCQkJICAgc3Rh
cnQsIGxlbik7CisjZW5kaWYKKwl3aGlsZSAobGVuKSB7CisJCXBhZ2UgPSBmb2xsb3dfcGFnZSh2
bWEsIHN0YXJ0LCBGT0xMX0dFVCk7CisJCWlmICghcGFnZSkgeworCQkJcHJfZXJyKCIlczogbm8g
cGFnZSBmb3IgJTA4bHhcbiIsIF9fZnVuY19fLCBzdGFydCk7CisJCQlyZXR1cm4gLUVJTlZBTDsK
KwkJfSBlbHNlIGlmIChJU19FUlIocGFnZSkpIHsKKwkJCXByX2VycigiJXM6IGVyciBwYWdlIGZv
ciAlMDhseCglbHUpXG4iLCBfX2Z1bmNfXywgc3RhcnQsCisJCQkgICAgICAgSVNfRVJSKHBhZ2Up
KTsKKwkJCXJldHVybiBJU19FUlIocGFnZSk7CisJCX0KKworCQlvZmZzZXQgPSBzdGFydCAmIH5Q
QUdFX01BU0s7CisJCWthZGRyID0gcGFnZV9hZGRyZXNzKHBhZ2UpICsgb2Zmc2V0OworCQlyZXN0
ID0gbWluX3Qoc3NpemVfdCwgUEFHRV9TSVpFIC0gb2Zmc2V0LCBsZW4pOworCisJCU1FTV9GbHVz
aENhY2hlKGthZGRyLCByZXN0LCBmdHlwZSk7CisKKwkJcHV0X3BhZ2UocGFnZSk7CisJCWxlbiAt
PSByZXN0OworCQlzdGFydCArPSByZXN0OworCX0KKworCXJldHVybiAwOworfQorCiAvKiBDaGVj
ayBpZiB0aGUgZ2l2ZW4gYXJlYSBibG9uZ3MgdG8gcHJvY2VzcyB2aXJ0dWwgbWVtb3J5IGFkZHJl
c3Mgc3BhY2UgKi8KLXN0YXRpYyBpbnQgbWVtb3J5X2NoZWNrX3ZtYSh1bnNpZ25lZCBsb25nIHN0
YXJ0LCB1MzIgbGVuKQorc3RhdGljIGludCBtZW1vcnlfc3luY192bWEodW5zaWduZWQgbG9uZyBz
dGFydCwgdTMyIGxlbiwKKwkJCSAgIGVudW0gRFNQX0ZMVVNIVFlQRSBmdHlwZSkKIHsKIAlpbnQg
ZXJyID0gMDsKIAl1bnNpZ25lZCBsb25nIGVuZDsKQEAgLTY5MCwxNCArNzMyLDE5IEBAIHN0YXRp
YyBpbnQgbWVtb3J5X2NoZWNrX3ZtYSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1MzIgbGVuKQogCWlm
IChlbmQgPD0gc3RhcnQpCiAJCXJldHVybiAtRUlOVkFMOwogCi0JZG93bl9yZWFkKCZjdXJyZW50
LT5tbS0+bW1hcF9zZW0pOwotCiAJd2hpbGUgKCh2bWEgPSBmaW5kX3ZtYShjdXJyZW50LT5tbSwg
c3RhcnQpKSAhPSBOVUxMKSB7CisJCXNzaXplX3Qgc2l6ZTsKIAotCQlpZiAodm1hLT52bV9zdGFy
dCA+IHN0YXJ0KSB7Ci0JCQllcnIgPSAtRUlOVkFMOworCQlpZiAodm1hLT52bV9mbGFncyAmIChW
TV9JTyB8IFZNX1BGTk1BUCkpCisJCQlyZXR1cm4gLUVJTlZBTDsKKworCQlpZiAodm1hLT52bV9z
dGFydCA+IHN0YXJ0KQorCQkJcmV0dXJuIC1FSU5WQUw7CisKKwkJc2l6ZSA9IG1pbl90KHNzaXpl
X3QsIHZtYS0+dm1fZW5kIC0gc3RhcnQsIGxlbik7CisJCWVyciA9IG1lbW9yeV9zeW5jX3BhZ2Uo
dm1hLCBzdGFydCwgc2l6ZSwgZnR5cGUpOworCQlpZiAoZXJyKQogCQkJYnJlYWs7Ci0JCX0KIAog
CQlpZiAoZW5kIDw9IHZtYS0+dm1fZW5kKQogCQkJYnJlYWs7CkBAIC03MDgsOCArNzU1LDYgQEAg
c3RhdGljIGludCBtZW1vcnlfY2hlY2tfdm1hKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHUzMiBsZW4p
CiAJaWYgKCF2bWEpCiAJCWVyciA9IC1FSU5WQUw7CiAKLQl1cF9yZWFkKCZjdXJyZW50LT5tbS0+
bW1hcF9zZW0pOwotCiAJcmV0dXJuIGVycjsKIH0KIApAQCAtNzM0LDE4ICs3NzksMTUgQEAgc3Rh
dGljIERTUF9TVEFUVVMgcHJvY19tZW1vcnlfc3luYyhEU1BfSFBST0NFU1NPUiBoUHJvY2Vzc29y
LCB2b2lkICpwTXB1QWRkciwKIAkJZ290byBlcnJfb3V0OwogCX0KIAotCWlmIChtZW1vcnlfY2hl
Y2tfdm1hKCh1MzIpcE1wdUFkZHIsIHVsU2l6ZSkpIHsKLQkJR1RfM3RyYWNlKFBST0NfRGVidWdN
YXNrLCBHVF83Q0xBU1MsCi0JCQkgICIlczogSW5WYWxpZCBhZGRyZXNzIHBhcmFtZXRlcnNcbiIs
Ci0JCQkgIF9fZnVuY19fLCBwTXB1QWRkciwgdWxTaXplKTsKKwlkb3duX3JlYWQoJmN1cnJlbnQt
Pm1tLT5tbWFwX3NlbSk7CisKKwlpZiAobWVtb3J5X3N5bmNfdm1hKCh1MzIpcE1wdUFkZHIsIHVs
U2l6ZSwgRmx1c2hNZW1UeXBlKSkgeworCQlwcl9lcnIoIiVzOiBJblZhbGlkIGFkZHJlc3MgcGFy
YW1ldGVycyAlcCAleFxuIiwKKwkJICAgICAgIF9fZnVuY19fLCBwTXB1QWRkciwgdWxTaXplKTsK
IAkJc3RhdHVzID0gRFNQX0VIQU5ETEU7Ci0JCWdvdG8gZXJyX291dDsKIAl9CiAKLQkodm9pZClT
WU5DX0VudGVyQ1MoaFByb2NMb2NrKTsKLQlNRU1fRmx1c2hDYWNoZShwTXB1QWRkciwgdWxTaXpl
LCBGbHVzaE1lbVR5cGUpOwotCSh2b2lkKVNZTkNfTGVhdmVDUyhoUHJvY0xvY2spOwotCisJdXBf
cmVhZCgmY3VycmVudC0+bW0tPm1tYXBfc2VtKTsKIGVycl9vdXQ6CiAJR1RfMnRyYWNlKFBST0Nf
RGVidWdNYXNrLCBHVF9FTlRFUiwKIAkJICAiTGVhdmluZyAlcyBbMHgleF0iLCBfX2Z1bmNfXywg
c3RhdHVzKTsKZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggMTY0
OTUxYy4uZTlkYzY1NyAxMDA2NDQKLS0tIGEvbW0vbWVtb3J5LmMKKysrIGIvbW0vbWVtb3J5LmMK
QEAgLTExMTAsNiArMTExMCw3IEBAIG5vX3BhZ2VfdGFibGU6CiAJfQogCXJldHVybiBwYWdlOwog
fQorRVhQT1JUX1NZTUJPTF9HUEwoZm9sbG93X3BhZ2UpOwogCiAvKiBDYW4gd2UgZG8gdGhlIEZP
TExfQU5PTiBvcHRpbWl6YXRpb24/ICovCiBzdGF0aWMgaW5saW5lIGludCB1c2VfemVyb19wYWdl
KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQotLSAKMS42LjAuNAoK

----Next_Part(Fri_Nov_13_12_12_12_2009_746)----
