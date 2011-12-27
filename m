From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+ i2c NACK without STP
Date: Tue, 27 Dec 2011 20:18:21 +0530
Message-ID: <CANrkHUZ530H+0+YKy2QJPFbwUQ1zqD=OaSrF6ByTbpx6eU421Q@mail.gmail.com>
References: <20110614102409.GN3352@atomide.com>
	<1308048853-21911-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:47526 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754409Ab1L0OsX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 09:48:23 -0500
In-Reply-To: <1308048853-21911-1-git-send-email-j.weitzel@phytec.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ben-linux@fluff.org, linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, andy.green@linaro.org, patches@linaro.org, andy@warmcat.com, tony@atomide.com, peter.maydell@linaro.org, khilman@ti.com, Jan Weitzel <j.weitzel@phytec.de>, Shubhrajyoti Datta <shubhrajyoti@ti.com>

On Tue, Jun 14, 2011 at 4:24 PM, Jan Weitzel <j.weitzel@phytec.de> wrot=
e:
> On OMAP4 OMAP_I2C_STAT_NACK is causing a timeout on the next access.
> The isr cleans all flags in OMAP_I2C_CON_REG by setting OMAP_I2C_CON_=
STP
> OMAP_I2C_CON_STP is also set in omap_i2c_xfer_msg on the last message=
=2E
>
> According to the TI TSR the sequence for OMAP_I2C_STAT_NACK and
> OMAP_I2C_STAT_AL are nearly the same.
> Removing the OMAP_I2C_CON_STP part in the isr fix the problem.
> Tested on OMAP4430 and OMAP3530 (here NACK was not a problem)
> Fixes also booting on 2430sdp.
>
> Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Balaji T K <balajitk@ti.com>
Can you please queue this patch

This patch has been tested in linux-omap tree
http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap.git;a=3Dc=
ommit;h=3D464fca36d98b97ccd05e4f200ab7483d3acc8345

> ---
> =A0drivers/i2c/busses/i2c-omap.c | =A0 =A06 ++----
> =A01 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> index 58a58c7..670f2a2 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -836,11 +836,9 @@ complete:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0~(OMAP=
_I2C_STAT_RRDY | OMAP_I2C_STAT_RDR |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_I=
2C_STAT_XRDY | OMAP_I2C_STAT_XDR));
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (stat & OMAP_I2C_STAT_NACK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (stat & OMAP_I2C_STAT_NACK)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err |=3D OMAP_I2C_STAT=
_NACK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_i2c_write_reg(dev,=
 OMAP_I2C_CON_REG,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0OMAP_I2C_CON_STP);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (stat & OMAP_I2C_STAT_AL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev->dev, "Arb=
itration lost\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err |=3D OMAP_I2C_STAT=
_AL;
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
