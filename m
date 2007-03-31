From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: TSC2101/2102
Date: Sat, 31 Mar 2007 08:52:17 -0400
Message-ID: <a0580c510703310552h2d455e30qb145270bec2be37f@mail.gmail.com>
References: <00f201c769ca$a8e022c0$c7a3580a@swcenter.sec.samsung.co.kr>
	<010f01c769fd$4ab24d30$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070319103711.36ffe999.jarkko.nikula@nokia.com>
	<006e01c76a91$8ee234e0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070320132757.GB19913@atomide.com>
	<20070320155455.c1a3219b.jarkko.nikula@nokia.com>
	<20070320153812.GI19913@atomide.com>
	<a0580c510703211224y60c9283bv822276225c3e2c08@mail.gmail.com>
	<20070322084830.1a91c99c.jarkko.nikula@nokia.com>
	<20070330184933.GB18375@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_85039_10315273.1175345537708"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070330184933.GB18375@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>, Kyungmin Park <kmpark@infradead.org>
List-Id: linux-omap@vger.kernel.org

------=_Part_85039_10315273.1175345537708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Tony,


    This is an updated patch to fix lcd for H2 board. This one is
applied against
current linux omap (commit ).

    The patch is a merge of what was discussed here and what is already pushed.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

BR,

Eduardo Valentin

