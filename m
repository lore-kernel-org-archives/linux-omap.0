From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 2/6] OMAP: Update ov9640 ifparm for H3 board.
Date: Thu, 1 Nov 2007 11:32:41 -0400
Message-ID: <a0580c510711010832q5d6c9c05o8bf3f81682fad217@mail.gmail.com>
References: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
	<1191934353-24072-2-git-send-email-edubezval@gmail.com>
	<1191934353-24072-3-git-send-email-edubezval@gmail.com>
	<20071031104110.GB31081@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12229_7486950.1193931161759"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071031104110.GB31081@atomide.com>
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
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, linux-omap-mailing-list <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_12229_7486950.1193931161759
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Tony,

I'm re-sending the patch. As I said, it was based on board-h4.c. But I
totally agree with you. I believe this new one is a better way to
implement it. Unnecessary structures and functions are not created if
the OV9640 is not selected. I've just compiled tested this new patch.

Cheers,

On 10/31/07, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Eduardo Valentin <edubezval@gmail.com> [071009 05:53]:
> > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> >
> > This code is based on board-h4.c and drivers/media/video/omap/h3_sensor_power.c codes.
> >
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> > ---
> >  arch/arm/mach-omap1/board-h3.c |  140 ++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 140 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
> > index df77cf5..8ecc5f2 100644
> > --- a/arch/arm/mach-omap1/board-h3.c
> > +++ b/arch/arm/mach-omap1/board-h3.c
>
> <snip>
>
> > @@ -547,6 +552,138 @@ static int nand_dev_ready(struct nand_platform_data *data)
> >       return omap_get_gpio_datain(H3_NAND_RB_GPIO_PIN);
> >  }
> >
> > +/*
> > + * Common OV9640 register initialization for all image sizes, pixel formats,
> > + * and frame rates
> > + */
> > +const static struct ov9640_reg ov9640_common[] = {
> > +
> > +     { 0x12, 0x80 }, { 0x11, 0x80 }, { 0x13, 0x88 }, /* COM7, CLKRC, COM8 */
> > +     { 0x01, 0x58 }, { 0x02, 0x24 }, { 0x04, 0x00 }, /* BLUE, RED, COM1 */
> > +     { 0x0E, 0x81 }, { 0x0F, 0x4F }, { 0x14, 0xcA }, /* COM5, COM6, COM9 */
> > +     { 0x16, 0x02 }, { 0x1B, 0x01 }, { 0x24, 0x70 }, /* ?, PSHFT, AEW */
> > +     { 0x25, 0x68 }, { 0x26, 0xD3 }, { 0x27, 0x90 }, /* AEB, VPT, BBIAS */
> > +     { 0x2A, 0x00 }, { 0x2B, 0x00 }, { 0x32, 0x24 }, /* EXHCH, EXHCL, HREF */
> > +     { 0x33, 0x02 }, { 0x37, 0x02 }, { 0x38, 0x13 }, /* CHLF, ADC, ACOM */
> > +     { 0x39, 0xF0 }, { 0x3A, 0x00 }, { 0x3B, 0x01 }, /* OFON, TSLB, COM11 */
> > +     { 0x3D, 0x90 }, { 0x3E, 0x02 }, { 0x3F, 0xF2 }, /* COM13, COM14, EDGE */
> > +     { 0x41, 0x02 }, { 0x42, 0xC8 },         /* COM16, COM17 */
> > +     { 0x43, 0xF0 }, { 0x44, 0x10 }, { 0x45, 0x6C }, /* ?, ?, ? */
> > +     { 0x46, 0x6C }, { 0x47, 0x44 }, { 0x48, 0x44 }, /* ?, ?, ? */
> > +     { 0x49, 0x03 }, { 0x59, 0x49 }, { 0x5A, 0x94 }, /* ?, ?, ? */
> > +     { 0x5B, 0x46 }, { 0x5C, 0x84 }, { 0x5D, 0x5C }, /* ?, ?, ? */
> > +     { 0x5E, 0x08 }, { 0x5F, 0x00 }, { 0x60, 0x14 }, /* ?, ?, ? */
> > +     { 0x61, 0xCE },                                 /* ? */
> > +     { 0x62, 0x70 }, { 0x63, 0x00 }, { 0x64, 0x04 }, /* LCC1, LCC2, LCC3 */
> > +     { 0x65, 0x00 }, { 0x66, 0x00 },                 /* LCC4, LCC5 */
> > +     { 0x69, 0x00 }, { 0x6A, 0x3E }, { 0x6B, 0x3F }, /* HV, MBD, DBLV */
> > +     { 0x6C, 0x40 }, { 0x6D, 0x30 }, { 0x6E, 0x4B }, /* GSP1, GSP2, GSP3 */
> > +     { 0x6F, 0x60 }, { 0x70, 0x70 }, { 0x71, 0x70 }, /* GSP4, GSP5, GSP6 */
> > +     { 0x72, 0x70 }, { 0x73, 0x70 }, { 0x74, 0x60 }, /* GSP7, GSP8, GSP9 */
> > +     { 0x75, 0x60 }, { 0x76, 0x50 }, { 0x77, 0x48 }, /* GSP10,GSP11,GSP12 */
> > +     { 0x78, 0x3A }, { 0x79, 0x2E }, { 0x7A, 0x28 }, /* GSP13,GSP14,GSP15 */
> > +     { 0x7B, 0x22 }, { 0x7C, 0x04 }, { 0x7D, 0x07 }, /* GSP16,GST1, GST2 */
> > +     { 0x7E, 0x10 }, { 0x7F, 0x28 }, { 0x80, 0x36 }, /* GST3, GST4, GST5 */
> > +     { 0x81, 0x44 }, { 0x82, 0x52 }, { 0x83, 0x60 }, /* GST6, GST7, GST8 */
> > +     { 0x84, 0x6C }, { 0x85, 0x78 }, { 0x86, 0x8C }, /* GST9, GST10,GST11 */
> > +     { 0x87, 0x9E }, { 0x88, 0xBB }, { 0x89, 0xD2 }, /* GST12,GST13,GST14 */
> > +     { 0x8A, 0xE6 }, { 0x13, 0xaF }, { 0x15, 0x02 }, /* GST15, COM8 */
> > +     { 0x22, 0x8a }, /* GROS */
> > +     { OV9640_REG_TERM, OV9640_VAL_TERM }
> > +};
> > +
> > +#if defined(CONFIG_VIDEO_OV9640) || defined(CONFIG_VIDEO_OV9640_MODULE)
>
> <snip>
>
> How about moving the struct ov9640_reg to be within CONFIG_VIDEO_OV9640?
>
> Regards,
>
> Tony
>


