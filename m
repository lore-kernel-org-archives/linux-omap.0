From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND 2/4] can: c_can: Add d_can raminit support
Date: Wed, 5 Sep 2012 16:23:53 -0700
Message-ID: <20120905232353.GK1303@atomide.com>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
 <1346843564-25343-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28615 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755164Ab2IEXX6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 19:23:58 -0400
Content-Disposition: inline
In-Reply-To: <1346843564-25343-3-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* AnilKumar Ch <anilkumar@ti.com> [120905 04:14]:
> Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
> which holds all the message objects during transmission or
> receiving of data. This initialization/de-initialization should
> be done in synchronous with D_CAN clock.

Sounds like you should just implement runtime PM calls in the driver
and let the lower level code take care of this for you along with the
clocks etc.

> @@ -1071,6 +1077,8 @@ static int c_can_open(struct net_device *dev)
>  	struct c_can_priv *priv = netdev_priv(dev);
>  
>  	c_can_pm_runtime_get_sync(priv);
> +	/* Initialize DCAN RAM */
> +	c_can_reset_ram(priv, true);
>  
>  	/* open the can device */
>  	err = open_candev(dev);
> @@ -1099,6 +1107,8 @@ static int c_can_open(struct net_device *dev)
>  exit_irq_fail:
>  	close_candev(dev);
>  exit_open_fail:
> +	/* De-Initialize DCAN RAM */
> +	c_can_reset_ram(priv, false);
>  	c_can_pm_runtime_put_sync(priv);
>  	return err;
>  }

Oh your already have pm_runtime here, OK so yeah let's let the omap/am33xx
hwmod code do this for you. No changes to this driver needed then?

Tony
