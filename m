From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [RFC patch] ARM: OMAP: Define OMAP34XX_HS_BASE
Date: Mon, 19 Nov 2007 15:27:57 -0400
Message-ID: <31e679430711191127q158bd600q3e399617b343eec0@mail.gmail.com>
References: <1195436730-10631-1-git-send-email-felipe.lima@indt.org.br>
	<1195436730-10631-2-git-send-email-felipe.lima@indt.org.br>
	<1195436730-10631-3-git-send-email-felipe.lima@indt.org.br>
	<1195436730-10631-4-git-send-email-felipe.lima@indt.org.br>
	<Pine.LNX.4.64.0711191213050.25712@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_22707_11086726.1195500477220"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <Pine.LNX.4.64.0711191213050.25712@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

------=_Part_22707_11086726.1195500477220
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On 11/19/07, Paul Walmsley <paul@booyaka.com> wrote:
> Hi Felipe,
>
> On Mon, 19 Nov 2007, Felipe Balbi wrote:
>
> > Following other omap archs, define OMAP34XX_HS_BASE macro
> > to be used later, for example in musb driver.
>
> This #define should go up higher in the omap34xx.h file, so it isn't
> enclosed by CONFIG_ARCH_OMAP34XX.  See for example OMAP3430_CTRL_BASE.
> Trying to get rid of those defines in that conditional block :-)

Thanks for noticing that.
updated patch attached.

>
> - Paul
>
> > diff --git a/include/asm-arm/arch-omap/omap34xx.h b/include/asm-arm/arch-omap/omap34xx.h
> > index 0265e3b..1650937 100644
> > --- a/include/asm-arm/arch-omap/omap34xx.h
> > +++ b/include/asm-arm/arch-omap/omap34xx.h
> > @@ -71,6 +71,7 @@
> >  #define OMAP2_CTRL_BASE                      OMAP3430_CTRL_BASE
> >  #define OMAP34XX_CONTROL_DEVCONF0    (L4_34XX_BASE + 0x2274)
> >  #define OMAP34XX_CONTROL_DEVCONF1    (L4_34XX_BASE + 0x22D8)
> > +#define OMAP34XX_HS_BASE             (L4_34XX_BASE + 0x65000)
> >  #define OMAP2_CONTROL_STATUS         (OMAP2_CTRL_BASE + 0x2f0)
> >
> >  #endif
> > --
> > 1.5.3.5.666.gfb5f
>
> - Paul
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net

------=_Part_22707_11086726.1195500477220
Content-Type: text/x-patch; name=0001-ARM-OMAP-Define-OMAP34XX_HS_BASE.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f97e3csa
Content-Disposition: attachment;
	filename=0001-ARM-OMAP-Define-OMAP34XX_HS_BASE.diff

RnJvbSBlNTg4MGUwNWU4MTAwY2Q3ZjIxYjExNjQyNWVjZmUzMTA0Y2NkNjg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQmFsYmkgPGZlbGlwZS5saW1hQGluZHQub3JnLmJy
PgpEYXRlOiBNb24sIDE5IE5vdiAyMDA3IDAzOjM1OjA1ICswMjAwClN1YmplY3Q6IFtQQVRDSF0g
QVJNOiBPTUFQOiBEZWZpbmUgT01BUDM0WFhfSFNfQkFTRQoKRm9sbG93aW5nIG90aGVyIG9tYXAg
YXJjaHMsIGRlZmluZSBPTUFQMzRYWF9IU19CQVNFIG1hY3JvCnRvIGJlIHVzZWQgbGF0ZXIsIGZv
ciBleGFtcGxlIGluIG11c2IgZHJpdmVyLgoKU2lnbmVkLW9mZi1ieTogRmVsaXBlIEJhbGJpIDxm
ZWxpcGUubGltYUBpbmR0Lm9yZy5icj4KLS0tCiBpbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL29t
YXAzNHh4LmggfCAgICAxICsKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvb21hcDM0
eHguaCBiL2luY2x1ZGUvYXNtLWFybS9hcmNoLW9tYXAvb21hcDM0eHguaAppbmRleCAwMjY1ZTNi
Li5mMTBjMzEwIDEwMDY0NAotLS0gYS9pbmNsdWRlL2FzbS1hcm0vYXJjaC1vbWFwL29tYXAzNHh4
LmgKKysrIGIvaW5jbHVkZS9hc20tYXJtL2FyY2gtb21hcC9vbWFwMzR4eC5oCkBAIC01MCw2ICs1
MCw3IEBACiAKICNkZWZpbmUgT01BUDM0WFhfSUNfQkFTRQkweDQ4MjAwMDAwCiAjZGVmaW5lIE9N
QVAzNFhYX0lWQV9JTlRDX0JBU0UJMHg0MDAwMDAwMAorI2RlZmluZSBPTUFQMzRYWF9IU19CQVNF
CShMNF8zNFhYX0JBU0UgKyAweDY1MDAwKQogI2RlZmluZSBJUlFfU0lSX0lSUQkJMHgwMDQwCiAK
IAotLSAKMS41LjMuNS42NjYuZ2ZiNWYKCg==
------=_Part_22707_11086726.1195500477220
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_22707_11086726.1195500477220--
