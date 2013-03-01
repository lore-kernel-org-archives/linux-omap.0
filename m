From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Fri, 1 Mar 2013 09:47:03 +0200 (EET)
Message-ID: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: pali.rohar@gmail.com, tony@atomide.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  =20
They look similar, but they are not equivalent :). The first major diff=
erence is here (code taken from omap-smc.S)

> ENTRY(omap_smc2)
>          stmfd   sp!, {r4-r12, lr}
>          mov     r3, r2
>          mov     r2, r1
>          mov     r1, #0x0        @ Process ID
>          mov     r6, #0xff
>          mov     r12, #0x00      @ Secure Service ID

Always zero, while RX51 PPA expects a real value. I wonder if it is a b=
ug, but anyway I don't see the id parameter (R0) used.

>          mov     r7, #0
>          mcr     p15, 0, r7, c7, c5, 6

According to ARM TRM, this is "Invalidate entire branch predictor array=
"(IIUC). NFC why it is needed here, but this will not work on RX-51 unt=
il IBE bit in ACR is set.=20

>          dsb
>          dmb
>          smc     #0

RX-51 needs smc #1 ;)

>          ldmfd   sp!, {r4-r12, pc}


The next major difference is that RX-51 expects parameter count passed =
in R3[0] to be the count of the remaining parameters +1, but omap_secur=
e_dispatcher (in omap-secure.c) is passing the exact count of the remai=
ning parameters.

I guess all of the above problems can be fixed/workarounded, but I wond=
er does it worth. Not to say that I don't have BB around to test if the=
 code still works if I make changes to omap2-secure.c/omap-smc.S :)


 >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Nishanth Menon=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH] arm: omap: RX=
-51: ARM errata 430973 workaround
 >=D0=94=D0=BE: Pali Roh=C3=A1r=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=A7=D0=B5=D1=82=D0=B2=D1=8A=D1=80=D1=82=D1=8A=D0=BA, 2013, =D0=A4=D0=
=B5=D0=B2=D1=80=D1=83=D0=B0=D1=80=D0=B8 28 16:40:05 EET
 >
 >
 >On 10:42-20130228, Pali Roh=C3=A1r wrote:
 >> Signed-off-by: Ivaylo Dimitrov=20
 >> Signed-off-by: Pali Roh=C3=A1r=20
 >> ---
 >>  arch/arm/mach-omap2/Makefile            |    1 +
 >>  arch/arm/mach-omap2/board-rx51-secure.c |   66 +++++++++++++++++++=
++++++++++++
 >>  arch/arm/mach-omap2/board-rx51-secure.h |   36 +++++++++++++++++
 >>  arch/arm/mach-omap2/board-rx51-smc.S    |   34 ++++++++++++++++
 >>  arch/arm/mach-omap2/board-rx51.c        |    7 ++++
 >
 >Wondering if we can integrate these into=20
 >arch/arm/mach-omap2/omap-smc.S
 >and
 >arch/arm/mach-omap2/omap-secure.c
 >on a quick look, it does seem there are commonalities.
 >
 >>  5 files changed, 144 insertions(+)
 >>  create mode 100644 arch/arm/mach-omap2/board-rx51-secure.c
 >>  create mode 100644 arch/arm/mach-omap2/board-rx51-secure.h
 >>  create mode 100644 arch/arm/mach-omap2/board-rx51-smc.S
 >>=20
 >> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Mak=
efile
 >> index 0ebbdd50..8eb4fb4 100644
 >> --- a/arch/arm/mach-omap2/Makefile
 >> +++ b/arch/arm/mach-omap2/Makefile
 >> @@ -241,6 +241,7 @@ obj-&#36;(CONFIG_MACH_NOKIA_RX51)		+=3D board-r=
x51.o sdram-nokia.o
 >>  obj-&#36;(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-peripherals.o
 >>  obj-&#36;(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-video.o
 >>  obj-&#36;(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-camera.o
 >> +obj-&#36;(CONFIG_MACH_NOKIA_RX51)		+=3D board-rx51-smc.o board-rx5=
1-secure.o
 >>  obj-&#36;(CONFIG_MACH_OMAP_ZOOM2)		+=3D board-zoom.o board-zoom-pe=
ripherals.o
 >>  obj-&#36;(CONFIG_MACH_OMAP_ZOOM2)		+=3D board-zoom-display.o
 >>  obj-&#36;(CONFIG_MACH_OMAP_ZOOM2)		+=3D board-zoom-debugboard.o
 >> diff --git a/arch/arm/mach-omap2/board-rx51-secure.c b/arch/arm/mac=
