From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/5] omap: Use inituart to configure the debug serial port
 based on machine ID
Date: Fri, 4 Feb 2011 14:04:57 +0200
Message-ID: <AANLkTik7ommf_4HuahAxhMdaY-h-1JGsFfDzt2826d95@mail.gmail.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
	<20110204012707.26410.28508.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50116 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab1BDME6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 07:04:58 -0500
Received: by pzk35 with SMTP id 35so393636pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 04:04:58 -0800 (PST)
In-Reply-To: <20110204012707.26410.28508.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Fri, Feb 4, 2011 at 3:27 AM, Tony Lindgren <tony@atomide.com> wrote:
> Set the debug serial port based on machine ID. Note that most
> of the patch is just trivial checking for the machine ID.
>
> Also note that this code won't work for debugging the uncompress code=
=2E
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

<snip>
> diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/ar=
m/mach-omap2/include/mach/debug-macro.S
> index 336a838..45c29e3 100644
> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
<snip>

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* omap3 based boards using uart3 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldr =A0 =A0 \v, =3DMACH_TYPE_CM_T35
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmp =A0 =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_CM_T3517
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_CRANEBOARD
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_DEVKIT8000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_IGEP0020
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_IGEP0030
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_NOKIA_RM680
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_NOKIA_RX51
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_OMAP3517EVM
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_OMAP3_BEAGLE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_OMAP3_PANDOR=
A
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_OMAP_LDP
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_OVERO
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldrne =A0 \v, =3DMACH_TYPE_TOUCHBOOK
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmpne =A0 \id, \v
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldreq =A0 \v, =3DOMAP3_UART3_BASE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 streq =A0 \v, [\a, #0] =A0 =A0 =A0 =A0 =
=A0 =A0@ save port phys addr
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ldreq =A0 \v, =3D(OMAP3_UART3_BASE + OM=
AP2_L4_IO_OFFSET)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 streq =A0 \v, [\a, #4] =A0 =A0 =A0 =A0 =
=A0 =A0@ save port virt addr
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beq =A0 =A0 999f

This looks a bit wasteful not only because of repeated CMPs, but also
LDRs are generating a large literal pool. Maybe something like that be
better:

    adr     r0, uart3_machines
0:
    ldrh    \v, [r0], #2
    tst     \v, \v
    beq     999f                    @ end of list
    cmp     \id, \v
    bne     0b
    ldr     \v, =3DOMAP3_UART3_BASE
    str     \v, [\a, #0]            @ save port phys addr
    ldr     \v, =3D(OMAP3_UART3_BASE + OMAP2_L4_IO_OFFSET)
    str     \v, [\a, #4]            @ save port virt addr
    b       999f

    uart3_machines:
    .short MACH_TYPE_CM_T35
    .short MACH_TYPE_CM_T3517
    ...
    .short 0

of course this needs an extra register..
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
