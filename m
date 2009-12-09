From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] smc91x: remove OMAP specific bits
Date: Tue, 8 Dec 2009 16:00:16 -0800
Message-ID: <20091209000016.GC24013@atomide.com>
References: <20091208170038.GA19338@localhost.localdomain>
 <20091208170826.GC19338@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55678 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936981AbZLIAAM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 19:00:12 -0500
Content-Disposition: inline
In-Reply-To: <20091208170826.GC19338@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, Nicolas Pitre <nico@fluxnic.net>
Cc: linux-omap@vger.kernel.org, linux-netdev@vger.kernel.org

* Ladislav Michl <Ladislav.Michl@seznam.cz> [091208 08:07]:
> Now that all OMAP boards are using the board resources, we don't need
> to keep the arch/board specific crap in the driver header.

Planning to merge this via linux-omap list too with the platform
data patch unless somebody at netdev has objections.

Nico, care to ack this?

Regards,

Tony

 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
> index 3911be7..bfc53eb 100644
> --- a/drivers/net/smc91x.h
> +++ b/drivers/net/smc91x.h
> @@ -206,21 +206,6 @@ SMC_outw(u16 val, void __iomem *ioaddr, int reg)
>  	}
>  }
>  
> -#elif	defined(CONFIG_ARCH_OMAP)
> -
> -/* We can only do 16-bit reads and writes in the static memory space. */
> -#define SMC_CAN_USE_8BIT	0
> -#define SMC_CAN_USE_16BIT	1
> -#define SMC_CAN_USE_32BIT	0
> -#define SMC_IO_SHIFT		0
> -#define SMC_NOWAIT		1
> -
> -#define SMC_inw(a, r)		readw((a) + (r))
> -#define SMC_outw(v, a, r)	writew(v, (a) + (r))
> -#define SMC_insw(a, r, p, l)	readsw((a) + (r), p, l)
> -#define SMC_outsw(a, r, p, l)	writesw((a) + (r), p, l)
> -#define	SMC_IRQ_FLAGS		(-1)	/* from resource */
> -
>  #elif	defined(CONFIG_SH_SH4202_MICRODEV)
>  
>  #define SMC_CAN_USE_8BIT	0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