h-omap2/board-rx51-secure.c
 >> new file mode 100644
 >> index 0000000..361dc78
 >> --- /dev/null
 >> +++ b/arch/arm/mach-omap2/board-rx51-secure.c
 >> @@ -0,0 +1,66 @@
 >> +/*
 >> + * RX51 Secure PPA API.
 >> + *
 >> + * Copyright (C) 2012 Ivaylo Dimitrov=20
 >> + *
 >> + *
 >> + * This program is free software,you can redistribute it and/or mo=
dify
 >> + * it under the terms of the GNU General Public License version 2 =
as
 >> + * published by the Free Software Foundation.
 >> + */
 >> +#include=20
 >> +
 >> +#include &quot;board-rx51-secure.h&quot;
 >> +
 >> +/**
 >> + * rx51_secure_dispatcher: Routine to dispatch secure PPA API call=
s
 >> + * @idx: The PPA API index
 >> + * @flag: The flag indicating criticality of operation
 >> + * @nargs: Number of valid arguments out of four.
 >> + * @arg1, arg2, arg3 args4: Parameters passed to secure API
 >> + *
 >> + * Return the non-zero error value on failure.
 >> + */
 >> +u32 rx51_secure_dispatcher(u32 idx, u32 flag, u32 nargs, u32 arg1,=
 u32 arg2,
 >> +			   u32 arg3, u32 arg4)
 >> +{
 >> +	u32 ret;
 >> +	u32 param[5];
 >> +
 >> +	param[0] =3D nargs+1;
 >> +	param[1] =3D arg1;
 >> +	param[2] =3D arg2;
 >> +	param[3] =3D arg3;
 >> +	param[4] =3D arg4;
 >> +
 >> +	/*
 >> +	 * Secure API needs physical address
 >> +	 * pointer for the parameters
 >> +	 */
 >> +	flush_cache_all();
 >> +	outer_clean_range(__pa(param), __pa(param + 5));
 >> +	ret =3D rx51_ppa_smc(idx, flag, __pa(param));
 >> +
 >> +	return ret;
 >> +}
 >> +
 >> +/**
 >> + * rx51_secure_update_aux_cr: Routine to modify the contents of Au=
xiliary Control Register
 >> + *  @set_bits: bits to set in ACR
 >> + *  @clr_bits: bits to clear in ACR
 >> + *
 >> + * Return the non-zero error value on failure.
 >> +*/
 >> +u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits)
 >> +{
 >> +	u32 acr;
 >> +
 >> +	/* Read ACR */
 >> +	asm volatile (&quot;mrc p15, 0, %0, c1, c0, 1&quot; : &quot;=3Dr&=
quot; (acr));
 >> +	acr &amp;=3D ~clear_bits;
 >> +	acr |=3D set_bits;
 >> +
 >> +	return rx51_secure_dispatcher(RX51_PPA_WRITE_ACR,
 >> +			       FLAG_START_CRITICAL,
 >> +			       1,acr,0,0,0);
 >> +}
 >> diff --git a/arch/arm/mach-omap2/board-rx51-secure.h b/arch/arm/mac=
h-omap2/board-rx51-secure.h
 >> new file mode 100644
 >> index 0000000..61c760b
 >> --- /dev/null
 >> +++ b/arch/arm/mach-omap2/board-rx51-secure.h
 >> @@ -0,0 +1,36 @@
 >> +/*
 >> + * board-rx51-secure.h: OMAP Secure infrastructure header.
 >> + *
 >> + * Copyright (C) 2012 Ivaylo Dimitrov=20
 >> + *
 >> + * This program is free software; you can redistribute it and/or m=
odify
 >> + * it under the terms of the GNU General Public License version 2 =
as
 >> + * published by the Free Software Foundation.
 >> + */
 >> +#ifndef OMAP_RX51_SECURE_H
 >> +#define OMAP_RX51_SECURE_H
 >> +
 >> +/* HAL API error codes */
 >> +#define  API_HAL_RET_VALUE_OK           0x00
 >> +#define  API_HAL_RET_VALUE_FAIL         0x01
 >> +
 >> +/* Secure HAL API flags */
 >> +#define FLAG_START_CRITICAL             0x4
 >> +#define FLAG_IRQFIQ_MASK                0x3
 >> +#define FLAG_IRQ_ENABLE                 0x2
 >> +#define FLAG_FIQ_ENABLE                 0x1
 >> +#define NO_FLAG                         0x0
 >> +
 >> +/* Secure PPA(Primary Protected Application) APIs */
 >> +#define RX51_PPA_L2_INVAL               40
 >> +#define RX51_PPA_WRITE_ACR              42
 >> +
 >> +#ifndef __ASSEMBLER__
 >> +
 >> +extern u32 rx51_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
 >> +                                u32 arg1, u32 arg2, u32 arg3, u32 =
