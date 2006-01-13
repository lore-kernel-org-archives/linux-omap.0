From: <Toshihiro.Kobayashi@nokia.com>
Subject: RE: [PATCH] Replace clk_use/unuse with clk_enable/disable,
	please test
Date: Fri, 13 Jan 2006 21:27:14 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F5501B00590@toebe101.NOE.Nokia.com>
References: <7AF192DA69C59243838FF62851F64F5501B0057A@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6183C.B3709743"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <7AF192DA69C59243838FF62851F64F5501B0057A@toebe101.NOE.Nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6183C.B3709743
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sorry, the code to shut down dsp_ck was wrong in the previous patch.
Please use this one.

BR,
Toshihiro Kobayashi

>-----Original Message-----
>From: linux-omap-open-source-bounces@linux.omap.com=20
>[mailto:linux-omap-open-source-bounces@linux.omap.com]=20
>Sent: Friday, January 13, 2006 9:10 PM
>To: tony@atomide.com; linux-omap-open-source@linux.omap.com
>Subject: RE: [PATCH] Replace clk_use/unuse with=20
>clk_enable/disable,please test
>
>Hi Tony,
>
>Sorry for the slow reply.
>
>>Toshihiro, can you please check the dsp related changes? The problem
>>there seems to be that the dsp code may enable certain clocks and then
>>they stay on during suspend.
>>
>>I've just added clk_enable() clk_disable() in few places there to shut
>>down any clocks left on from dsp code.
>
>OK, Firstly please let me explain the intention of the old code.
>The dsp_ck handling in the suspend sequence is as follows.
>
>omap_pm_suspend() {
>    ARM_SAVE(ARM_CKCTL) (contains dsp_ck)    <-- (1)
>    omap_dsp_pm_suspend() {
>        clk_disable(dsp_ck)
>            (forcingly disble because it is not shut down in
>omapXXXX_idle_loop_suspend())
>    }
>    omapXXXX_idle_loop_suspend() {
>        *** suspend ***
>    }
>    omap_dsp_pm_resume() {
>    }
>    ARM_RESTORE(ARM_CKCTL) to the value at (1)
>}
>
>Now, we are losing (old) clk_disable() function, it must
>be replaced with low-level register operation.
>
>Also, api_ck is handled as follows in each
>omap_dsp_pm_suspend() and omap_dsp_pm_resume().
>
>omap_dsp_pm_suspend() {
>    save ARMIDLECT2 (contains api_ck)
>    clk_enable(api_ck) so that we can access DSP_IDLECT2 register
>    here accessing to DSP_IDLECT2
>    restore ARM_IDLECT2
>}
>
>So the api_ck is handled correctly as well but this is not a very
>intelligent. ;)
>They could be simply done with clk_use() and clk_unuse().
>(Maybe it's a negative heritage from old code before
> the clock framework has been introduced)
>
>Please find the patch attached that fixes those issues, in addition,
>the low level register handlings are moved to pm.c.
>(This patch should be applied over your patch)
>
>>Also, does api_ck_handle reference count work properly in
>>dsp_cpustat_update()? It seems that clk_enable(api_ck_handle) and
>>clk_disable(api_ck_handle) may get called multiple times...
>
>No, the cpustat.stat is the state machine that represents DSP state and
>the code is written so that it calls clk_enable(api_ck) only when
>the state changes to CPUSTAT_RUN from the other ones,
>and calls clk_disable(api_ck) only when the state changes from
>CPUSTAT_RUN to the other ones.
>
>BR,
>Toshihiro Kobayashi, Nokia Research Center / Tokyo =20
>
>>-----Original Message-----
>>From: ext Tony Lindgren [mailto:tony@atomide.com]=20
>>Sent: Friday, January 06, 2006 8:21 AM
>>To: linux-omap-open-source@linux.omap.com
>>Cc: Kobayashi Toshihiro (Nokia-NRC/Tokyo)
>>Subject: [PATCH] Replace clk_use/unuse with=20
>>clk_enable/disable, please test
>>
>>Hi all,
>>
>>Following patch removes clk_use/unuse for omap, and replaces them with
>>clk_enable/disable.
>>
>>The reason for this patch is that omap clock framework has=20
>drifted away
>>from the common arm implementation. Also having the two=20
>>different set of
>>functions was confusing.
>>
>>Generic arm clock framework will remove clk_use/unuse soon, and this
>>patch makes omap follow the other arm clock framework implementations.
>>
>>Please comment and test it, I'm planning on pushing it soon.=20
>>For any new
>>drivers not yet in our tree the update is minimal. Just replace
>>clk_use/unuse with clk_enable/disable.
>>
>>Toshihiro, can you please check the dsp related changes? The problem
>>there seems to be that the dsp code may enable certain clocks and then
>>they stay on during suspend.
>>
>>I've just added clk_enable() clk_disable() in few places there to shut
>>down any clocks left on from dsp code.
>>
>>Also, does api_ck_handle reference count work properly in
>>dsp_cpustat_update()? It seems that clk_enable(api_ck_handle) and
>>clk_disable(api_ck_handle) may get called multiple times...
>>
>>Regards,
>>
>>Tony
>>
>>
>

