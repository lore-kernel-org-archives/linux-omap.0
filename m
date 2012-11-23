From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC
 timings and NAND
Date: Fri, 23 Nov 2012 10:43:55 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9EEA09@DBDE01.ent.ti.com>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com>
 <1351869956-2787-5-git-send-email-zonque@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DA81F@DBDE01.ent.ti.com>
 <5097B7EE.3000508@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DC1F1@DBDE01.ent.ti.com>
 <509A2E75.5060307@gmail.com>
 <518397C60809E147AF5323E0420B992E3E9DE420@DBDE01.ent.ti.com>
 <509EA360.2050504@gmail.com> <87mwycjmdn.fsf@dell.be.48ers.dk>
 <50ACA9BB.7090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50ACA9BB.7090106-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org" <ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 21, 2012 at 15:45:23, Daniel Mack wrote:
> On 20.11.2012 16:59, Peter Korsgaard wrote:
> >>>>>> "Daniel" == Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> > 
> > Hi,
> > 
> >  >>>> In omap2 driver NAND_ECC_HW ecc mode supports 3 ecc layout
> >  >>>> OMAP_ECC_HAMMING_CODE_HW_ROMCODE
> >  >>>> OMAP_ECC_BCH4_CODE_HW
> >  >>>> OMAP_ECC_BCH8_CODE_HW
> >  >>>> 
> >  >>>> So selection of ecc layout data should come from DT not ecc mode.
> >  >>> 
> >  >>> Ok, I see. I would still like to set them by string rather than magic
> >  >>> numbers that map to enum entries. Valid values would be "none", "hw",
> >  >>> "hw-romcode", "bch4" and "bch8". Are you ok with that?
> >  >> 
> >  >> Ok, that's nice. Better use ecc_opt instead of ecc_mode.
> > 
> >  Daniel> I did some more extensive tests that include reading the same
> >  Daniel> nand pages from both U-Boot and the kernel with BCH8 ECC, and
> >  Daniel> it turns out that -> is_elm_used needs to be set in the pdata
> >  Daniel> in order to make this work.
> > 
> > So what you're saying is that the choice of ELM or not is not just an
> > optimization, it really changes the ECC layout? Perhaps it should be
> > treated as a seperate layout (E.G. bch8-elm) then?

Peter,

In patch [1], mtd: nand: omap2: Support for hardware BCH

ecc_layout made compatible with Rom Boot Loader ECC layout for am335x.

This action is based on is_elm_used flag.

Requirement of this flag is to identify the whether the platform
ELM module & based on this configure ELM module if present.

But ideally BCH8 ecc lay out didn't have a dependency on ELM, it
can work with software BCH ecc. RBL compatibility is missing
in software BCH because of addition of constant polynomial to
ecc vector. If we remove the dependency on erased page handling
by ecc vector with constant polynomial, software BCH can do the
job of RBL compatibility.

Ivan,
Do you have any suggestions?
Discussion for RBL compatibility found at [2].

It is good that software BCH also support RBL compatibility by suppressing
constant polynomial modification. Then ecc layout can be selected from
DT entry and error correction can be chosen between software/hardware
depending on the availability of ELM hardware.
Currently RBL BCH8 compatibility depends on the availability of ELM
hardware. Later once software BCH start supporting RBL compatibility,
we can remove  the check.

> 
> That is what I experienced, yes. The kernel was unable to parse NAND
> pages that were written from U-Boot with bch8 hardware mode when the elm
> module was not active. Maybe someone from TI can explain that? Giving it
> a dedicated name would also solve the problem with the extra DT property.

Daniel,

Currently BCH8 is supported with software ecc error correction in mainline.
The layout for BCH8 ECC layout is
0-1 -> BAD block markers
2-11-> oob free area
12-63-> BCH8 ECC.

RBL ECC layout is
0-1 -> BAD block markers
2-57-> BCH8 ecc layout
58-63-> OOB free area

As u-boot also maintain RBL ecc layout, write from U-boot
and read from Linux requires compatibility with RBL ecc layout.
The same is achieved in the patch [1], with by setting is_elm_used
to true.

1. https://lkml.org/lkml/2012/10/31/87
2. https://lkml.org/lkml/2012/10/11/20

Thanks
Avinash
> 
> I'll wait until this is decided before I resend a new set that also
> fixes the issue with the errornousely forgotten Documentation file.
> 
> 
> Thanks,
> Daniel
> 
> 
