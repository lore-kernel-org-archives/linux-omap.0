From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: introduce VMA checking for cache
 operation
Date: Wed, 29 Jul 2009 12:30:33 +0300 (EEST)
Message-ID: <20090729.123033.98891522.Hiroshi.DOYU@nokia.com>
References: <1248250970-417-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1248250970-417-2-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Wed_Jul_29_12_30_33_2009_195)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23047 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZG2Jal (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jul 2009 05:30:41 -0400
In-Reply-To: <1248250970-417-2-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com, ameya.palande@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, h-kanigeri2@ti.com, hiroshi.doyu@nokia.com

----Next_Part(Wed_Jul_29_12_30_33_2009_195)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Subject: [PATCH 2/2] DSPBRIDGE: introduce VMA checking for cache operation
Date: Wed, 22 Jul 2009 10:22:50 +0200

> Check if the given area blongs to process virtul memory address space.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/dsp/bridge/rmgr/proc.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
> index 3a2879f..fe9dabf 100644
> --- a/drivers/dsp/bridge/rmgr/proc.c
> +++ b/drivers/dsp/bridge/rmgr/proc.c
> @@ -735,6 +735,30 @@ DSP_STATUS PROC_EnumNodes(DSP_HPROCESSOR hProcessor, OUT DSP_HNODE *aNodeTab,
>  	return status;
>  }
>  
> +/* Check if the given area blongs to process virtul memory address space */
> +static int memory_check_vma(unsigned long start, u32 len)
> +{
> +	int err = 0;
> +	unsigned long end;
> +	struct vm_area_struct *vma;
> +
> +	len = PAGE_ALIGN(len);
> +	end = start + len;
> +	if (end <= start)
> +		return -EINVAL;
> +
> +	down_read(&current->mm->mmap_sem);
> +
> +	vma = find_vma(current->mm, start);
> +	if (!vma || start < vma->vm_start) {

"end" should be checkd if it's lower than vm_end as below.

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index fe9dabf..f567329 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -742,6 +742,7 @@ static int memory_check_vma(unsigned long start, u32 len)
        unsigned long end;
        struct vm_area_struct *vma;
 
+       start &= PAGE_MASK;
        len = PAGE_ALIGN(len);
        end = start + len;
        if (end <= start)
@@ -750,8 +751,9 @@ static int memory_check_vma(unsigned long start, u32 len)
        down_read(&current->mm->mmap_sem);
 
        vma = find_vma(current->mm, start);
-       if (!vma || start < vma->vm_start) {
-               pr_err("%s: no vma for %08lx %08lx\n", __func__, start, end);
+       if (!vma || start < vma->vm_start || end > vma->vm_end) {
+               pr_err("%s: no vma for %08lx-%08lx (%08lx-%08lx)\n", __func__,
+                      start, end, vma->vm_start, vma->vm_end);
                err = -EINVAL;
        }

The update one is attached.

----Next_Part(Wed_Jul_29_12_30_33_2009_195)--
Content-Type: Application/Octet-Stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-DSPBRIDGE-introduce-VMA-checking-for-cache-operatio.patch"

RnJvbSA3OWU4M2JjZTIwYjYyY2YwMGI2MWE2NzU0NzNhYWM0YTk4Njc0ZmNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIaXJvc2hpIERPWVUgPEhpcm9zaGkuRE9ZVUBub2tpYS5jb20+
CkRhdGU6IFR1ZSwgNyBKdWwgMjAwOSAxNTowMjo1MiArMDMwMApTdWJqZWN0OiBbUEFUQ0ggMS8x
XSBEU1BCUklER0U6IGludHJvZHVjZSBWTUEgY2hlY2tpbmcgZm9yIGNhY2hlIG9wZXJhdGlvbgoK
RnJvbTogSGlyb3NoaSBET1lVIDxIaXJvc2hpLkRPWVVAbm9raWEuY29tPgoKQ2hlY2sgaWYgdGhl
IGdpdmVuIGFyZWEgYmVsb25ncyB0byBwcm9jZXNzIHZpcnR1bCBtZW1vcnkgYWRkcmVzcyBzcGFj
ZS4KClNpZ25lZC1vZmYtYnk6IEhpcm9zaGkgRE9ZVSA8SGlyb3NoaS5ET1lVQG5va2lhLmNvbT4K
LS0tCiBkcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9wcm9jLmMgfCAgIDM0ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIDEgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9wcm9j
LmMgYi9kcml2ZXJzL2RzcC9icmlkZ2Uvcm1nci9wcm9jLmMKaW5kZXggM2EyODc5Zi4uZjU2NzMy
OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9kc3AvYnJpZGdlL3JtZ3IvcHJvYy5jCisrKyBiL2RyaXZl
cnMvZHNwL2JyaWRnZS9ybWdyL3Byb2MuYwpAQCAtNzM1LDYgKzczNSwzMiBAQCBEU1BfU1RBVFVT
IFBST0NfRW51bU5vZGVzKERTUF9IUFJPQ0VTU09SIGhQcm9jZXNzb3IsIE9VVCBEU1BfSE5PREUg
KmFOb2RlVGFiLAogCXJldHVybiBzdGF0dXM7CiB9CiAKKy8qIENoZWNrIGlmIHRoZSBnaXZlbiBh
cmVhIGJsb25ncyB0byBwcm9jZXNzIHZpcnR1bCBtZW1vcnkgYWRkcmVzcyBzcGFjZSAqLworc3Rh
dGljIGludCBtZW1vcnlfY2hlY2tfdm1hKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHUzMiBsZW4pCit7
CisJaW50IGVyciA9IDA7CisJdW5zaWduZWQgbG9uZyBlbmQ7CisJc3RydWN0IHZtX2FyZWFfc3Ry
dWN0ICp2bWE7CisKKwlzdGFydCAmPSBQQUdFX01BU0s7CisJbGVuID0gUEFHRV9BTElHTihsZW4p
OworCWVuZCA9IHN0YXJ0ICsgbGVuOworCWlmIChlbmQgPD0gc3RhcnQpCisJCXJldHVybiAtRUlO
VkFMOworCisJZG93bl9yZWFkKCZjdXJyZW50LT5tbS0+bW1hcF9zZW0pOworCisJdm1hID0gZmlu
ZF92bWEoY3VycmVudC0+bW0sIHN0YXJ0KTsKKwlpZiAoIXZtYSB8fCBzdGFydCA8IHZtYS0+dm1f
c3RhcnQgfHwgZW5kID4gdm1hLT52bV9lbmQpIHsKKwkJcHJfZXJyKCIlczogbm8gdm1hIGZvciAl
MDhseC0lMDhseCAoJTA4bHgtJTA4bHgpXG4iLCBfX2Z1bmNfXywKKwkJICAgICAgIHN0YXJ0LCBl
bmQsIHZtYS0+dm1fc3RhcnQsIHZtYS0+dm1fZW5kKTsKKwkJZXJyID0gLUVJTlZBTDsKKwl9CisK
Kwl1cF9yZWFkKCZjdXJyZW50LT5tbS0+bW1hcF9zZW0pOworCisJcmV0dXJuIGVycjsKK30KIAog
c3RhdGljIERTUF9TVEFUVVMgcHJvY19tZW1vcnlfc3luYyhEU1BfSFBST0NFU1NPUiBoUHJvY2Vz
c29yLCB2b2lkICpwTXB1QWRkciwKIAkJCQkgICB1MzIgdWxTaXplLCB1MzIgdWxGbGFncywKQEAg
LTc1Nyw2ICs3ODMsMTQgQEAgc3RhdGljIERTUF9TVEFUVVMgcHJvY19tZW1vcnlfc3luYyhEU1Bf
SFBST0NFU1NPUiBoUHJvY2Vzc29yLCB2b2lkICpwTXB1QWRkciwKIAkJZ290byBlcnJfb3V0Owog
CX0KIAorCWlmIChtZW1vcnlfY2hlY2tfdm1hKCh1MzIpcE1wdUFkZHIsIHVsU2l6ZSkpIHsKKwkJ
R1RfM3RyYWNlKFBST0NfRGVidWdNYXNrLCBHVF83Q0xBU1MsCisJCQkgICIlczogSW5WYWxpZCBh
ZGRyZXNzIHBhcmFtZXRlcnNcbiIsCisJCQkgIF9fZnVuY19fLCBwTXB1QWRkciwgdWxTaXplKTsK
KwkJc3RhdHVzID0gRFNQX0VIQU5ETEU7CisJCWdvdG8gZXJyX291dDsKKwl9CisKIAkodm9pZClT
WU5DX0VudGVyQ1MoaFByb2NMb2NrKTsKIAlNRU1fRmx1c2hDYWNoZShwTXB1QWRkciwgdWxTaXpl
LCBGbHVzaE1lbVR5cGUpOwogCSh2b2lkKVNZTkNfTGVhdmVDUyhoUHJvY0xvY2spOwotLSAKMS42
LjAuNAoK

----Next_Part(Wed_Jul_29_12_30_33_2009_195)----
