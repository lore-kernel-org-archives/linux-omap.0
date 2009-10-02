From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCHv1 1/3] OMAP UART: Adds omap-serial driver support.
Date: Fri, 2 Oct 2009 23:41:25 +0100
Message-ID: <20091002224124.GY1133@earth.li>
References: <65168.192.168.10.89.1253788033.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from the.earth.li ([217.147.81.2]:37622 "EHLO the.earth.li"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265AbZJBWlV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Oct 2009 18:41:21 -0400
Content-Disposition: inline
In-Reply-To: <65168.192.168.10.89.1253788033.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Sep 24, 2009 at 03:57:13PM +0530, Govindraj.R wrote:
> From: Govindraj R <govindraj.raja@ti.com>
> 
> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
> 
> Signed-off-by:	Govindraj R <govindraj.raja@ti.com>
> Reviewed-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> ---
 
> +config SERIAL_OMAP
> +	bool "OMAP serial port support"
> +	depends on ARM && ARCH_OMAP
> +	select SERIAL_CORE
> +	help
> +	If you have a machine based on an Texas Instruments OMAP CPU you
> +	can enable its onboard serial ports by enabling this option.

If it's OMAP3 hardware then should the "depends on" be ARCH_OMAP3 ||
ARCH_OMAP4, rather than allowing it for OMAP1 + 2 as well?

J.

-- 
Revd. Jonathan McDowell, ULC | If they can't take a joke....fuck 'em.
