From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [irda-users] [PATCH] OMAP IrDA driver
Date: Mon, 22 Dec 2008 16:50:25 +0530
Message-ID: <5d5443650812220320q365b97e4hdff226cb8101f6ed@mail.gmail.com>
References: <5d5443650812042234y6301148at6658f4855500b105@mail.gmail.com>
	 <ea9ea93a42eaf41cd9ee3ff11ad1a026@localhost>
	 <5d5443650812050148n2b3fca72m272a1af33629c478@mail.gmail.com>
	 <20081205203216.GJ9714@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:49198 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbYLVLU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2008 06:20:26 -0500
In-Reply-To: <20081205203216.GJ9714@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: samuel@sortiz.org, linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org

Hi Tony,

>
>> +
>> +/*
>> + * Set the IrDA communications speed.
>> + * Interrupt have to be disabled here.
>> + */
>> +static int omap_irda_startup(struct net_device *dev)
>> +{
>> +     struct omap_irda *omap_ir = netdev_priv(dev);
>> +
>> +     /* FIXME: use clk_* apis for UART3 clock*/
>> +     /* Enable UART3 clock and set UART3 to IrDA mode */
>> +     if (machine_is_omap_h2() || machine_is_omap_h3())
>> +             omap_writel(omap_readl(MOD_CONF_CTRL_0) | (1 << 31) | (1 << 15),
>> +                             MOD_CONF_CTRL_0);

This looks like muxing on H3.

>> +
>> +     /* Only for H2?
>> +      */
>> +     if (omap_ir->pdata->transceiver_mode && machine_is_omap_h2()) {
>> +             /* Is it select_irda on H2 ? */
>> +             omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7,
>> +                                     FUNC_MUX_CTRL_A);
>> +             omap_ir->pdata->transceiver_mode(omap_ir->dev, IR_SIRMODE);
>> +     }
>> +
>

I can move this to board-h3.c file instead with platform data flag probably.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
