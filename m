From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: TSC2101/2102
Date: Tue, 3 Apr 2007 11:10:13 -0400
Message-ID: <a0580c510704030810x2808fe0ara07c55914c536173@mail.gmail.com>
References: <20070320153812.GI19913@atomide.com>
	<20070322084830.1a91c99c.jarkko.nikula@nokia.com>
	<20070330184933.GB18375@atomide.com>
	<a0580c510703310552h2d455e30qb145270bec2be37f@mail.gmail.com>
	<20070331170100.GA2565@bitbox>
	<a0580c510704020643k6c29da26h548385a1dd1b348f@mail.gmail.com>
	<20070402202325.GA23808@bitbox>
	<a0580c510704021341y476604b7l129b11f6a8ce4f57@mail.gmail.com>
	<a0580c510704030422u1ce3df44n45c4617fa2abb1a8@mail.gmail.com>
	<20070403143616.GA12681@bitbox>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12122_4528108.1175613013543"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070403143616.GA12681@bitbox>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Imre Deak <imre.deak@solidboot.com>
Cc: Kyungmin Park <kmpark@infradead.org>, Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_12122_4528108.1175613013543
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Imre,


   All right, I agreed with you :). I'm re-sending now an updated
patch. Now it uses  platform_data field to pass the spi_device to lcd.
The lcd now is working here. It also fix the omap_h2_1610_defconfig
file to include CONFIG_SPI_TSC2101 option.

   I applied/tested it against commit 6cb703eea609cb60448ce71740495c24ac0e9646.

Cheers,

