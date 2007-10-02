From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: problems with backlight
Date: Tue, 2 Oct 2007 14:08:12 -0400
Message-ID: <31e679430710021108n1428d7c4gfb799d7aa18f7449@mail.gmail.com>
References: <ae36f8040710021045n4a966f26laec721e2b9d1cf1f@mail.gmail.com>
	<31e679430710021103r6737b937l30afeed8788aad43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_19195_30108572.1191348492741"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430710021103r6737b937l30afeed8788aad43@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@gmail.com
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_19195_30108572.1191348492741
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry,

forgot to change to correct function...

try this one





On 10/2/07, Felipe Balbi <felipebalbi@users.sourceforge.net> wrote:
> Hi Luis,
>
> On 10/2/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
> > Dear fellows,
> > I had the following problems compiling for omap with omap backlight ena=
bled,
> > the following error:
> > make
> >   CHK     include/linux/version.h
> > make[1]: `include/asm-arm/mach-types.h' is up to date.
> >   CHK     include/linux/utsrelease.h
> >   CALL    scripts/checksyscalls.sh
> > <stdin>:1097:2: warning: #warning syscall fadvise64 not implemented
> > <stdin>:1265:2: warning: #warning syscall migrate_pages not implemented
> > <stdin>:1321:2: warning: #warning syscall pselect6 not implemented
> > <stdin>:1325:2: warning: #warning syscall ppoll not implemented
> > <stdin>:1365:2: warning: #warning syscall epoll_pwait not implemented
> > <stdin>:1385:2: warning: #warning syscall fallocate not implemented
> >   CHK     include/linux/compile.h
> >   CC [M]  drivers/video/backlight/omap_bl.o
> > drivers/video/backlight/omap_bl.c: In function 'omapbl_suspend':
> > drivers/video/backlight/omap_bl.c:79: error: 'struct backlight_device' =
has
> > no member named 'class_dev'
> > drivers/video/backlight/omap_bl.c: In function 'omapbl_resume':
> > drivers/video/backlight/omap_bl.c:88: error: 'struct backlight_device' =
has
> > no member named 'class_dev'
> > drivers/video/backlight/omap_bl.c: In function 'omapbl_set_power':
> > drivers/video/backlight/omap_bl.c:100: error: 'struct backlight_device'=
 has
> > no member named 'class_dev'
> > drivers/video/backlight/omap_bl.c: In function 'omapbl_update_status':
> > drivers/video/backlight/omap_bl.c:110: error: 'struct backlight_device'=
 has
> > no member named 'class_dev'
> > drivers/video/backlight/omap_bl.c: In function 'omapbl_get_intensity':
> > drivers/video/backlight/omap_bl.c:130: error: 'struct backlight_device'=
 has
> > no member named 'class_dev'
> > drivers/video/backlight/omap_bl.c: In function 'omapbl_remove':
> > drivers/video/backlight/omap_bl.c:185: error: 'struct backlight_device'=
 has
> > no member named 'class_dev'
> > make[3]: *** [drivers/video/backlight/omap_bl.o] Error 1
> > make[2]: *** [drivers/video/backlight] Error 2
> > make[1]: *** [drivers/video] Error 2
> > make: *** [drivers] Error 2
> >
> > looking he source code:
> > struct omap_backlight {
> >     int powermode;
> >     int current_intensity;
> >
> >     struct device *dev;
> >     struct omap_backlight_config *pdata;
> > };
> >
> >
> > but :
> > #ifdef CONFIG_PM
> > static int omapbl_suspend(struct platform_device *pdev, pm_message_t st=
ate)
> > {
> >     struct backlight_device *dev =3D platform_get_drvdata(pdev);
> >     struct omap_backlight *bl =3D class_get_devdata(&dev->class_dev);
> >
> >     omapbl_blank(bl, FB_BLANK_POWERDOWN);
> >     return 0;
> > }
> >
> > someone have figured this problem before ?
> > can I make the fix ?
> > There is no fix, no problem I'm just creating one ?
>
> Check if the attached fixes the issue...
>
> If it works, I'll send a proper formated patch
>
> >
> > --
> > -----------------------------------------------------------------------=
-------
> > Thanks && Regards
> > Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> > IEEE Member
> > Electrical Engineer Faculty @ PUCRS
> > Ipiranga Avenue, 6681 =96 Building 30
> > P.O. Box: 90619-900 =96 Porto Alegre/RS
> > Phone: +55 51 3320 3500  extension: 7696
> > -----------------------------------------------------------------------=
----------
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
>
>
> --
> Best Regards,
>
> Felipe Balbi
> felipebalbi@users.sourceforge.net
>
>


--=20
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net

------=_Part_19195_30108572.1191348492741
Content-Type: text/x-patch; name="omap_backlight.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="omap_backlight.diff";
	filename="omap_backlight.diff"
X-Attachment-Id: f_f7aq3bq4

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L29tYXBfYmwuYyBiL2RyaXZlcnMv
dmlkZW8vYmFja2xpZ2h0L29tYXBfYmwuYwppbmRleCAzMjQ5YmY4Li4yMDcyZjI4IDEwMDY0NAot
LS0gYS9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9vbWFwX2JsLmMKKysrIGIvZHJpdmVycy92aWRl
by9iYWNrbGlnaHQvb21hcF9ibC5jCkBAIC03Niw3ICs3Niw3IEBAIHN0YXRpYyB2b2lkIG9tYXBi
bF9ibGFuayhzdHJ1Y3Qgb21hcF9iYWNrbGlnaHQgKmJsLCBpbnQgbW9kZSkKIHN0YXRpYyBpbnQg
b21hcGJsX3N1c3BlbmQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgcG1fbWVzc2FnZV90
IHN0YXRlKQogewogCXN0cnVjdCBiYWNrbGlnaHRfZGV2aWNlICpkZXYgPSBwbGF0Zm9ybV9nZXRf
ZHJ2ZGF0YShwZGV2KTsKLQlzdHJ1Y3Qgb21hcF9iYWNrbGlnaHQgKmJsID0gY2xhc3NfZ2V0X2Rl
dmRhdGEoJmRldi0+Y2xhc3NfZGV2KTsKKwlzdHJ1Y3Qgb21hcF9iYWNrbGlnaHQgKmJsID0gZGV2
X2dldF9kcnZkYXRhKCZkZXYtPmRldik7CiAKIAlvbWFwYmxfYmxhbmsoYmwsIEZCX0JMQU5LX1BP
V0VSRE9XTik7CiAJcmV0dXJuIDA7CkBAIC04NSw3ICs4NSw3IEBAIHN0YXRpYyBpbnQgb21hcGJs
X3N1c3BlbmQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgcG1fbWVzc2FnZV90IHN0YXRl
KQogc3RhdGljIGludCBvbWFwYmxfcmVzdW1lKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
CiB7CiAJc3RydWN0IGJhY2tsaWdodF9kZXZpY2UgKmRldiA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHBkZXYpOwotCXN0cnVjdCBvbWFwX2JhY2tsaWdodCAqYmwgPSBjbGFzc19nZXRfZGV2ZGF0YSgm
ZGV2LT5jbGFzc19kZXYpOworCXN0cnVjdCBvbWFwX2JhY2tsaWdodCAqYmwgPSBkZXZfZ2V0X2Ry
dmRhdGEoJmRldi0+ZGV2KTsKIAogCW9tYXBibF9ibGFuayhibCwgYmwtPnBvd2VybW9kZSk7CiAJ
cmV0dXJuIDA7CkBAIC05Nyw3ICs5Nyw3IEBAIHN0YXRpYyBpbnQgb21hcGJsX3Jlc3VtZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCiBzdGF0aWMgaW50IG9tYXBibF9zZXRfcG93ZXIo
c3RydWN0IGJhY2tsaWdodF9kZXZpY2UgKmRldiwgaW50IHN0YXRlKQogewotCXN0cnVjdCBvbWFw
X2JhY2tsaWdodCAqYmwgPSBjbGFzc19nZXRfZGV2ZGF0YSgmZGV2LT5jbGFzc19kZXYpOworCXN0
cnVjdCBvbWFwX2JhY2tsaWdodCAqYmwgPSBkZXZfZ2V0X2RydmRhdGEoJmRldi0+ZGV2KTsKIAog
CW9tYXBibF9ibGFuayhibCwgc3RhdGUpOwogCWJsLT5wb3dlcm1vZGUgPSBzdGF0ZTsKQEAgLTEw
Nyw3ICsxMDcsNyBAQCBzdGF0aWMgaW50IG9tYXBibF9zZXRfcG93ZXIoc3RydWN0IGJhY2tsaWdo
dF9kZXZpY2UgKmRldiwgaW50IHN0YXRlKQogCiBzdGF0aWMgaW50IG9tYXBibF91cGRhdGVfc3Rh
dHVzKHN0cnVjdCBiYWNrbGlnaHRfZGV2aWNlICpkZXYpCiB7Ci0Jc3RydWN0IG9tYXBfYmFja2xp
Z2h0ICpibCA9IGNsYXNzX2dldF9kZXZkYXRhKCZkZXYtPmNsYXNzX2Rldik7CisJc3RydWN0IG9t
YXBfYmFja2xpZ2h0ICpibCA9IGRldl9nZXRfZHJ2ZGF0YSgmZGV2LT5kZXYpOwogCiAJaWYgKGJs
LT5jdXJyZW50X2ludGVuc2l0eSAhPSBkZXYtPnByb3BzLmJyaWdodG5lc3MpIHsKIAkJaWYgKGRl
di0+cHJvcHMuYnJpZ2h0bmVzcyA8IDApCkBAIC0xMjcsNyArMTI3LDcgQEAgc3RhdGljIGludCBv
bWFwYmxfdXBkYXRlX3N0YXR1cyhzdHJ1Y3QgYmFja2xpZ2h0X2RldmljZSAqZGV2KQogCiBzdGF0
aWMgaW50IG9tYXBibF9nZXRfaW50ZW5zaXR5KHN0cnVjdCBiYWNrbGlnaHRfZGV2aWNlICpkZXYp
CiB7Ci0Jc3RydWN0IG9tYXBfYmFja2xpZ2h0ICpibCA9IGNsYXNzX2dldF9kZXZkYXRhKCZkZXYt
PmNsYXNzX2Rldik7CisJc3RydWN0IG9tYXBfYmFja2xpZ2h0ICpibCA9IGRldl9nZXRfZHJ2ZGF0
YSgmZGV2LT5kZXYpOwogCXJldHVybiBibC0+Y3VycmVudF9pbnRlbnNpdHk7CiB9CiAKQEAgLTE4
Miw3ICsxODIsNyBAQCBzdGF0aWMgaW50IG9tYXBibF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQogc3RhdGljIGludCBvbWFwYmxfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpCiB7CiAJc3RydWN0IGJhY2tsaWdodF9kZXZpY2UgKmRldiA9IHBsYXRmb3JtX2dl
dF9kcnZkYXRhKHBkZXYpOwotCXN0cnVjdCBvbWFwX2JhY2tsaWdodCAqYmwgPSBjbGFzc19nZXRf
ZGV2ZGF0YSgmZGV2LT5jbGFzc19kZXYpOworCXN0cnVjdCBvbWFwX2JhY2tsaWdodCAqYmwgPSBk
ZXZfZ2V0X2RydmRhdGEoJmRldi0+ZGV2KTsKIAogCWJhY2tsaWdodF9kZXZpY2VfdW5yZWdpc3Rl
cihkZXYpOwogCWtmcmVlKGJsKTsK
------=_Part_19195_30108572.1191348492741
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_19195_30108572.1191348492741--
