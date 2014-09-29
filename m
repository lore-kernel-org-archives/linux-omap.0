From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH RESEND v6 0/7] net: cpsw: Support for am335x chip MACIDs
Date: Mon, 29 Sep 2014 14:21:28 +0530
Message-ID: <54291D90.4010806@ti.com>
References: <1411973599-18908-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42613 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbaI2IwK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2014 04:52:10 -0400
In-Reply-To: <1411973599-18908-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, kernel@pengutronix.de

On Monday 29 September 2014 12:23 PM, Markus Pargmann wrote:
> Hi,
> 
> Another resend of this series to add the netdev list.
> 
> This series adds support to the cpsw driver to read the MACIDs of the am335x
> chip and use them as fallback. These addresses are only used if there are no
> mac addresses in the devicetree, for example set by a bootloader.
> 
> Best regards,
> 
> Markus
> 
> 
> Markus Pargmann (7):
>   DT doc: net: cpsw mac-address is optional
>   net: cpsw: Add missing return value
>   net: cpsw: header, Add missing include
>   net: cpsw: Replace pr_err by dev_err
>   net: cpsw: Add am33xx MACID readout
>   am33xx: define syscon control module device node
>   arm: dts: am33xx, Add syscon phandle to cpsw node
> 
>  Documentation/devicetree/bindings/net/cpsw.txt |  6 +++-
>  arch/arm/boot/dts/am33xx.dtsi                  |  6 ++++
>  drivers/net/ethernet/ti/Kconfig                |  2 ++
>  drivers/net/ethernet/ti/cpsw.c                 | 45 ++++++++++++++++++++++++--
>  drivers/net/ethernet/ti/cpsw.h                 |  1 +
>  5 files changed, 57 insertions(+), 3 deletions(-)
> 

Acked-by: Mugunthan V N <mugunthanvnm@gmail.com>

Regards
Mugunthan V N
