From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet controller in board_init
Date: Mon, 24 Jan 2011 20:31:46 +0530
Message-ID: <AANLkTikcTqXS3vSSnmiS94SAHbAm-NPbT-_BTExDwvr-@mail.gmail.com>
References: <hvaibhav@ti.com> <1295880108-15584-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:53543 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751949Ab1AXPC1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 10:02:27 -0500
Received: by mail-gw0-f41.google.com with SMTP id 22so1445493gwj.14
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 07:02:26 -0800 (PST)
In-Reply-To: <1295880108-15584-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com

On Mon, Jan 24, 2011 at 20:11,  <hvaibhav@ti.com> wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>

Thanks for the patch.  I guess this problem was initially reported by K=
evin.
So you may consider adding his Reported-by.

> With addition of HWMOD support to GPIO, the Ethernet controller

%s/HWMOD/hwmod

> goes undetected for OMAP35xEVM. So explicitely assert the reset signa=
l to

%s/explicitely/explicitly

> Ethernet controller smsc911x -
>
> =A0 =A0 =A0 =A0- GPIO7 (>=3DRevG version of EVM's)
> =A0 =A0 =A0 =A0- GPIO64 (<=3DRevD version of EVM's)
>
> I have tested this patch on RevG version of EVM with ES3.1 Si.
> This patch is based on intial version from Charulatha V.

Please add the link for reference. Also please add my SOB if you find
it relevant.

>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> NOTE: I have not been able to test it on older version of EVM's.
>
> =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 27 ++++++++++++++++++++=
++++++-
> =A01 files changed, 26 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index 212d88c..336c012 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -124,10 +124,15 @@ static struct platform_device omap3evm_smsc911x=
_device =3D {
>
> =A0static inline void __init omap3evm_init_smsc911x(void)
> =A0{
> - =A0 =A0 =A0 int eth_cs;
> + =A0 =A0 =A0 int eth_cs, eth_rst;
> =A0 =A0 =A0 =A0struct clk *l3ck;
> =A0 =A0 =A0 =A0unsigned int rate;
>
> + =A0 =A0 =A0 if (get_omap3_evm_rev() =3D=3D OMAP3EVM_BOARD_GEN_1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eth_rst =3D 64;

Please define macros and use them.

> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eth_rst =3D 7;

Ditto

> +
> =A0 =A0 =A0 =A0eth_cs =3D OMAP3EVM_SMSC911X_CS;
>
> =A0 =A0 =A0 =A0l3ck =3D clk_get(NULL, "l3_ck");
> @@ -136,6 +141,22 @@ static inline void __init omap3evm_init_smsc911x=
(void)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rate =3D clk_get_rate(l3ck);
>
> + =A0 =A0 =A0 /* Configure ethernet controller reset gpio */
> + =A0 =A0 =A0 if (cpu_is_omap3430()) {

cpu_is_omap3430() is not required, as this board init would not be
called otherwise.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_request(eth_rst, "SMSC911x gpi=
o") < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(KERN_ERR "Failed=
 to request GPIO7 for smsc911x\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(eth_rst, 1);

Check for the return value

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* reset pulse to ethernet controller*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(150, 220);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(eth_rst, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(150, 220);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(eth_rst, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(1, 2);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (gpio_request(OMAP3EVM_ETHR_GPIO_IRQ, "SMSC911x irq=
") < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "Failed to request GPI=
O%d for smsc911x IRQ\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3EVM_ETHR_GPIO_IRQ=
);
> @@ -703,6 +724,10 @@ static struct omap_board_mux omap35x_board_mux[]=
 __initdata =3D {
> =A0 =A0 =A0 =A0OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_=
PULLUP |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_P=
IN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_P=
IN_OFF_WAKEUPENABLE),
> + =A0 =A0 =A0 OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PU=
LLUP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PI=
N_OFF_NONE),
> + =A0 =A0 =A0 OMAP3_MUX(GPMC_WAIT2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_P=
ULLUP |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_PI=
N_OFF_NONE),
> =A0 =A0 =A0 =A0{ .reg_offset =3D OMAP_MUX_TERMINATOR },
> =A0};
>
> --
> 1.6.2.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
