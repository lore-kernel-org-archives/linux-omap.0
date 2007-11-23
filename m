From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] ARM: OMAP: USB: Define OMAP34XX_HSUSB_OTG_BASE
Date: Fri, 23 Nov 2007 18:15:21 +0530
Message-ID: <5DF83221BE20114E9C331F665ACBC08003ED7054@dbde01.ent.ti.com>
References: <31e679430711191127q158bd600q3e399617b343eec0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <31e679430711191127q158bd600q3e399617b343eec0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>, Paul Walmsley <paul@booyaka.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony=20
 This patch:=20
 1) Correctly defines the base address for HSUSB_OTG block (MUSB)
    Patch by Filipe had incorrect base address for 34xx

 2) Includes the base addresses of: USBTLL and USBHOST present in =
3430ES2.0

Felipe
 I see that for 34XX the base address for HSUSB_OTG is not correctly =
defined
 by your patch so resending with modifications


Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Index: linux-omap/include/asm-arm/arch-omap/omap34xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/include/asm-arm/arch-omap/omap34xx.h	2007-11-19 =
09:55:59.000000000 +0530
+++ linux-omap/include/asm-arm/arch-omap/omap34xx.h	2007-11-23 =
17:51:08.000000000 +0530
@@ -50,6 +50,9 @@
=20
 #define OMAP34XX_IC_BASE	0x48200000
 #define OMAP34XX_IVA_INTC_BASE	0x40000000
+#define OMAP34XX_HSUSB_OTG_BASE	(L4_34XX_BASE + 0xAB000)
+#define OMAP34XX_HSUSB_HOST_BASE	(L4_34XX_BASE + 0x64000)
+#define OMAP34XX_USBTLL_BASE	(L4_34XX_BASE + 0x62000)
 #define IRQ_SIR_IRQ		0x0040



>-----Original Message-----
>From: =
linux-omap-open-source-bounces+vikram.pandita=3Dti.com@linux.omap.com =
[mailto:linux-omap-open-
>source-bounces+vikram.pandita=3Dti.com@linux.omap.com] On Behalf Of =
Felipe Balbi
>Sent: Tuesday, November 20, 2007 12:58 AM
>To: Paul Walmsley
>Cc: linux-omap@vger.kernel.org; linux-omap-open-source@linux.omap.com
>Subject: Re: [RFC patch] ARM: OMAP: Define OMAP34XX_HS_BASE
>
>Hi,
>
>On 11/19/07, Paul Walmsley <paul@booyaka.com> wrote:
>> Hi Felipe,
>>
>> On Mon, 19 Nov 2007, Felipe Balbi wrote:
>>
>> > Following other omap archs, define OMAP34XX_HS_BASE macro
>> > to be used later, for example in musb driver.
>>
>> This #define should go up higher in the omap34xx.h file, so it isn't
>> enclosed by CONFIG_ARCH_OMAP34XX.  See for example =
OMAP3430_CTRL_BASE.
>> Trying to get rid of those defines in that conditional block :-)
>
>Thanks for noticing that.
>updated patch attached.
>
>>
>> - Paul
>>
>> > diff --git a/include/asm-arm/arch-omap/omap34xx.h =
b/include/asm-arm/arch-omap/omap34xx.h
>> > index 0265e3b..1650937 100644
>> > --- a/include/asm-arm/arch-omap/omap34xx.h
>> > +++ b/include/asm-arm/arch-omap/omap34xx.h
>> > @@ -71,6 +71,7 @@
>> >  #define OMAP2_CTRL_BASE                      OMAP3430_CTRL_BASE
>> >  #define OMAP34XX_CONTROL_DEVCONF0    (L4_34XX_BASE + 0x2274)
>> >  #define OMAP34XX_CONTROL_DEVCONF1    (L4_34XX_BASE + 0x22D8)
>> > +#define OMAP34XX_HS_BASE             (L4_34XX_BASE + 0x65000)
>> >  #define OMAP2_CONTROL_STATUS         (OMAP2_CTRL_BASE + 0x2f0)
>> >
>> >  #endif
>> > --
>> > 1.5.3.5.666.gfb5f
>>
>> - Paul
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>
>
>
>--
>Best Regards,
>
>Felipe Balbi
>felipebalbi@users.sourceforge.net
