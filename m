From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling for
	3630
Date: Fri, 4 Jun 2010 19:38:56 +0530
Message-ID: <AANLkTimRBs4cpfIyUMMMeU7xIFjhOK4I8W66RSk3oip4@mail.gmail.com>
References: <53199.192.168.10.88.1275659023.squirrel@dbdmail.itg.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03232DA919@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f187.google.com ([209.85.211.187]:55915 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab0FDOQo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 10:16:44 -0400
Received: by ywh17 with SMTP id 17so500635ywh.1
        for <linux-omap@vger.kernel.org>; Fri, 04 Jun 2010 07:16:41 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03232DA919@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Aguirre, Sergio" <saaguirre@ti.com>

On Fri, Jun 4, 2010 at 7:33 PM, Gopinath, Thara <thara@ti.com> wrote:
>
>
>>>-----Original Message-----
>>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger=
=2Ekernel.org] On Behalf Of
>>>Govindraj.R
>>>Sent: Friday, June 04, 2010 7:14 PM
>>>To: linux-omap@vger.kernel.org
>>>Cc: Kevin Hilman; Aguirre, Sergio
>>>Subject: [pm-wip/uart][PATCH 2/4] OMAP3: serial: Fix uart4 handling =
for 3630
>>>
>>>This patch makes the following:
>>> - Adds missing wakeup padding register handling.
>>> - Fixes a hardcode to use PER module ONLY on UART3.
>>> - Muxmode usage needed for uart4 for 3630 for padconf
>>> =A0 wakeup on rx line.
>>>
>>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>>Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
>>>Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>>>---
>>> arch/arm/mach-omap2/serial.c | =A0 30 +++++++++++++++++++++++++++++=
-
>>> 1 files changed, 29 insertions(+), 1 deletions(-)
>>>
>>>diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/seri=
al.c
>>>index da9fee6..70a9089 100644
>>>--- a/arch/arm/mach-omap2/serial.c
>>>+++ b/arch/arm/mach-omap2/serial.c
>>>@@ -42,6 +42,7 @@
>>> #include "prm.h"
>>> #include "pm.h"
>>> #include "cm.h"
>>>+#include "mux.h"
>>> #include "prm-regbits-34xx.h"
>>>
>>> #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV =A00x52
>>>@@ -68,6 +69,7 @@ struct omap_uart_state {
>>> =A0 =A0 =A0u32 wk_mask;
>>> =A0 =A0 =A0u32 padconf;
>>> =A0 =A0 =A0u32 dma_enabled;
>>>+ =A0 =A0 u16 muxmode;
>>>
>>> =A0 =A0 =A0struct clk *ick;
>>> =A0 =A0 =A0struct clk *fck;
>>>@@ -229,8 +231,20 @@ static inline void omap_uart_disable_clocks(str=
uct omap_uart_state *uart)
>>> =A0 =A0 =A0omap_device_idle(uart->pdev);
>>> }
>>>
>>>+static inline void omap_uart_setmux_mode(struct omap_uart_state *ua=
rt)
>>>+{
>>>+ =A0 =A0 u16 w =3D omap_ctrl_readw(uart->padconf);
>>>+ =A0 =A0 w &=3D ~0x7;
>>>+ =A0 =A0 w |=3D OMAP_MUX_MODE2;
>
> Why it is hard coded to MUX_MODE2? Should it not be w |=3D uart->muxm=
ode?
>
> Regards
> Thara

Yes correct it should been w |=3D uart->muxmode.

---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
