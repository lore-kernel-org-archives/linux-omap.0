From: Michael Welling <mwelling@ieee.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 15:28:35 -0500
Message-ID: <20150713202835.GA9468@deathray>
References: <201507111405.06048@pali>
 <20150713080920.GA25585@earth>
 <20150713170344.GA5825@deathray>
 <201507131909.06521@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507131909.06521@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 13, 2015 at 07:09:06PM +0200, Pali Roh=E1r wrote:
> Hello, here is my objdump of 4.2-rc2 version:
>=20
> 00000064 <omap2_mcspi_set_cs>:
>       64:       e3003182        movw    r3, #386        ; 0x182
>       68:       e19030b3        ldrh    r3, [r0, r3]
>       6c:       e3130004        tst     r3, #4
>       70:       0a000001        beq     7c <omap2_mcspi_set_cs+0x18>
>       74:       e2711001        rsbs    r1, r1, #1
>       78:       33a01000        movcc   r1, #0
>       7c:       e5902188        ldr     r2, [r0, #392]  ; 0x188
>       80:       e3520000        cmp     r2, #0
>       84:       012fff1e        bxeq    lr
>       88:       e5923018        ldr     r3, [r2, #24]
>       8c:       e3510000        cmp     r1, #0
>       90:       13c33601        bicne   r3, r3, #1048576        ; 0x1=
00000
>       94:       03833601        orreq   r3, r3, #1048576        ; 0x1=
00000
>       98:       e5823018        str     r3, [r2, #24]
>       9c:       e5902188        ldr     r2, [r0, #392]  ; 0x188
>       a0:       e5922000        ldr     r2, [r2]
>       a4:       e582302c        str     r3, [r2, #44]   ; 0x2c
>       a8:       e592302c        ldr     r3, [r2, #44]   ; 0x2c
>       ac:       e12fff1e        bx      lr

I have not been able to duplicate the failure on the hardware that I ha=
ve.
I dug out my old Beagleboard and added an SPI registration to the dts.
This was the closest hardware that I had to the N900's processor.

What is the version of the gcc compiler you are using and where did you
get it from?

=46or instance, I am using a 4.9.1 compiler that I built using Yocto.

Also are you using devicetree or the old board file board-rx51.c?
