From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC] i2c-omap: Don't wait needlessly
Date: Fri, 24 Oct 2008 13:17:40 +0300
Message-ID: <20081024131740.64641d26.jarkko.nikula@nokia.com>
References: <12246059481717-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__24_Oct_2008_13_17_40_+0300_dRmOKsE7IfEL79.2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41458 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYJXKS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 06:18:26 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9OAIDe8004592
	for <linux-omap@vger.kernel.org>; Fri, 24 Oct 2008 13:18:22 +0300
In-Reply-To: <12246059481717-git-send-email-sakari.ailus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__24_Oct_2008_13_17_40_+0300_dRmOKsE7IfEL79.2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2008 19:19:08 +0300
"ext Sakari Ailus" <sakari.ailus@nokia.com> wrote:

>  /* timeout waiting for the controller to respond */
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> +/* no more busyloop in ns */
> +#define OMAP_I2C_MINOR_TIMEOUT		10
>  
>  #define OMAP_I2C_REV_REG		0x00
>  #define OMAP_I2C_IE_REG			0x04
> @@ -255,6 +257,8 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  	unsigned long internal_clk = 0;
>  
>  	if (!dev->rev1) {
> +		int delay = 0;
> +
>  		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
>  		/* For some reason we need to set the EN bit before the
>  		 * reset done bit gets set. */
> @@ -262,6 +266,14 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>  		while (!(omap_i2c_read_reg(dev, OMAP_I2C_SYSS_REG) &
>  			 OMAP_I2C_SYSS_RDONE)) {
> +			if (delay < OMAP_I2C_MINOR_TIMEOUT) {
> +				ndelay(1);
> +				delay++;
> +				continue;
> +			} else if (delay == OMAP_I2C_MINOR_TIMEOUT) {
> +				dev_warn(dev->dev, "minor timeout not enough");
> +				delay++;
> +			}
>  			if (time_after(jiffies, timeout)) {
>  				dev_warn(dev->dev, "timeout waiting "
>  						"for controller reset\n");
>
I would rather, if there is no need for such a long delay like
OMAP_I2C_TIMEOUT, remove that time_after and msleep(1) stuff and
just loop few iterations with udelay(1). Zero thinked & tested diff
attached.

I would say that ndelay(1) just doesn't look relevant to < 1 GHz
cpus :-)


Jarkko

--Multipart=_Fri__24_Oct_2008_13_17_40_+0300_dRmOKsE7IfEL79.2
Content-Type: text/x-diff;
 name="hack.diff"
Content-Disposition: attachment;
 filename="hack.diff"
Content-Transfer-Encoding: 7bit

--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -248,16 +248,16 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, OMAP_I2C_SYSC_SRST);
 		/* For some reason we need to set the EN bit before the
 		 * reset done bit gets set. */
-		timeout = jiffies + OMAP_I2C_TIMEOUT;
+		timeout = 10;
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
 		while (!(omap_i2c_read_reg(dev, OMAP_I2C_SYSS_REG) &
 			 OMAP_I2C_SYSS_RDONE)) {
-			if (time_after(jiffies, timeout)) {
+			udelay(1);
+			if (--timeout) {
 				dev_warn(dev->dev, "timeout waiting "
 						"for controller reset\n");
 				return -ETIMEDOUT;
 			}
-			msleep(1);
 		}
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);

--Multipart=_Fri__24_Oct_2008_13_17_40_+0300_dRmOKsE7IfEL79.2--
