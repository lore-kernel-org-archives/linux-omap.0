From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v5 3/5] ARM: omap3: Remove hand-encoded SMC instructions
Date: Thu, 17 Feb 2011 18:11:18 +0100
Message-ID: <AANLkTi=izx5txQR1A-RUAESrUN0NLsXg9xK2L5ybqo+W@mail.gmail.com>
References: <1297946558-13436-1-git-send-email-dave.martin@linaro.org>
	<1297946558-13436-4-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1297946558-13436-4-git-send-email-dave.martin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Kevin Hilman <khilman@ti.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, patches@linaro.org, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 17, 2011 at 1:42 PM, Dave Martin <dave.martin@linaro.org> wrote:
> For various reasons, Linux now only officially supports being built
> with tools which are new enough to understand the SMC instruction.
>
> Replacing the hand-encoded instructions when the mnemonic also
> allows for correct assembly in Thumb-2 (otherwise, the result is
> random data in the middle of the code).
>
> The Makefile already ensures that this file is built with a high
> enough gcc -march=3D flag (armv7-a).
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reviewed OK
Reviewed-by: Jean Pihet <j-pihet@ti.com>

Tested OK on OMAP3 with and without CONFIG_THUMB2_KERNEL set. PM
RETention and OFF modes in cpuidle OK.
Tested-by: Jean Pihet <j-pihet@ti.com>

> ---
> =A0arch/arm/mach-omap2/sleep34xx.S | =A0 14 +++++++-------
> =A01 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep3=
4xx.S
> index 98d8232..a05c348 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -133,7 +133,7 @@ ENTRY(save_secure_ram_context)
> =A0 =A0 =A0 =A0mov =A0 =A0 r6, #0xff
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 4 =A0@ data write barrier
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 5 =A0@ data memory barrier
> - =A0 =A0 =A0 .word =A0 0xE1600071 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ call SMI =
monitor (smi #1)
> + =A0 =A0 =A0 smc =A0 =A0 #1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 call SMI monitor (smi #1)
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0nop
> @@ -408,7 +408,7 @@ skipl2dis:
> =A0 =A0 =A0 =A0adr =A0 =A0 r3, l2_inv_api_params =A0 @ r3 points to dummy=
 parameters
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 4 =A0@ data write barrier
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 5 =A0@ data memory barrier
> - =A0 =A0 =A0 .word =A0 0xE1600071 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ call SMI =
monitor (smi #1)
> + =A0 =A0 =A0 smc =A0 =A0 #1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 call SMI monitor (smi #1)
> =A0 =A0 =A0 =A0/* Write to Aux control register to set some bits */
> =A0 =A0 =A0 =A0mov =A0 =A0 r0, #42 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ set =
service ID for PPA
> =A0 =A0 =A0 =A0mov =A0 =A0 r12, r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ copy=
 secure Service ID in r12
> @@ -419,7 +419,7 @@ skipl2dis:
> =A0 =A0 =A0 =A0ldr =A0 =A0 r3, [r4, #0xBC] =A0 =A0 =A0 =A0 @ r3 points to=
 parameters
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 4 =A0@ data write barrier
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 5 =A0@ data memory barrier
> - =A0 =A0 =A0 .word =A0 0xE1600071 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ call SMI =
monitor (smi #1)
> + =A0 =A0 =A0 smc =A0 =A0 #1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 call SMI monitor (smi #1)
>
> =A0#ifdef CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE
> =A0 =A0 =A0 =A0/* Restore L2 aux control register */
> @@ -434,7 +434,7 @@ skipl2dis:
> =A0 =A0 =A0 =A0adds =A0 =A0r3, r3, #8 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ r3 poi=
nts to parameters
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 4 =A0@ data write barrier
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r0, c7, c10, 5 =A0@ data memory barrier
> - =A0 =A0 =A0 .word =A0 0xE1600071 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ call SMI =
monitor (smi #1)
> + =A0 =A0 =A0 smc =A0 =A0 #1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 call SMI monitor (smi #1)
> =A0#endif
> =A0 =A0 =A0 =A0b =A0 =A0 =A0 logic_l1_restore
>
> @@ -443,18 +443,18 @@ l2_inv_api_params:
> =A0l2_inv_gp:
> =A0 =A0 =A0 =A0/* Execute smi to invalidate L2 cache */
> =A0 =A0 =A0 =A0mov r12, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 @ set up=
 to invalidate L2
> - =A0 =A0 =A0 .word 0xE1600070 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Call SMI =
monitor (smieq)
> + =A0 =A0 =A0 smc =A0 =A0 #0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 Call SMI monitor (smieq)
> =A0 =A0 =A0 =A0/* Write to Aux control register to set some bits */
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, scratchpad_base
> =A0 =A0 =A0 =A0ldr =A0 =A0 r3, [r4,#0xBC]
> =A0 =A0 =A0 =A0ldr =A0 =A0 r0, [r3,#4]
> =A0 =A0 =A0 =A0mov =A0 =A0 r12, #0x3
> - =A0 =A0 =A0 .word =A0 0xE1600070 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Call SMI =
monitor (smieq)
> + =A0 =A0 =A0 smc =A0 =A0 #0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 Call SMI monitor (smieq)
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, scratchpad_base
> =A0 =A0 =A0 =A0ldr =A0 =A0 r3, [r4,#0xBC]
> =A0 =A0 =A0 =A0ldr =A0 =A0 r0, [r3,#12]
> =A0 =A0 =A0 =A0mov =A0 =A0 r12, #0x2
> - =A0 =A0 =A0 .word =A0 0xE1600070 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Call SMI =
monitor (smieq)
> + =A0 =A0 =A0 smc =A0 =A0 #0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@=
 Call SMI monitor (smieq)
> =A0logic_l1_restore:
> =A0 =A0 =A0 =A0ldr =A0 =A0 r1, l2dis_3630
> =A0 =A0 =A0 =A0cmp =A0 =A0 r1, #0x1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ Test=
 if L2 re-enable needed on 3630
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
