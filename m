From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] arm/dts: OMAP3: Add omap3evm and am335xevm support
Date: Wed, 1 Feb 2012 21:56:29 -0700
Message-ID: <20120202045629.GJ15343@ponder.secretlab.ca>
References: <1328077620-22411-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45081 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab2BBE4b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 23:56:31 -0500
Received: by dadp15 with SMTP id p15so1524311dad.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 20:56:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328077620-22411-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 01, 2012 at 11:57:00AM +0530, Vaibhav Hiremath wrote:
> TI's OMAP3EVM and AM335xEVM are software development boards
> available for OMAP35x(AM/DM37x) and AM335x devices respectively;
> and these devices are considered under omap3 family.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>

Applied, thanks.

g.

> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index dbdab40..ce78498 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -41,3 +41,9 @@ Boards:
> 
>  - OMAP4 PandaBoard : Low cost community board
>    compatible = "ti,omap4-panda", "ti,omap4430"
> +
> +- OMAP3 EVM : Software Developement Board for OMAP35x, AM/DM37x
> +  compatible = "ti,omap3-evm", "ti,omap3"
> +
> +- AM335X EVM : Software Developement Board for AM335x
> +  compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
> --
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
