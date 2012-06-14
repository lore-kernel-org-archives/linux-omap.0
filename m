From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 06/17] i2c: omap: improve 1p153 errata handling
Date: Thu, 14 Jun 2012 16:31:02 +0530
Message-ID: <CAMQu2gxY6x+JFw1ncimpVSxutJ_+4zscGHzVpg85W-4SPfUJRQ@mail.gmail.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com> <1339669250-9183-7-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44917 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754880Ab2FNLBY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 07:01:24 -0400
Received: by qcsg15 with SMTP id g15so1294085qcs.27
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 04:01:23 -0700 (PDT)
In-Reply-To: <1339669250-9183-7-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: ben-linux@fluff.org, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> Make it not depend on ISR's local variables
> in order to make it easier to re-factor the
> transmit data loop.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> =A0drivers/i2c/busses/i2c-omap.c | =A0 47 +++++++++++++++++++++++++++=
++------------
> =A01 file changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> index 0661ca1..52861c2 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -768,21 +768,24 @@ omap_i2c_omap1_isr(int this_irq, void *dev_id)
> =A0* data to DATA_REG. Otherwise some data bytes can be lost while tr=
ansferring
> =A0* them from the memory to the I2C interface.
> =A0*/
> -static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, i=
nt *err)
> +static int errata_omap3_1p153(struct omap_i2c_dev *dev)
> =A0{
> - =A0 =A0 =A0 unsigned long timeout =3D 10000;
> + =A0 =A0 =A0 unsigned long =A0 timeout =3D 10000;

Not related to this patch but this 10000 timeout magic
needs to be fixed as well.

The patch looks fine.

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
