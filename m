From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: i2c issue on Panda with DT boot, v3.10-rc4
Date: Fri, 7 Jun 2013 15:36:38 +0300
Message-ID: <51B1D3D6.2020803@ti.com>
References: <51B1C9D2.6060703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab3FGMkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 08:40:16 -0400
In-Reply-To: <51B1C9D2.6060703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

hi Tomi,
On 06/07/2013 02:53 PM, Tomi Valkeinen wrote:
> Hi,
>
> I was testing DT boot with 3.10-rc1 and Pandaboard, and couldn't get the
> DVI output's EDID reading to work. Testing with i2cget and i2cdump, I
> see that I can read individual bytes with i2cget, but using i2cdump
> doesn't work, it just shows 'XX'es.
>
> The same issue is there with 3.10-rc4, although with that one I get
> timeouts with i2cdump, whereas there were no timeouts with -rc1.
>
> # i2cget -y 2 0x50 0x10
> 0x0a
> # i2cget -y 2 0x50 0x20
> 0x0f
> # i2cget -y 2 0x50 0x30
> 0x01
> # i2cget -y 2 0x50 0x40
> 0x36
> # i2cget -y 2 0x50 0x50
> 0x4c
> # i2cdump -y 2 0x50
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 [   72.814086] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   73.825134] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   74.835327] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   76.097167] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   77.160736] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   78.174682] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   79.194824] omap_i2c 48060000.i2c: timeout waiting for bus ready
> XX [   80.242980] omap_i2c 48060000.i2c: timeout waiting for bus ready
>
> i2cdump works fine with non-DT boot (but the i2c bus number is 3).
>
> Any ideas?
>
>   Tomi
>
Could you check if below change will help you, pls?
iff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 13d1eca..66a62e7 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -615,11 +615,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
         if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
                 if (msg->flags & I2C_M_IGNORE_NAK)
                         return 0;
-               if (stop) {
-                       w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
-                       w |= OMAP_I2C_CON_STP;
-                       omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
-               }
+
+               w = omap_i2c_read_reg(dev, OMAP_I2C_CON_REG);
+               w |= OMAP_I2C_CON_STP;
+               omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, w);
+
                 return -EREMOTEIO;
         }
         return -EIO;

-grygorii
