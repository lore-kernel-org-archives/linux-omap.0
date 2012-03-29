From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 1/4] ARM: OMAP1: boards: Fix OMAP_GPIO_IRQ usage with gpio_to_irq()
Date: Wed, 28 Mar 2012 21:58:07 -0700
Message-ID: <CAOesGMg0eZAGdnU4A6Ubbyrn-zZAK4xvBVqoPkhhVReoHTAfaQ@mail.gmail.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
	<1332158817-26311-2-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38638 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab2C2E6I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 00:58:08 -0400
Received: by gghe5 with SMTP id e5so1248755ggh.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 21:58:07 -0700 (PDT)
In-Reply-To: <1332158817-26311-2-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, b-cousson@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

Hi,

Sorry for the slow reply, I noticed this when dealing with merge
conflicts pulling in this patch and others from Tony.

On Mon, Mar 19, 2012 at 5:06 AM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> With dynamic allocation of IRQ the usage of OMAP_GPIO_IRQ
> is no longer valid. We should be using gpio_to_irq() instead.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
> =A0arch/arm/mach-omap1/board-h2.c =A0 =A0 =A0 =A0| =A0 =A08 ++++----
> =A0arch/arm/mach-omap1/board-h3.c =A0 =A0 =A0 =A0| =A0 =A09 ++++-----
> =A0arch/arm/mach-omap1/board-htcherald.c | =A0 =A06 +++---
> =A0arch/arm/mach-omap1/board-innovator.c | =A0 =A04 ++--
> =A0arch/arm/mach-omap1/board-nokia770.c =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap1/board-osk.c =A0 =A0 =A0 | =A0 12 ++++++------
> =A0arch/arm/mach-omap1/board-palmte.c =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap1/board-palmtt.c =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap1/board-palmz71.c =A0 | =A0 =A02 +-
> =A0arch/arm/mach-omap1/board-voiceblue.c | =A0 16 +++++++---------
> =A010 files changed, 30 insertions(+), 33 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/boa=
rd-h2.c
> index 00ad6b2..ad0eece 100644
> --- a/arch/arm/mach-omap1/board-h2.c
> +++ b/arch/arm/mach-omap1/board-h2.c
> @@ -244,8 +244,6 @@ static struct resource h2_smc91x_resources[] =3D =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_MEM,
> =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0[1] =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D OMAP_GPIO_IRQ(0),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D OMAP_GPIO_IRQ(0),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0=3D IORESOURCE_IRQ | IORESOU=
RCE_IRQ_LOWEDGE,
> =A0 =A0 =A0 =A0},
> =A0};
> @@ -364,11 +362,9 @@ static struct tps65010_board tps_board =3D {
> =A0static struct i2c_board_info __initdata h2_i2c_board_info[] =3D {
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I2C_BOARD_INFO("tps65010", 0x48),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP_GP=
IO_IRQ(58),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_data =A0=3D &tps_board,
> =A0 =A0 =A0 =A0}, {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I2C_BOARD_INFO("isp1301_omap", 0x2d),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP_GP=
IO_IRQ(2),
> =A0 =A0 =A0 =A0},
> =A0};
>
> @@ -437,10 +433,14 @@ static void __init h2_init(void)
> =A0 =A0 =A0 =A0omap_cfg_reg(E19_1610_KBR4);
> =A0 =A0 =A0 =A0omap_cfg_reg(N19_1610_KBR5);
>
> + =A0 =A0 =A0 h2_devices[2]->resource[1].start =3D gpio_to_irq(0);
> + =A0 =A0 =A0 h2_devices[2]->resource[1].end =3D gpio_to_irq(0);

Never, ever, ever do this. What happens here when someone else adds
another device to the h2_devices array before the smc91x one?  Booom.
Extremely fragile code.

There's already a named resource struct you can use for this
(h2_smc91x_resources). Use it.

Same comments go for the other locations in this file as well as the
other OMAP2+ patch, where appropriate.

-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