On 3/30/07, Tony Lindgren <tony@atomide.com> wrote:
> * Jarkko Nikula <jarkko.nikula@nokia.com> [070322 02:50]:
> > On Wed, 21 Mar 2007 15:24:21 -0400
> > "ext Eduardo Valentin" <edubezval@gmail.com> wrote:
> >
> > > This patch (patch-lcd-h2-spi-fix.diff) applies on top of Imre Deak's
> > > patch (spi-tsc2101-patch.diff).
> > >
> > Hi, my two cents. It seems that almost everyone forgot to update/remove
> > path names in comment section when moving files to another directory :-)
> >
> > spi-tsc2101-patch.diff:
> >
> > --- /dev/null 1970-01-01 00:00:00.000000000 +0000
> > +++ linux-omap-2.6/drivers/spi/tsc2101.c      2007-03-21
> > 15:12:49.000000000 -0400 @@ -0,0 +1,327 @@
> > +/*
> > + * linux/drivers/ssi/omap-tsc2101.c
> > + *
> >
> > ===================================================================
> > --- /dev/null 1970-01-01 00:00:00.000000000 +0000
> > +++ linux-omap-2.6/include/linux/spi/tsc2101.h        2007-03-21
> > 15:12:49.000000000 -0400 @@ -0,0 +1,43 @@
> > +/*
> > + * linux/drivers/ssi/omap-tsc2101.h
> > + *
> >
>
> Kyungmin, Eduardo & Jarkko, please sign your patches above so I can
> apply them!
>
> Tony
>


-- 
Eduardo Bezerra Valentin

------=_Part_85039_10315273.1175345537708
Content-Type: text/x-patch; name=patch_fix_h2_lcd.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ezxb3w5c
Content-Disposition: attachment; filename="patch_fix_h2_lcd.diff"

SW5kZXg6IGxpbnV4LW9tYXAtMi42L2RyaXZlcnMvdmlkZW8vb21hcC9sY2RfaDIuYwo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBsaW51eC1vbWFwLTIuNi5vcmlnL2RyaXZlcnMvdmlkZW8vb21hcC9sY2RfaDIuYwky
MDA3LTAzLTMwIDE0OjIxOjUwLjAwMDAwMDAwMCAtMDQwMAorKysgbGludXgtb21hcC0yLjYvZHJp
dmVycy92aWRlby9vbWFwL2xjZF9oMi5jCTIwMDctMDMtMzAgMTQ6MjI6MDEuMDAwMDAwMDAwIC0w
NDAwCkBAIC0yMyw0MiArMjMsMTggQEAKIAogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgogI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L3NwaS90c2My
MTAxLmg+CiAKICNpbmNsdWRlIDxhc20vYXJjaC9tdXguaD4KICNpbmNsdWRlIDxhc20vYXJjaC9v
bWFwZmIuaD4KIAotI2luY2x1ZGUgIi4uL2RyaXZlcnMvc3NpL29tYXAtdXdpcmUuaCIKLQotI2Rl
ZmluZSBNT0RVTEVfTkFNRQkJIm9tYXBmYi1sY2RfaDIiCi0jZGVmaW5lIFRTQzIxMDFfVVdJUkVf
Q1MJMQotCi0jZGVmaW5lIHByX2VycihmbXQsIGFyZ3MuLi4pIHByaW50ayhLRVJOX0VSUiBNT0RV
TEVfTkFNRSAiOiAiIGZtdCwgIyMgYXJncykKLQotc3RhdGljIGludCB0c2MyMTAxX3dyaXRlX3Jl
ZyhpbnQgcGFnZSwgaW50IHJlZywgdTE2IGRhdGEpCi17Ci0JdTE2CWNtZDsKLQlpbnQJcjsKLQot
CWNtZCA9ICgocGFnZSAmIDMpIDw8IDExKSB8ICgocmVnICYgMHgzZikgPDwgNSk7Ci0JaWYgKG9t
YXBfdXdpcmVfZGF0YV90cmFuc2ZlcihUU0MyMTAxX1VXSVJFX0NTLCBjbWQsIDE2LCAwLCBOVUxM
LCAxKSkKLQkJciA9IC0xOwotCWVsc2UKLQkJciA9IG9tYXBfdXdpcmVfZGF0YV90cmFuc2ZlcihU
U0MyMTAxX1VXSVJFX0NTLCBkYXRhLCAxNiwgMCwKLQkJCQkJICAgICBOVUxMLCAwKTsKLQotCXJl
dHVybiByOwotfQorc3RhdGljIHN0cnVjdCB7CisJc3RydWN0IHBsYXRmb3JtX2RldmljZQkqbGNk
X2RldjsKKwlzdHJ1Y3Qgc3BpX2RldmljZQkqdHNjMjEwMV9kZXY7Cit9IGgyX3BhbmVsX2RldjsK
IAogc3RhdGljIGludCBoMl9wYW5lbF9pbml0KHN0cnVjdCBsY2RfcGFuZWwgKnBhbmVsLCBzdHJ1
Y3Qgb21hcGZiX2RldmljZSAqZmJkZXYpCiB7Ci0JdW5zaWduZWQgbG9uZyB1d2lyZV9mbGFnczsK
LQotCSAvKiBDb25maWd1cmUgTjE1IHBpbiB0byBiZSB1V2lyZSBDUzEgKi8KLQlvbWFwX2NmZ19y
ZWcoTjE1XzE2MTBfVVdJUkVfQ1MxKTsKLQl1d2lyZV9mbGFncyA9IFVXSVJFX1JFQURfUklTSU5H
X0VER0UgfCBVV0lSRV9XUklURV9SSVNJTkdfRURHRTsKLQl1d2lyZV9mbGFncyB8PSBVV0lSRV9G
UkVRX0RJVl84OwotCW9tYXBfdXdpcmVfY29uZmlndXJlX21vZGUoVFNDMjEwMV9VV0lSRV9DUywg
dXdpcmVfZmxhZ3MpOwotCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTczLDcgKzQ5LDEwIEBAIHN0YXRp
YyBpbnQgaDJfcGFuZWxfZW5hYmxlKHN0cnVjdCBsY2RfcGEKIAkvKiBBc3NlcnQgTENEX0VOLCBC
S0xJR0hUX0VOIHBpbnMgb24gTENEIHBhbmVsCiAJICogcGFnZTIsIEdQSU8gY29uZmlnIHJlZywg
R1BJTygwLDEpIHRvIG91dCBhbmQgYXNzZXJ0ZWQKIAkgKi8KLQlyID0gdHNjMjEwMV93cml0ZV9y
ZWcoMiwgMHgyMywgMHhDQzAwKSA/IC0xIDogMDsKKwlyID0gdHNjMjEwMV93cml0ZV9zeW5jKGgy
X3BhbmVsX2Rldi50c2MyMTAxX2RldiwgMiwgMHgyMywgMHhjYzAwKTsKKwlpZiAociA8IDApCisJ
CWRldl9lcnIoJmgyX3BhbmVsX2Rldi5sY2RfZGV2LT5kZXYsCisJCQkiZmFpbGVkIHRvIGVuYWJs
ZSBMQ0QgcGFuZWxcbiIpOwogCiAJcmV0dXJuIHI7CiB9CkBAIC04Myw4ICs2Miw5IEBAIHN0YXRp
YyB2b2lkIGgyX3BhbmVsX2Rpc2FibGUoc3RydWN0IGxjZF8KIAkvKiBEZWFzc2VydCBMQ0RfRU4g
YW5kIEJLTElHSFRfRU4gcGlucyBvbiBMQ0QgcGFuZWwKIAkgKiBwYWdlMiwgR1BJTyBjb25maWcg
cmVnLCBHUElPKDAsMSkgdG8gb3V0IGFuZCBkZWFzc2VydGVkCiAJICovCi0JaWYgKHRzYzIxMDFf
d3JpdGVfcmVnKDIsIDB4MjMsIDB4ODgwMCkpCi0JCXByX2VycigiZmFpbGVkIHRvIGRpc2FibGUg
TENEIHBhbmVsXG4iKTsKKwlpZiAodHNjMjEwMV93cml0ZV9zeW5jKGgyX3BhbmVsX2Rldi50c2My
MTAxX2RldiwgMiwgMHgyMywgMHg4ODAwKSkKKwkJZGV2X2VycigmaDJfcGFuZWxfZGV2LmxjZF9k
ZXYtPmRldiwKKwkJCSJmYWlsZWQgdG8gZGlzYWJsZSBMQ0QgcGFuZWxcbiIpOwogfQogCiBzdGF0
aWMgdW5zaWduZWQgbG9uZyBoMl9wYW5lbF9nZXRfY2FwcyhzdHJ1Y3QgbGNkX3BhbmVsICpwYW5l
bCkKQEAgLTExNyw2ICs5NywxOSBAQCBzdHJ1Y3QgbGNkX3BhbmVsIGgyX3BhbmVsID0gewogCiBz
dGF0aWMgaW50IGgyX3BhbmVsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7
CisJc3RydWN0IHNwaV9kZXZpY2UgKnRzYzIxMDE7CisKKwl0c2MyMTAxID0gZGV2X2dldF9kcnZk
YXRhKCZwZGV2LT5kZXYpOworCWlmICh0c2MyMTAxID09IE5VTEwpIHsKKwkJZGV2X2VycigmcGRl
di0+ZGV2LCAibm8gcGxhdGZvcm0gZGF0YVxuIik7CisJCXJldHVybiAtRU5PREVWOworCX0KKwlp
ZiAoc3RybmNtcCh0c2MyMTAxLT5tb2RhbGlhcywgInRzYzIxMDEiLCA4KSAhPSAwKSB7CisJCWRl
dl9lcnIoJnBkZXYtPmRldiwgInRzYzIxMDEgbm90IGZvdW5kXG4iKTsKKwkJcmV0dXJuIC1FSU5W
QUw7CisJfQorCWgyX3BhbmVsX2Rldi5sY2RfZGV2ID0gcGRldjsKKwloMl9wYW5lbF9kZXYudHNj
MjEwMV9kZXYgPSB0c2MyMTAxOwogCW9tYXBmYl9yZWdpc3Rlcl9wYW5lbCgmaDJfcGFuZWwpOwog
CXJldHVybiAwOwogfQpJbmRleDogbGludXgtb21hcC0yLjYvYXJjaC9hcm0vbWFjaC1vbWFwMS9i
b2FyZC1oMi5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LW9tYXAtMi42Lm9yaWcvYXJjaC9hcm0vbWFj
aC1vbWFwMS9ib2FyZC1oMi5jCTIwMDctMDMtMzAgMTQ6MjY6MTMuMDAwMDAwMDAwIC0wNDAwCisr
KyBsaW51eC1vbWFwLTIuNi9hcmNoL2FybS9tYWNoLW9tYXAxL2JvYXJkLWgyLmMJMjAwNy0wMy0z
MCAxNDozNjo1My4wMDAwMDAwMDAgLTA0MDAKQEAgLTMwNSw2ICszMDUsMTkgQEAgc3RydWN0IHsK
ICNkZWZpbmUgVFNDMjEwMV9NVVhfTUNMS19PTglSMTBfMTYxMF9NQ0xLX09OCiAjZGVmaW5lIFRT
QzIxMDFfTVVYX01DTEtfT0ZGCVIxMF8xNjEwX01DTEtfT0ZGCiAKK3N0YXRpYyB2b2lkIGgyX2xj
ZF9kZXZfaW5pdChzdHJ1Y3Qgc3BpX2RldmljZSAqdHNjMjEwMSkKK3sKKwkvKiBUaGUgTENEIGlz
IGNvbm5lY3RlZCB0byB0aGUgR1BJTyBwaW5zIG9mIHRoZSBUU0MyMTAxLCBzbworCSAqIHdlIGhh
dmUgdG8gdGllIHRoZW0gaGVyZS4gV2UgY2FuIGFsc28gcmVnaXN0ZXIgdGhlIExDRCBkcml2ZXIK
KwkgKiBmaXJzdCBvbmx5IGhlcmUsIHdoZXJlIHdlIGtub3cgdGhhdCB0aGUgVFNDIGRyaXZlciBp
cyByZWFkeS4KKwkgKi8KKworCWRldmljZV9pbml0aWFsaXplKCZoMl9sY2RfZGV2aWNlLmRldik7
CisKKwlkZXZfc2V0X2RydmRhdGEoJmgyX2xjZF9kZXZpY2UuZGV2LCB0c2MyMTAxKTsKKwlwbGF0
Zm9ybV9kZXZpY2VfYWRkKCZoMl9sY2RfZGV2aWNlKTsKK30KKwogc3RhdGljIGludCBoMl90c2My
MTAxX2luaXQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkKIHsKIAlpbnQgcjsKQEAgLTMyOCw2ICsz
NDEsOCBAQCBzdGF0aWMgaW50IGgyX3RzYzIxMDFfaW5pdChzdHJ1Y3Qgc3BpX2RlCiAJb21hcF9j
ZmdfcmVnKFRTQzIxMDFfTVVYX01DTEtfT0ZGKTsKIAlvbWFwX2NmZ19yZWcoTjE1XzE2MTBfVVdJ
UkVfQ1MxKTsKIAorCWgyX2xjZF9kZXZfaW5pdChzcGkpOworCiAJcmV0dXJuIDA7CiBlcnI6CiAJ
Y2xrX3B1dChoMl90c2MyMTAxLm1jbGspOwpAQCAtNDEwLDcgKzQyNSw2IEBAIHN0YXRpYyBzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpoMl9kZXZpY2UKIAkmaDJfc21jOTF4X2RldmljZSwKIAkmaDJf
aXJkYV9kZXZpY2UsCiAJJmgyX2twX2RldmljZSwKLQkmaDJfbGNkX2RldmljZSwKIAkmaDJfbWNi
c3AxX2RldmljZSwKIH07CiAK
------=_Part_85039_10315273.1175345537708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_85039_10315273.1175345537708--
