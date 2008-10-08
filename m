From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2.6.27-rc9-omap] i2c-omap: timeouts begone
Date: Thu, 9 Oct 2008 00:54:56 +0300
Message-ID: <20081008215455.GA15087@frodo>
References: <A24693684029E5489D1D202277BE8944123692F2@dlee02.ent.ti.com> <20081008183808.GA31385@atomide.com> <200810081236.48940.david-b@pacbell.net> <200810081436.06810.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45565 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbYJHVzM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 17:55:12 -0400
Content-Disposition: inline
In-Reply-To: <200810081436.06810.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 08, 2008 at 02:36:05PM -0700, David Brownell wrote:
> I can tell someone's going to want a fix that's a
> lot more power-aware ... ;)
> 
> This seems to remove the need for the "hack" patch.
> 
> 
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -202,6 +202,9 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
>  
>  static void omap_i2c_unidle(struct omap_i2c_dev *dev)
>  {
> +	if (1)
> +		return;
> +
>  	if (dev->iclk != NULL)
>  		clk_enable(dev->iclk);
>  	clk_enable(dev->fclk);
> @@ -214,6 +217,9 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
>  {
>  	u16 iv;
>  
> +	if (1)
> +		return;
> +
>  	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
>  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
>  	if (dev->rev1)


At least we can say the problem seems to be related to pm. Maybe after
context restore we should wait until the clock stabilizes or some
register changes ??

-- 
balbi
