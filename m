From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: [PATCH] arch/arm/plat-omap/mcbsp.c
Date: Wed, 10 Oct 2007 03:06:00 -0300
Message-ID: <ae36f8040710092306m948cffs46581f7530e3a363@mail.gmail.com>
References: <ae36f8040710092043w58ee96e1q9b81aff60450fae7@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5107_7058649.1191996360647"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040710092043w58ee96e1q9b81aff60450fae7@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

------=_Part_5107_7058649.1191996360647
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

according to David Brownell, the patch have wraped-lines so I'm submitting
the patch in file ascii to avoid any problem with cut/paste

On 10/10/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
>
> Signed-off-by: Lu=EDs Vit=F3rio Cargnini <lvcargnini@gmail.com>
>
> --- /home/lvcargnini/puc/instramed/linux-omap-2.6/arch/arm/plat-omap/mcbs=
p.c
> 2007-03-12 16:44:03.501890844 -0300
> +++ /home/lvcargnini/puc/instramed/linux-omap-2.6.23/arch/arm/plat-omap/m=
cbsp.c
> 2007-10-02 03:31:12.399296934 -0300
> @@ -304,7 +304,7 @@ int omap_mcbsp_request(unsigned int id)
>
>         if (mcbsp[id].io_type =3D=3D OMAP_MCBSP_IRQ_IO) {
>                 /* We need to get IRQs here */
> -               err =3D request_irq(mcbsp[id].tx_irq,
> omap_mcbsp_tx_irq_handler, 0,
> +               err =3D request_irq(mcbsp[id].tx_irq,
> omap_mcbsp_tx_irq_handler, IRQF_SHARED,
>                                   "McBSP",
>                                   (void *) (&mcbsp[id]));
>                 if (err !=3D 0) {
> @@ -316,7 +316,7 @@ int omap_mcbsp_request(unsigned int id)
>                 init_completion(&(mcbsp[id].tx_irq_completion));
>
>
> -               err =3D request_irq(mcbsp[id].rx_irq,
> omap_mcbsp_rx_irq_handler, 0,
> +               err =3D request_irq(mcbsp[id].rx_irq,
> omap_mcbsp_rx_irq_handler, IRQF_SHARED,
>                                   "McBSP",
>                                   (void *) (&mcbsp[id]));
>                 if (err !=3D 0) {
>
>
> --
> -------------------------------------------------------------------------=
-----
>
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Electrical Engineer Faculty @ PUCRS
> Ipiranga Avenue, 6681 =96 Building 30
> P.O. Box: 90619-900 =96 Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
> -------------------------------------------------------------------------=
--------
>




--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------

------=_Part_5107_7058649.1191996360647
Content-Type: application/octet-stream; name="mcbsp.c.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mcbsp.c.patch"
X-Attachment-Id: f_f7lfu50d

LS0tIC9ob21lL2x2Y2FyZ25pbmkvcHVjL2luc3RyYW1lZC9saW51eC1vbWFwLTIuNi9hcmNoL2Fy
bS9wbGF0LW9tYXAvbWNic3AuYwkyMDA3LTAzLTEyIDE2OjQ0OjAzLjUwMTg5MDg0NCAtMDMwMAor
KysgL2hvbWUvbHZjYXJnbmluaS9wdWMvaW5zdHJhbWVkL2xpbnV4LW9tYXAtMi42LjIzL2FyY2gv
YXJtL3BsYXQtb21hcC9tY2JzcC5jCTIwMDctMTAtMDIgMDM6MzE6MTIuMzk5Mjk2OTM0IC0wMzAw
CkBAIC0zMDQsNyArMzA0LDcgQEAgaW50IG9tYXBfbWNic3BfcmVxdWVzdCh1bnNpZ25lZCBpbnQg
aWQpCiAKIAlpZiAobWNic3BbaWRdLmlvX3R5cGUgPT0gT01BUF9NQ0JTUF9JUlFfSU8pIHsKIAkJ
LyogV2UgbmVlZCB0byBnZXQgSVJRcyBoZXJlICovCi0JCWVyciA9IHJlcXVlc3RfaXJxKG1jYnNw
W2lkXS50eF9pcnEsIG9tYXBfbWNic3BfdHhfaXJxX2hhbmRsZXIsIDAsCisJCWVyciA9IHJlcXVl
c3RfaXJxKG1jYnNwW2lkXS50eF9pcnEsIG9tYXBfbWNic3BfdHhfaXJxX2hhbmRsZXIsIElSUUZf
U0hBUkVELAogCQkJCSAgIk1jQlNQIiwKIAkJCQkgICh2b2lkICopICgmbWNic3BbaWRdKSk7CiAJ
CWlmIChlcnIgIT0gMCkgewpAQCAtMzE2LDcgKzMxNiw3IEBAIGludCBvbWFwX21jYnNwX3JlcXVl
c3QodW5zaWduZWQgaW50IGlkKQogCQlpbml0X2NvbXBsZXRpb24oJihtY2JzcFtpZF0udHhfaXJx
X2NvbXBsZXRpb24pKTsKIAogCi0JCWVyciA9IHJlcXVlc3RfaXJxKG1jYnNwW2lkXS5yeF9pcnEs
IG9tYXBfbWNic3BfcnhfaXJxX2hhbmRsZXIsIDAsCisJCWVyciA9IHJlcXVlc3RfaXJxKG1jYnNw
W2lkXS5yeF9pcnEsIG9tYXBfbWNic3BfcnhfaXJxX2hhbmRsZXIsIElSUUZfU0hBUkVELAogCQkJ
CSAgIk1jQlNQIiwKIAkJCQkgICh2b2lkICopICgmbWNic3BbaWRdKSk7CiAJCWlmIChlcnIgIT0g
MCkgewo=
------=_Part_5107_7058649.1191996360647
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_Part_5107_7058649.1191996360647--