On 4/3/07, Imre Deak <imre.deak@solidboot.com> wrote:
> Hi,
>
> On Tue, Apr 03, 2007 at 07:22:57AM -0400, Eduardo Valentin wrote:
> > Hello again Imre,
> >
> >
> >   I didn't understand properly your question. My bad. Sorry.
> >   I used set_drvdata because it is used into lcd_h2.c (accordingly to
> > my previous patch):
> > @@ -117,6 +97,19 @@ struct lcd_panel h2_panel = {
> >
> > static int h2_panel_probe(struct platform_device *pdev)
> > {
> > +     struct spi_device *tsc2101;
> > +
> > +     tsc2101 = dev_get_drvdata(&pdev->dev);
> > +     if (tsc2101 == NULL) {
> > +             dev_err(&pdev->dev, "no platform data\n");
> > +             return -ENODEV;
> > +     }
> >
> >   Of course, it is clear enough that this dev_err message is wrong.
> > It must be "no driver data". My bad again. However, why do you suggest
> > use platform_data instead of driver_data?
>
> That's the standard way platforms pass init data to the driver. The
> driver can then use the driver_data field for it's own purpose.
>
> But more important would be to know why platform_data gets zero'd, since
> the device core is not touching it. A workaround you're proposing might
> just delay some other problem..
>
> --Imre
>


-- 
Eduardo Bezerra Valentin

------=_Part_12122_4528108.1175613013543
Content-Type: text/x-patch; name=patch_fix_h2_lcd.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f02h3hev
Content-Disposition: attachment; filename="patch_fix_h2_lcd.diff"

VGhpcyBpcyBhbiB1cGRhdGVkIHBhdGNoIHRvIGZpeCBsY2QgZm9yIEgyIGJvYXJkLiBJdCB1c2Vz
IHBsYXRmb3JtX2RhdGEgZmllbGQKdG8gcGFzcyBzcGlfZGV2aWNlIHRvIGxjZCBkcml2ZXIuCgpT
aWduZWQtb2ZmLWJ5OiBFZHVhcmRvIFZhbGVudGluIDxlZHVhcmRvLnZhbGVudGluQGluZHQub3Jn
LmJyPgoKSW5kZXg6IGxpbnV4LW9tYXAtMi42L2RyaXZlcnMvdmlkZW8vb21hcC9sY2RfaDIuYwo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC1vbWFwLTIuNi5vcmlnL2RyaXZlcnMvdmlkZW8vb21hcC9sY2Rf
aDIuYwkyMDA3LTA0LTAzIDEwOjUzOjQzLjAwMDAwMDAwMCAtMDQwMAorKysgbGludXgtb21hcC0y
LjYvZHJpdmVycy92aWRlby9vbWFwL2xjZF9oMi5jCTIwMDctMDQtMDMgMTA6NTU6NTYuMDAwMDAw
MDAwIC0wNDAwCkBAIC0yMyw0MiArMjMsMTggQEAKIAogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5o
PgogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4L3Nw
aS90c2MyMTAxLmg+CiAKICNpbmNsdWRlIDxhc20vYXJjaC9tdXguaD4KICNpbmNsdWRlIDxhc20v
YXJjaC9vbWFwZmIuaD4KIAotI2luY2x1ZGUgIi4uL2RyaXZlcnMvc3NpL29tYXAtdXdpcmUuaCIK
LQotI2RlZmluZSBNT0RVTEVfTkFNRQkJIm9tYXBmYi1sY2RfaDIiCi0jZGVmaW5lIFRTQzIxMDFf
VVdJUkVfQ1MJMQotCi0jZGVmaW5lIHByX2VycihmbXQsIGFyZ3MuLi4pIHByaW50ayhLRVJOX0VS
UiBNT0RVTEVfTkFNRSAiOiAiIGZtdCwgIyMgYXJncykKLQotc3RhdGljIGludCB0c2MyMTAxX3dy
aXRlX3JlZyhpbnQgcGFnZSwgaW50IHJlZywgdTE2IGRhdGEpCi17Ci0JdTE2CWNtZDsKLQlpbnQJ
cjsKLQotCWNtZCA9ICgocGFnZSAmIDMpIDw8IDExKSB8ICgocmVnICYgMHgzZikgPDwgNSk7Ci0J
aWYgKG9tYXBfdXdpcmVfZGF0YV90cmFuc2ZlcihUU0MyMTAxX1VXSVJFX0NTLCBjbWQsIDE2LCAw
LCBOVUxMLCAxKSkKLQkJciA9IC0xOwotCWVsc2UKLQkJciA9IG9tYXBfdXdpcmVfZGF0YV90cmFu
c2ZlcihUU0MyMTAxX1VXSVJFX0NTLCBkYXRhLCAxNiwgMCwKLQkJCQkJICAgICBOVUxMLCAwKTsK
LQotCXJldHVybiByOwotfQorc3RhdGljIHN0cnVjdCB7CisJc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZQkqbGNkX2RldjsKKwlzdHJ1Y3Qgc3BpX2RldmljZQkqdHNjMjEwMV9kZXY7Cit9IGgyX3BhbmVs
X2RldjsKIAogc3RhdGljIGludCBoMl9wYW5lbF9pbml0KHN0cnVjdCBsY2RfcGFuZWwgKnBhbmVs
LCBzdHJ1Y3Qgb21hcGZiX2RldmljZSAqZmJkZXYpCiB7Ci0JdW5zaWduZWQgbG9uZyB1d2lyZV9m
bGFnczsKLQotCSAvKiBDb25maWd1cmUgTjE1IHBpbiB0byBiZSB1V2lyZSBDUzEgKi8KLQlvbWFw
X2NmZ19yZWcoTjE1XzE2MTBfVVdJUkVfQ1MxKTsKLQl1d2lyZV9mbGFncyA9IFVXSVJFX1JFQURf
UklTSU5HX0VER0UgfCBVV0lSRV9XUklURV9SSVNJTkdfRURHRTsKLQl1d2lyZV9mbGFncyB8PSBV
V0lSRV9GUkVRX0RJVl84OwotCW9tYXBfdXdpcmVfY29uZmlndXJlX21vZGUoVFNDMjEwMV9VV0lS
RV9DUywgdXdpcmVfZmxhZ3MpOwotCiAJcmV0dXJuIDA7CiB9CiAKQEAgLTczLDcgKzQ5LDEwIEBA
IHN0YXRpYyBpbnQgaDJfcGFuZWxfZW5hYmxlKHN0cnVjdCBsY2RfcGEKIAkvKiBBc3NlcnQgTENE
X0VOLCBCS0xJR0hUX0VOIHBpbnMgb24gTENEIHBhbmVsCiAJICogcGFnZTIsIEdQSU8gY29uZmln
IHJlZywgR1BJTygwLDEpIHRvIG91dCBhbmQgYXNzZXJ0ZWQKIAkgKi8KLQlyID0gdHNjMjEwMV93
cml0ZV9yZWcoMiwgMHgyMywgMHhDQzAwKSA/IC0xIDogMDsKKwlyID0gdHNjMjEwMV93cml0ZV9z
eW5jKGgyX3BhbmVsX2Rldi50c2MyMTAxX2RldiwgMiwgMHgyMywgMHhjYzAwKTsKKwlpZiAociA8
IDApCisJCWRldl9lcnIoJmgyX3BhbmVsX2Rldi5sY2RfZGV2LT5kZXYsCisJCQkiZmFpbGVkIHRv
IGVuYWJsZSBMQ0QgcGFuZWxcbiIpOwogCiAJcmV0dXJuIHI7CiB9CkBAIC04Myw4ICs2Miw5IEBA
IHN0YXRpYyB2b2lkIGgyX3BhbmVsX2Rpc2FibGUoc3RydWN0IGxjZF8KIAkvKiBEZWFzc2VydCBM
Q0RfRU4gYW5kIEJLTElHSFRfRU4gcGlucyBvbiBMQ0QgcGFuZWwKIAkgKiBwYWdlMiwgR1BJTyBj
b25maWcgcmVnLCBHUElPKDAsMSkgdG8gb3V0IGFuZCBkZWFzc2VydGVkCiAJICovCi0JaWYgKHRz
YzIxMDFfd3JpdGVfcmVnKDIsIDB4MjMsIDB4ODgwMCkpCi0JCXByX2VycigiZmFpbGVkIHRvIGRp
c2FibGUgTENEIHBhbmVsXG4iKTsKKwlpZiAodHNjMjEwMV93cml0ZV9zeW5jKGgyX3BhbmVsX2Rl
di50c2MyMTAxX2RldiwgMiwgMHgyMywgMHg4ODAwKSkKKwkJZGV2X2VycigmaDJfcGFuZWxfZGV2
LmxjZF9kZXYtPmRldiwKKwkJCSJmYWlsZWQgdG8gZGlzYWJsZSBMQ0QgcGFuZWxcbiIpOwogfQog
CiBzdGF0aWMgdW5zaWduZWQgbG9uZyBoMl9wYW5lbF9nZXRfY2FwcyhzdHJ1Y3QgbGNkX3BhbmVs
ICpwYW5lbCkKQEAgLTExNyw2ICs5NywxOSBAQCBzdHJ1Y3QgbGNkX3BhbmVsIGgyX3BhbmVsID0g
ewogCiBzdGF0aWMgaW50IGgyX3BhbmVsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCiB7CisJc3RydWN0IHNwaV9kZXZpY2UgKnRzYzIxMDE7CisKKwl0c2MyMTAxID0gcGRldi0+
ZGV2LnBsYXRmb3JtX2RhdGE7CisJaWYgKHRzYzIxMDEgPT0gTlVMTCkgeworCQlkZXZfZXJyKCZw
ZGV2LT5kZXYsICJubyBwbGF0Zm9ybSBkYXRhXG4iKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQor
CWlmIChzdHJuY21wKHRzYzIxMDEtPm1vZGFsaWFzLCAidHNjMjEwMSIsIDgpICE9IDApIHsKKwkJ
ZGV2X2VycigmcGRldi0+ZGV2LCAidHNjMjEwMSBub3QgZm91bmRcbiIpOworCQlyZXR1cm4gLUVJ
TlZBTDsKKwl9CisJaDJfcGFuZWxfZGV2LmxjZF9kZXYgPSBwZGV2OworCWgyX3BhbmVsX2Rldi50
c2MyMTAxX2RldiA9IHRzYzIxMDE7CiAJb21hcGZiX3JlZ2lzdGVyX3BhbmVsKCZoMl9wYW5lbCk7
CiAJcmV0dXJuIDA7CiB9CkluZGV4OiBsaW51eC1vbWFwLTIuNi9hcmNoL2FybS9tYWNoLW9tYXAx
L2JvYXJkLWgyLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtb21hcC0yLjYub3JpZy9hcmNoL2FybS9t
YWNoLW9tYXAxL2JvYXJkLWgyLmMJMjAwNy0wNC0wMyAxMDo1Mzo0My4wMDAwMDAwMDAgLTA0MDAK
KysrIGxpbnV4LW9tYXAtMi42L2FyY2gvYXJtL21hY2gtb21hcDEvYm9hcmQtaDIuYwkyMDA3LTA0
LTAzIDEwOjU1OjU2LjAwMDAwMDAwMCAtMDQwMApAQCAtMzA1LDYgKzMwNSwxNyBAQCBzdHJ1Y3Qg
ewogI2RlZmluZSBUU0MyMTAxX01VWF9NQ0xLX09OCVIxMF8xNjEwX01DTEtfT04KICNkZWZpbmUg
VFNDMjEwMV9NVVhfTUNMS19PRkYJUjEwXzE2MTBfTUNMS19PRkYKIAorc3RhdGljIHZvaWQgaDJf
bGNkX2Rldl9pbml0KHN0cnVjdCBzcGlfZGV2aWNlICp0c2MyMTAxKQoreworCS8qIFRoZSBMQ0Qg
aXMgY29ubmVjdGVkIHRvIHRoZSBHUElPIHBpbnMgb2YgdGhlIFRTQzIxMDEsIHNvCisJICogd2Ug
aGF2ZSB0byB0aWUgdGhlbSBoZXJlLiBXZSBjYW4gYWxzbyByZWdpc3RlciB0aGUgTENEIGRyaXZl
cgorCSAqIGZpcnN0IG9ubHkgaGVyZSwgd2hlcmUgd2Uga25vdyB0aGF0IHRoZSBUU0MgZHJpdmVy
IGlzIHJlYWR5LgorCSAqLworCisJaDJfbGNkX2RldmljZS5kZXYucGxhdGZvcm1fZGF0YSA9IHRz
YzIxMDE7CisJcGxhdGZvcm1fZGV2aWNlX3JlZ2lzdGVyKCZoMl9sY2RfZGV2aWNlKTsKK30KKwog
c3RhdGljIGludCBoMl90c2MyMTAxX2luaXQoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkKIHsKIAlp
bnQgcjsKQEAgLTMyOCw2ICszMzksOCBAQCBzdGF0aWMgaW50IGgyX3RzYzIxMDFfaW5pdChzdHJ1
Y3Qgc3BpX2RlCiAJb21hcF9jZmdfcmVnKFRTQzIxMDFfTVVYX01DTEtfT0ZGKTsKIAlvbWFwX2Nm
Z19yZWcoTjE1XzE2MTBfVVdJUkVfQ1MxKTsKIAorCWgyX2xjZF9kZXZfaW5pdChzcGkpOworCiAJ
cmV0dXJuIDA7CiBlcnI6CiAJY2xrX3B1dChoMl90c2MyMTAxLm1jbGspOwpAQCAtNDEwLDcgKzQy
Myw2IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpoMl9kZXZpY2UKIAkmaDJfc21j
OTF4X2RldmljZSwKIAkmaDJfaXJkYV9kZXZpY2UsCiAJJmgyX2twX2RldmljZSwKLQkmaDJfbGNk
X2RldmljZSwKIAkmaDJfbWNic3AxX2RldmljZSwKIH07CiAKSW5kZXg6IGxpbnV4LW9tYXAtMi42
L2FyY2gvYXJtL2NvbmZpZ3Mvb21hcF9oMl8xNjEwX2RlZmNvbmZpZwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBs
aW51eC1vbWFwLTIuNi5vcmlnL2FyY2gvYXJtL2NvbmZpZ3Mvb21hcF9oMl8xNjEwX2RlZmNvbmZp
ZwkyMDA3LTA0LTAzIDExOjAwOjQ2LjAwMDAwMDAwMCAtMDQwMAorKysgbGludXgtb21hcC0yLjYv
YXJjaC9hcm0vY29uZmlncy9vbWFwX2gyXzE2MTBfZGVmY29uZmlnCTIwMDctMDQtMDMgMTE6MDE6
MjcuMDAwMDAwMDAwIC0wNDAwCkBAIC03NjIsNyArNzYyLDcgQEAgQ09ORklHX1NQSV9PTUFQX1VX
SVJFPXkKICMKICMgU1BJIFByb3RvY29sIE1hc3RlcnMKICMKLUNPTkZJR19UU0MyMTAxPXkKK0NP
TkZJR19TUElfVFNDMjEwMT15CiAjIENPTkZJR19UU0MyMTAyIGlzIG5vdCBzZXQKICMgQ09ORklH
X1NQSV9BVDI1IGlzIG5vdCBzZXQKIAo=
------=_Part_12122_4528108.1175613013543
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_12122_4528108.1175613013543--