-- 
Eduardo Bezerra Valentin

------=_Part_12229_7486950.1193931161759
Content-Type: text/x-diff;
	name=0001-OMAP-Update-ov9640-ifparm-for-H3-board.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f8hfpyc3
Content-Disposition: attachment;
	filename=0001-OMAP-Update-ov9640-ifparm-for-H3-board.patch

RnJvbSBiNjAzMGVhYzI1ODI2MTU1MGI5NDZhYjIxMTEyNGNlZDM1MzYyODVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFZHVhcmRvIFZhbGVudGluIDxlZHVhcmRvLnZhbGVudGluQGlu
ZHQub3JnLmJyPgpEYXRlOiBXZWQsIDEwIE9jdCAyMDA3IDEwOjA2OjE4IC0wNDAwClN1YmplY3Q6
IFtQQVRDSF0gT01BUDogVXBkYXRlIG92OTY0MCBpZnBhcm0gZm9yIEgzIGJvYXJkLgoKVGhpcyBj
b2RlIGlzIGJhc2VkIG9uIGJvYXJkLWg0LmMgYW5kIGRyaXZlcnMvbWVkaWEvdmlkZW8vb21hcC9o
M19zZW5zb3JfcG93ZXIuYyBjb2Rlcy4KClNpZ25lZC1vZmYtYnk6IEVkdWFyZG8gVmFsZW50aW4g
PGVkdWFyZG8udmFsZW50aW5AaW5kdC5vcmcuYnI+Ci0tLQogYXJjaC9hcm0vbWFjaC1vbWFwMS9i
b2FyZC1oMy5jIHwgIDExMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGVzIGNoYW5nZWQsIDExMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtb21hcDEvYm9hcmQtaDMuYyBiL2FyY2gvYXJtL21hY2gt
b21hcDEvYm9hcmQtaDMuYwppbmRleCBkZjc3Y2Y1Li5mNjA5NWYwIDEwMDY0NAotLS0gYS9hcmNo
L2FybS9tYWNoLW9tYXAxL2JvYXJkLWgzLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1vbWFwMS9ib2Fy
ZC1oMy5jCkBAIC0yNiw2ICsyNiw3IEBACiAjaW5jbHVkZSA8bGludXgvbXRkL3BhcnRpdGlvbnMu
aD4KICNpbmNsdWRlIDxsaW51eC9pbnB1dC5oPgogI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2kyYy5oPgogI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4KICNpbmNsdWRl
IDxsaW51eC9zcGkvdHNjMjEwMS5oPgogCkBAIC0zNyw2ICszOCw4IEBACiAjaW5jbHVkZSA8YXNt
L21hY2gvZmxhc2guaD4KICNpbmNsdWRlIDxhc20vbWFjaC9tYXAuaD4KIAorI2luY2x1ZGUgPG1l
ZGlhL3Y0bDItaW50LWRldmljZS5oPgorCiAjaW5jbHVkZSA8YXNtL2FyY2gvZ3Bpby5oPgogI2lu
Y2x1ZGUgPGFzbS9hcmNoL2dwaW9leHBhbmRlci5oPgogI2luY2x1ZGUgPGFzbS9hcmNoL2lycXMu
aD4KQEAgLTUwLDYgKzUzLDggQEAKICNpbmNsdWRlIDxhc20vYXJjaC9tY2JzcC5oPgogI2luY2x1
ZGUgPGFzbS9hcmNoL29tYXAtYWxzYS5oPgogCisjaW5jbHVkZSA8Li4vZHJpdmVycy9tZWRpYS92
aWRlby9vdjk2NDAuaD4KKwogZXh0ZXJuIGludCBvbWFwX2dwaW9faW5pdCh2b2lkKTsKIAogc3Rh
dGljIGludCBoM19rZXltYXBbXSA9IHsKQEAgLTU0Nyw2ICs1NTIsMTEwIEBAIHN0YXRpYyBpbnQg
bmFuZF9kZXZfcmVhZHkoc3RydWN0IG5hbmRfcGxhdGZvcm1fZGF0YSAqZGF0YSkKIAlyZXR1cm4g
b21hcF9nZXRfZ3Bpb19kYXRhaW4oSDNfTkFORF9SQl9HUElPX1BJTik7CiB9CiAKKyNpZiBkZWZp
bmVkKENPTkZJR19WSURFT19PVjk2NDApIHx8IGRlZmluZWQoQ09ORklHX1ZJREVPX09WOTY0MF9N
T0RVTEUpCisvKgorICogQ29tbW9uIE9WOTY0MCByZWdpc3RlciBpbml0aWFsaXphdGlvbiBmb3Ig
YWxsIGltYWdlIHNpemVzLCBwaXhlbCBmb3JtYXRzLAorICogYW5kIGZyYW1lIHJhdGVzCisgKi8K
K2NvbnN0IHN0YXRpYyBzdHJ1Y3Qgb3Y5NjQwX3JlZyBvdjk2NDBfY29tbW9uW10gPSB7CisKKwl7
IDB4MTIsIDB4ODAgfSwgeyAweDExLCAweDgwIH0sIHsgMHgxMywgMHg4OCB9LAkvKiBDT003LCBD
TEtSQywgQ09NOCAqLworCXsgMHgwMSwgMHg1OCB9LCB7IDB4MDIsIDB4MjQgfSwgeyAweDA0LCAw
eDAwIH0sCS8qIEJMVUUsIFJFRCwgQ09NMSAqLworCXsgMHgwRSwgMHg4MSB9LCB7IDB4MEYsIDB4
NEYgfSwgeyAweDE0LCAweGNBIH0sCS8qIENPTTUsIENPTTYsIENPTTkgKi8KKwl7IDB4MTYsIDB4
MDIgfSwgeyAweDFCLCAweDAxIH0sIHsgMHgyNCwgMHg3MCB9LAkvKiA/LCBQU0hGVCwgQUVXICov
CisJeyAweDI1LCAweDY4IH0sIHsgMHgyNiwgMHhEMyB9LCB7IDB4MjcsIDB4OTAgfSwJLyogQUVC
LCBWUFQsIEJCSUFTICovCisJeyAweDJBLCAweDAwIH0sIHsgMHgyQiwgMHgwMCB9LCB7IDB4MzIs
IDB4MjQgfSwJLyogRVhIQ0gsIEVYSENMLCBIUkVGICovCisJeyAweDMzLCAweDAyIH0sIHsgMHgz
NywgMHgwMiB9LCB7IDB4MzgsIDB4MTMgfSwJLyogQ0hMRiwgQURDLCBBQ09NICovCisJeyAweDM5
LCAweEYwIH0sIHsgMHgzQSwgMHgwMCB9LCB7IDB4M0IsIDB4MDEgfSwJLyogT0ZPTiwgVFNMQiwg
Q09NMTEgKi8KKwl7IDB4M0QsIDB4OTAgfSwgeyAweDNFLCAweDAyIH0sIHsgMHgzRiwgMHhGMiB9
LAkvKiBDT00xMywgQ09NMTQsIEVER0UgKi8KKwl7IDB4NDEsIDB4MDIgfSwgeyAweDQyLCAweEM4
IH0sCQkvKiBDT00xNiwgQ09NMTcgKi8KKwl7IDB4NDMsIDB4RjAgfSwgeyAweDQ0LCAweDEwIH0s
IHsgMHg0NSwgMHg2QyB9LAkvKiA/LCA/LCA/ICovCisJeyAweDQ2LCAweDZDIH0sIHsgMHg0Nywg
MHg0NCB9LCB7IDB4NDgsIDB4NDQgfSwJLyogPywgPywgPyAqLworCXsgMHg0OSwgMHgwMyB9LCB7
IDB4NTksIDB4NDkgfSwgeyAweDVBLCAweDk0IH0sCS8qID8sID8sID8gKi8KKwl7IDB4NUIsIDB4
NDYgfSwgeyAweDVDLCAweDg0IH0sIHsgMHg1RCwgMHg1QyB9LAkvKiA/LCA/LCA/ICovCisJeyAw
eDVFLCAweDA4IH0sIHsgMHg1RiwgMHgwMCB9LCB7IDB4NjAsIDB4MTQgfSwJLyogPywgPywgPyAq
LworCXsgMHg2MSwgMHhDRSB9LAkJCQkJLyogPyAqLworCXsgMHg2MiwgMHg3MCB9LCB7IDB4NjMs
IDB4MDAgfSwgeyAweDY0LCAweDA0IH0sCS8qIExDQzEsIExDQzIsIExDQzMgKi8KKwl7IDB4NjUs
IDB4MDAgfSwgeyAweDY2LCAweDAwIH0sCQkJLyogTENDNCwgTENDNSAqLworCXsgMHg2OSwgMHgw
MCB9LCB7IDB4NkEsIDB4M0UgfSwgeyAweDZCLCAweDNGIH0sCS8qIEhWLCBNQkQsIERCTFYgKi8K
Kwl7IDB4NkMsIDB4NDAgfSwgeyAweDZELCAweDMwIH0sIHsgMHg2RSwgMHg0QiB9LAkvKiBHU1Ax
LCBHU1AyLCBHU1AzICovCisJeyAweDZGLCAweDYwIH0sIHsgMHg3MCwgMHg3MCB9LCB7IDB4NzEs
IDB4NzAgfSwJLyogR1NQNCwgR1NQNSwgR1NQNiAqLworCXsgMHg3MiwgMHg3MCB9LCB7IDB4NzMs
IDB4NzAgfSwgeyAweDc0LCAweDYwIH0sCS8qIEdTUDcsIEdTUDgsIEdTUDkgKi8KKwl7IDB4NzUs
IDB4NjAgfSwgeyAweDc2LCAweDUwIH0sIHsgMHg3NywgMHg0OCB9LAkvKiBHU1AxMCxHU1AxMSxH
U1AxMiAqLworCXsgMHg3OCwgMHgzQSB9LCB7IDB4NzksIDB4MkUgfSwgeyAweDdBLCAweDI4IH0s
CS8qIEdTUDEzLEdTUDE0LEdTUDE1ICovCisJeyAweDdCLCAweDIyIH0sIHsgMHg3QywgMHgwNCB9
LCB7IDB4N0QsIDB4MDcgfSwJLyogR1NQMTYsR1NUMSwgR1NUMiAqLworCXsgMHg3RSwgMHgxMCB9
LCB7IDB4N0YsIDB4MjggfSwgeyAweDgwLCAweDM2IH0sCS8qIEdTVDMsIEdTVDQsIEdTVDUgKi8K
Kwl7IDB4ODEsIDB4NDQgfSwgeyAweDgyLCAweDUyIH0sIHsgMHg4MywgMHg2MCB9LAkvKiBHU1Q2
LCBHU1Q3LCBHU1Q4ICovCisJeyAweDg0LCAweDZDIH0sIHsgMHg4NSwgMHg3OCB9LCB7IDB4ODYs
IDB4OEMgfSwJLyogR1NUOSwgR1NUMTAsR1NUMTEgKi8KKwl7IDB4ODcsIDB4OUUgfSwgeyAweDg4
LCAweEJCIH0sIHsgMHg4OSwgMHhEMiB9LAkvKiBHU1QxMixHU1QxMyxHU1QxNCAqLworCXsgMHg4
QSwgMHhFNiB9LCB7IDB4MTMsIDB4YUYgfSwgeyAweDE1LCAweDAyIH0sCS8qIEdTVDE1LCBDT004
ICovCisJeyAweDIyLCAweDhhIH0sIC8qIEdST1MgKi8KKwl7IE9WOTY0MF9SRUdfVEVSTSwgT1Y5
NjQwX1ZBTF9URVJNIH0KK307CisKK3N0YXRpYyBpbnQgb3Y5NjQwX3NlbnNvcl9wb3dlcl9zZXQo
aW50IHBvd2VyKQoreworCXVuc2lnbmVkIGNoYXIgZXhwYTsKKwlpbnQgZXJyOworCisJLyogcmVh
ZCBjdXJyZW50IHN0YXRlIG9mIEdQSU8gRVhQQSBvdXRwdXRzICovCisJZXJyID0gcmVhZF9ncGlv
X2V4cGEoJmV4cGEsIDB4MjcpOworCWlmIChlcnIpIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJFcnJv
ciByZWFkaW5nIEdQSU8gRVhQQVxuIik7CisJCXJldHVybiBlcnI7CisJfQorCS8qIENsZWFyIEdQ
SU8gRVhQQSBQMyAoQ0FNRVJBX01PRFVMRV9FTikgdG8gcG93ZXItdXAvZG93biBzZW5zb3IgKi8K
KwlpZiAocG93ZXIpCisJCWV4cGEgfD0gMHgwODsKKwllbHNlCisJCWV4cGEgJj0gfjB4MDg7CisK
KwllcnIgPSB3cml0ZV9ncGlvX2V4cGEoZXhwYSwgMHgyNyk7CisJaWYgKGVycikgeworCQlwcmlu
dGsoS0VSTl9FUlIgIkVycm9yIHdyaXRpbmcgdG8gR1BJTyBFWFBBXG4iKTsKKwkJcmV0dXJuIGVy
cjsKKwl9CisKKwlyZXR1cm4gZXJyOworfQorCitzdGF0aWMgc3RydWN0IHY0bDJfaWZwYXJtIGlm
cGFybSA9IHsKKwkuaWZfdHlwZSA9IFY0TDJfSUZfVFlQRV9CVDY1NiwKKwkudSA9IHsKKwkJLmJ0
NjU2ID0geworCQkJIC5mcmFtZV9zdGFydF9vbl9yaXNpbmdfdnMgPSAxLAorCQkJIC5ub2J0X3Zz
X2ludiA9IDEsCisJCQkgLm1vZGUgPSBWNEwyX0lGX1RZUEVfQlQ2NTZfTU9ERV9OT0JUXzhCSVQs
CisJCQkgLmNsb2NrX21pbiA9IE9WOTY0MF9YQ0xLX01JTiwKKwkJCSAuY2xvY2tfbWF4ID0gT1Y5
NjQwX1hDTEtfTUFYLAorCQkgfSwKKwl9LAorfTsKKworc3RhdGljIGludCBvdjk2NDBfaWZwYXJt
KHN0cnVjdCB2NGwyX2lmcGFybSAqcCkKK3sKKwkqcCA9IGlmcGFybTsKKworCXJldHVybiAwOwor
fQorCitzdGF0aWMgc3RydWN0IG92OTY0MF9wbGF0Zm9ybV9kYXRhIGgzX292OTY0MF9wbGF0Zm9y
bV9kYXRhID0geworCS5wb3dlcl9zZXQJPSBvdjk2NDBfc2Vuc29yX3Bvd2VyX3NldCwKKwkuZGVm
YXVsdF9yZWdzCT0gb3Y5NjQwX2NvbW1vbiwKKwkuaWZwYXJtCQk9IG92OTY0MF9pZnBhcm0sCit9
OworI2VuZGlmCisKK3N0YXRpYyBzdHJ1Y3QgaTJjX2JvYXJkX2luZm8gX19pbml0ZGF0YSBoM19p
MmNfYm9hcmRfaW5mb1tdID0geworI2lmIGRlZmluZWQoQ09ORklHX1ZJREVPX09WOTY0MCkgfHwg
ZGVmaW5lZChDT05GSUdfVklERU9fT1Y5NjQwX01PRFVMRSkKKwl7CisJCUkyQ19CT0FSRF9JTkZP
KCJvdjk2NDAiLCAweDMwKSwKKwkJLnBsYXRmb3JtX2RhdGEgPSAmaDNfb3Y5NjQwX3BsYXRmb3Jt
X2RhdGEsCisJfSwKKyNlbmRpZgorfTsKKworCiBzdGF0aWMgdm9pZCBfX2luaXQgaDNfaW5pdCh2
b2lkKQogewogCS8qIEhlcmUgd2UgYXNzdW1lIHRoZSBOT1IgYm9vdCBjb25maWc6ICBOT1Igb24g
Q1MzIChwb3NzaWJseSBzd2FwcGVkCkBAIC01NjksNiArNjc4LDkgQEAgc3RhdGljIHZvaWQgX19p
bml0IGgzX2luaXQodm9pZCkKIAkvKiBHUElPMTAgcHVsbHVwL2Rvd24gcmVnaXN0ZXIsIEVuYWJs
ZSBwdWxsdXAgb24gR1BJTzEwICovCiAJb21hcF9jZmdfcmVnKFYyXzE3MTBfR1BJTzEwKTsKIAor
CWkyY19yZWdpc3Rlcl9ib2FyZF9pbmZvKDEsIGgzX2kyY19ib2FyZF9pbmZvLAorCQkJCUFSUkFZ
X1NJWkUoaDNfaTJjX2JvYXJkX2luZm8pKTsKKwogCXBsYXRmb3JtX2FkZF9kZXZpY2VzKGRldmlj
ZXMsIEFSUkFZX1NJWkUoZGV2aWNlcykpOwogCXNwaV9yZWdpc3Rlcl9ib2FyZF9pbmZvKGgzX3Nw
aV9ib2FyZF9pbmZvLAogCQkJCUFSUkFZX1NJWkUoaDNfc3BpX2JvYXJkX2luZm8pKTsKLS0gCjEu
NS4zLjQuMjA2Lmc1OGJhNAoK
------=_Part_12229_7486950.1193931161759
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_12229_7486950.1193931161759--