------_=_NextPart_001_01C6183C.B3709743
Content-Type: application/octet-stream;
	name="patch-dsp_ckfix2"
Content-Transfer-Encoding: base64
Content-Description: patch-dsp_ckfix2
Content-Disposition: attachment;
	filename="patch-dsp_ckfix2"

ZGlmZiAtdXJOIGxpbnV4LW9tYXAtMi42L2FyY2gvYXJtL21hY2gtb21hcDEvcG0uYyBsaW51eC1v
bWFwLTIuNi1kc3BfY2tmaXgvYXJjaC9hcm0vbWFjaC1vbWFwMS9wbS5jCi0tLSBsaW51eC1vbWFw
LTIuNi9hcmNoL2FybS9tYWNoLW9tYXAxL3BtLmMJMjAwNi0wMS0xMCAyMDoxNToyNiArMDk6MDAK
KysrIGxpbnV4LW9tYXAtMi42LWRzcF9ja2ZpeC9hcmNoL2FybS9tYWNoLW9tYXAxL3BtLmMJMjAw
Ni0wMS0xMyAxOTo1MTo0OCArMDk6MDAKQEAgLTYyLDYgKzYyLDcgQEAKICNpbmNsdWRlIDxhc20v
YXJjaC9kbXRpbWVyLmg+CiAKIHN0YXRpYyB1bnNpZ25lZCBpbnQgYXJtX3NsZWVwX3NhdmVbQVJN
X1NMRUVQX1NBVkVfU0laRV07CitzdGF0aWMgdW5zaWduZWQgc2hvcnQgZHNwX3NsZWVwX3NhdmVb
RFNQX1NMRUVQX1NBVkVfU0laRV07CiBzdGF0aWMgdW5zaWduZWQgc2hvcnQgdWxwZF9zbGVlcF9z
YXZlW1VMUERfU0xFRVBfU0FWRV9TSVpFXTsKIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXB1aTczMF9z
bGVlcF9zYXZlW01QVUk3MzBfU0xFRVBfU0FWRV9TSVpFXTsKIHN0YXRpYyB1bnNpZ25lZCBpbnQg
bXB1aTE1MTBfc2xlZXBfc2F2ZVtNUFVJMTUxMF9TTEVFUF9TQVZFX1NJWkVdOwpAQCAtMjM2LDYg
KzIzNyw5IEBACiAgCW9tYXBfd3JpdGVsKDEsIE9NQVBfSUgxX0NPTlRST0wpOwogfQogCisjZGVm
aW5lIEVOX0RTUENLCTEzCS8qIEFSTV9DS0NUTCAqLworI2RlZmluZSBFTl9BUElDSwk2CS8qIEFS
TV9JRExFQ1QyICovCisKIHZvaWQgb21hcF9wbV9zdXNwZW5kKHZvaWQpCiB7CiAJdW5zaWduZWQg
bG9uZyBhcmcwID0gMCwgYXJnMSA9IDA7CkBAIC0zMTgsOCArMzIyLDIxIEBACiAJICogU3RlcCA0
OiBPTUFQIERTUCBTaHV0ZG93bgogCSAqLwogCisJLyogc3RvcCBEU1AgKi8KIAlvbWFwX2RzcF9w
bV9zdXNwZW5kKCk7CiAKKwkvKiBzaHV0IGRvd24gZHNwX2NrICovCisJb21hcF93cml0ZXcob21h
cF9yZWFkdyhBUk1fQ0tDVEwpICYgfigxIDw8IEVOX0RTUENLKSwgQVJNX0NLQ1RMKTsKKworCS8q
IHRlbXBvcmFyaWx5IGVuYWJsaW5nIGFwaV9jayB0byBhY2Nlc3MgRFNQIHJlZ2lzdGVycyAqLwor
CW9tYXBfd3JpdGV3KG9tYXBfcmVhZHcoQVJNX0lETEVDVDIpIHwgMSA8PCBFTl9BUElDSywgQVJN
X0lETEVDVDIpOworCisJLyogc2F2ZSBEU1AgcmVnaXN0ZXJzICovCisJRFNQX1NBVkUoRFNQX0lE
TEVDVDIpOworCisJLyogU3RvcCBhbGwgRFNQIGRvbWFpbiBjbG9ja3MgKi8KKwlfX3Jhd193cml0
ZXcoMCwgRFNQX0lETEVDVDIpOworCiAJLyoKIAkgKiBTdGVwIDU6IFdha2V1cCBFdmVudCBTZXR1
cAogCSAqLwpAQCAtMzYxLDcgKzM3OCwxNyBAQAogCSAqIElmIHdlIGFyZSBoZXJlLCBwcm9jZXNz
b3IgaXMgd29rZW4gdXAhCiAJICovCiAKLQkvKiBSZXN0b3JlIERTUCBjbG9ja3MgKi8KKwkvKgor
CSAqIFJlc3RvcmUgRFNQIGNsb2NrcworCSAqLworCisJLyogYWdhaW4gdGVtcG9yYXJpbHkgZW5h
YmxpbmcgYXBpX2NrIHRvIGFjY2VzcyBEU1AgcmVnaXN0ZXJzICovCisJb21hcF93cml0ZXcob21h
cF9yZWFkdyhBUk1fSURMRUNUMikgfCAxIDw8IEVOX0FQSUNLLCBBUk1fSURMRUNUMik7CisKKwkv
KiBSZXN0b3JlIERTUCBkb21haW4gY2xvY2tzICovCisJRFNQX1JFU1RPUkUoRFNQX0lETEVDVDIp
OworCisJLyogcmVzdW1lIERTUCAqLwogCW9tYXBfZHNwX3BtX3Jlc3VtZSgpOwogCiAJLyoKZGlm
ZiAtdXJOIGxpbnV4LW9tYXAtMi42L2FyY2gvYXJtL3BsYXQtb21hcC9kc3AvZHNwX2NvbW1vbi5j
IGxpbnV4LW9tYXAtMi42LWRzcF9ja2ZpeC9hcmNoL2FybS9wbGF0LW9tYXAvZHNwL2RzcF9jb21t
b24uYwotLS0gbGludXgtb21hcC0yLjYvYXJjaC9hcm0vcGxhdC1vbWFwL2RzcC9kc3BfY29tbW9u
LmMJMjAwNi0wMS0xMCAyMjoxOTowMyArMDk6MDAKKysrIGxpbnV4LW9tYXAtMi42LWRzcF9ja2Zp
eC9hcmNoL2FybS9wbGF0LW9tYXAvZHNwL2RzcF9jb21tb24uYwkyMDA2LTAxLTEzIDE5OjI0OjMz
ICswOTowMApAQCAtMjM4LDUwICsyMzgsMTkgQEAKIAkJZHNwX2NwdV9pZGxlKCk7CiB9CiAKLXN0
YXRpYyB1bnNpZ25lZCBzaG9ydCBzYXZlX2RzcF9pZGxlY3QyOwogc3RhdGljIGludCBpbml0X2Rv
bmU7CiAKIC8qCiAgKiBub3RlOiBpZiB3ZSBhcmUgaW4gcG1fc3VzcGVuZCAvIHBtX3Jlc3VtZSBm
dW5jdGlvbiwKLSAqIHdlIGFyZSBvdXQgb2YgY2xrX2VuYWJsZSgpIG1hbmFnZW1lbnQuCiAgKi8K
IHZvaWQgb21hcF9kc3BfcG1fc3VzcGVuZCh2b2lkKQogewotCXVuc2lnbmVkIHNob3J0IHNhdmVf
YXJtX2lkbGVjdDI7Ci0KIAkvKiBSZXNldCBEU1AgKi8KIAlfX2RzcF9yZXNldCgpOwotCi0JaWYg
KCEgaW5pdF9kb25lKQotCQlyZXR1cm47Ci0KLQkvKiBEU1AgY29kZSBtYXkgaGF2ZSB0dXJuZWQg
dGhpcyBvbiwgbWFrZSBzdXJlIGl0IGdldHMgdHVybmVkIG9mZiAqLwotCWNsa19lbmFibGUoZHNw
X2NrX2hhbmRsZSk7Ci0JY2xrX2Rpc2FibGUoZHNwX2NrX2hhbmRsZSk7Ci0KLQkvKiBTdG9wIGFu
eSBEU1AgZG9tYWluIGNsb2NrcyAqLwotCXNhdmVfYXJtX2lkbGVjdDIgPSBvbWFwX3JlYWR3KEFS
TV9JRExFQ1QyKTsgLy8gYXBpX2NrIGlzIGluIEFSTV9JRExFQ1QyCi0JY2xrX2VuYWJsZShhcGlf
Y2tfaGFuZGxlKTsKLQlzYXZlX2RzcF9pZGxlY3QyID0gX19yYXdfcmVhZHcoRFNQX0lETEVDVDIp
OwotCV9fcmF3X3dyaXRldygwLCBEU1BfSURMRUNUMik7Ci0Jb21hcF93cml0ZXcoc2F2ZV9hcm1f
aWRsZWN0MiwgQVJNX0lETEVDVDIpOwotCWNsa19kaXNhYmxlKGFwaV9ja19oYW5kbGUpOwogfQog
CiB2b2lkIG9tYXBfZHNwX3BtX3Jlc3VtZSh2b2lkKQogewotCXVuc2lnbmVkIHNob3J0IHNhdmVf
YXJtX2lkbGVjdDI7Ci0KLQlpZiAoISBpbml0X2RvbmUpCi0JCXJldHVybjsKLQotCS8qIFJlc3Rv
cmUgRFNQIGRvbWFpbiBjbG9ja3MgKi8KLQlzYXZlX2FybV9pZGxlY3QyID0gb21hcF9yZWFkdyhB
Uk1fSURMRUNUMik7IC8vIGFwaV9jayBpcyBpbiBBUk1fSURMRUNUMgotCWNsa19lbmFibGUoYXBp
X2NrX2hhbmRsZSk7Ci0JX19yYXdfd3JpdGV3KHNhdmVfZHNwX2lkbGVjdDIsIERTUF9JRExFQ1Qy
KTsKLQlvbWFwX3dyaXRldyhzYXZlX2FybV9pZGxlY3QyLCBBUk1fSURMRUNUMik7Ci0JY2xrX2Rp
c2FibGUoYXBpX2NrX2hhbmRsZSk7Ci0KIAkvKiBSdW4gRFNQLCBpZiBpdCB3YXMgcnVubmluZyAq
LwogCWlmIChjcHVzdGF0LnN0YXQgIT0gQ1BVU1RBVF9SRVNFVCkKIAkJX19kc3BfcnVuKCk7CmRp
ZmYgLXVyTiBsaW51eC1vbWFwLTIuNi9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL3BtLmggbGlu
dXgtb21hcC0yLjYtZHNwX2NrZml4L2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvcG0uaAotLS0g
bGludXgtb21hcC0yLjYvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9wbS5oCTIwMDYtMDEtMTAg
MjA6MTU6NTUgKzA5OjAwCisrKyBsaW51eC1vbWFwLTIuNi1kc3BfY2tmaXgvaW5jbHVkZS9hc20t
YXJtL2FyY2gtb21hcC9wbS5oCTIwMDYtMDEtMTMgMTk6NDg6NTEgKzA5OjAwCkBAIC0xNTcsNiAr
MTU3LDEwIEBACiAjZGVmaW5lIEFSTV9SRVNUT1JFKHgpIG9tYXBfd3JpdGVsKChhcm1fc2xlZXBf
c2F2ZVtBUk1fU0xFRVBfU0FWRV8jI3hdKSwgKHgpKQogI2RlZmluZSBBUk1fU0hPVyh4KSBhcm1f
c2xlZXBfc2F2ZVtBUk1fU0xFRVBfU0FWRV8jI3hdCiAKKyNkZWZpbmUgRFNQX1NBVkUoeCkgZHNw
X3NsZWVwX3NhdmVbRFNQX1NMRUVQX1NBVkVfIyN4XSA9IF9fcmF3X3JlYWR3KHgpCisjZGVmaW5l
IERTUF9SRVNUT1JFKHgpIF9fcmF3X3dyaXRldygoZHNwX3NsZWVwX3NhdmVbRFNQX1NMRUVQX1NB
VkVfIyN4XSksICh4KSkKKyNkZWZpbmUgRFNQX1NIT1coeCkgZHNwX3NsZWVwX3NhdmVbRFNQX1NM
RUVQX1NBVkVfIyN4XQorCiAjZGVmaW5lIFVMUERfU0FWRSh4KSB1bHBkX3NsZWVwX3NhdmVbVUxQ
RF9TTEVFUF9TQVZFXyMjeF0gPSBvbWFwX3JlYWR3KHgpCiAjZGVmaW5lIFVMUERfUkVTVE9SRSh4
KSBvbWFwX3dyaXRldygodWxwZF9zbGVlcF9zYXZlW1VMUERfU0xFRVBfU0FWRV8jI3hdKSwgKHgp
KQogI2RlZmluZSBVTFBEX1NIT1coeCkgdWxwZF9zbGVlcF9zYXZlW1VMUERfU0xFRVBfU0FWRV8j
I3hdCkBAIC0xOTMsNiArMTk3LDE1IEBACiAJQVJNX1NMRUVQX1NBVkVfQVJNX1JTVENUMiwKIAlB
Uk1fU0xFRVBfU0FWRV9BUk1fU1lTU1QsCiAJQVJNX1NMRUVQX1NBVkVfU0laRQorfTsKKworZW51
bSBkc3Bfc2F2ZV9zdGF0ZSB7CisJRFNQX1NMRUVQX1NBVkVfU1RBUlQgPSAwLAorCS8qCisJICog
RFNQIHJlZ2lzdGVycyAxNiBiaXRzCisJICovCisJRFNQX1NMRUVQX1NBVkVfRFNQX0lETEVDVDIs
CisJRFNQX1NMRUVQX1NBVkVfU0laRQogfTsKIAogZW51bSB1bHBkX3NhdmVfc3RhdGUgewo=

------_=_NextPart_001_01C6183C.B3709743
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C6183C.B3709743--