arg4);
 >> +extern u32 rx51_ppa_smc(u32 id, u32 flag, u32 pargs);
 >> +
 >> +extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits)=
;
 >> +#endif /* __ASSEMBLER__ */
 >> +#endif /* OMAP_RX51_SECURE_H */
 >> diff --git a/arch/arm/mach-omap2/board-rx51-smc.S b/arch/arm/mach-o=
map2/board-rx51-smc.S
 >> new file mode 100644
 >> index 0000000..70e2eb7
 >> --- /dev/null
 >> +++ b/arch/arm/mach-omap2/board-rx51-smc.S
 >> @@ -0,0 +1,34 @@
 >> +/*
 >> + * RX51 secure APIs file.
 >> + *
 >> + * Copyright (C) 2012 Ivaylo Dimitrov=20
 >> + *
 >> + *
 >> + * This program is free software,you can redistribute it and/or mo=
dify
 >> + * it under the terms of the GNU General Public License version 2 =
as
 >> + * published by the Free Software Foundation.
 >> + */
 >> +
 >> +#include=20
 >> +
 >> +/**
 >> + * u32 rx51_ppa_smc(u32 id, u32 flag, u32 pargs)
 >> + * Low level common routine for secure HAL and PPA APIs.
 >> + * @id: Secure Service ID
 >> + * @flag: Flag to indicate the criticality of operation
 >> + * @pargs: Physical address of parameter list starting
 >> + *          with number of parametrs
 >> + */
 >> +ENTRY(rx51_ppa_smc)
 >> +	.arch_extension sec
 >> +	stmfd	sp!, {r4-r12, lr}
 >> +	mov	r12, r0		@ Copy the secure service ID
 >> +	mov	r3, r2		@ Copy the pointer to va_list in R3
 >> +	mov	r2, r1		@ Copy the flags in R2
 >> +	mov	r1, #0x0	@ Process ID - 0
 >> +	mov	r6, #0xff	@ Indicate new Task call
 >> +	dsb
 >> +	dmb
 >> +	smc	#1		@ call PPA service
 >> +	ldmfd	sp!, {r4-r12, pc}
 >> +ENDPROC(rx51_ppa_smc)
 >> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2=
/board-rx51.c
 >> index 92117a13..fd85081 100644
 >> --- a/arch/arm/mach-omap2/board-rx51.c
 >> +++ b/arch/arm/mach-omap2/board-rx51.c
 >> @@ -31,6 +31,7 @@
 >>  #include &quot;gpmc.h&quot;
 >>  #include &quot;pm.h&quot;
 >>  #include &quot;sdram-nokia.h&quot;
 >> +#include &quot;board-rx51-secure.h&quot;
 >> =20
 >>  #define RX51_GPIO_SLEEP_IND 162
 >> =20
 >> @@ -103,6 +104,12 @@ static void __init rx51_init(void)
 >>  	rx51_peripherals_init();
 >>  	rx51_camera_init();
 >> =20
 >> +#ifdef CONFIG_ARM_ERRATA_430973
 >> +	printk(KERN_INFO &quot;Enabling ARM errata 430973 workaround.&#92=
;n&quot;);
 >> +	/* set IBE to 1 */
 >> +	rx51_secure_update_aux_cr(1 << 6, 0);
 >> +#endif
 >> +
 >>  	/* Ensure SDRC pins are mux'd for self-refresh */
 >>  	omap_mux_init_signal(&quot;sdrc_cke0&quot;, OMAP_PIN_OUTPUT);
 >>  	omap_mux_init_signal(&quot;sdrc_cke1&quot;, OMAP_PIN_OUTPUT);
 >> --=20
 >> 1.7.10.4
 >>=20
 >>=20
 >> _______________________________________________
 >> linux-arm-kernel mailing list
 >> linux-arm-kernel@lists.infradead.org
 >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
 >
 >--=20
 >Regards,
 >Nishanth Menon
 >
