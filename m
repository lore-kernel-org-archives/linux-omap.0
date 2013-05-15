From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: select SCU
Date: Wed, 15 May 2013 18:06:57 +0530
Message-ID: <51938169.4060109@ti.com>
References: <1368550638-2046-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368550638-2046-1-git-send-email-vincent.stehle@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@laposte.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?VmluY2VudCBTdGVobMOp?= <v-stehle@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 14 May 2013 10:27 PM, Vincent Stehl=C3=A9 wrote:
> From: Vincent Stehl=C3=A9 <v-stehle@ti.com>
>=20
> OMAP5 needs SCU in SMP.
>=20
> This fixes the following link errors:
>=20
>   arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
>   arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_po=
wer_mode'
>   arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
>   arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_po=
wer_mode'
>   arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus=
':
>   arch/arm/mach-omap2/omap-smp.c:211: undefined reference to `scu_ena=
ble'
>   arch/arm/mach-omap2/built-in.o: In function `omap4_smp_init_cpus':
>   arch/arm/mach-omap2/omap-smp.c:185: undefined reference to `scu_get=
_core_count'
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <v-stehle@ti.com>
> ---
OMAP5 doesn't need the SCU. So Nak for the patch. I haven't noticed
this earlier. Do you know which commit broke this ?

Regards,
Santosh
