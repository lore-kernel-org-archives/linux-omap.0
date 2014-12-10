From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC/PATCH 2/7] arm: omap: devicetree: add new properties for
 OMAP devices
Date: Wed, 10 Dec 2014 16:37:19 +0530
Message-ID: <54882967.60302@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com> <1418164072-19087-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51052 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaLJLJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2014 06:09:01 -0500
In-Reply-To: <1418164072-19087-3-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

Hi Felipe,

On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> In order to get rid of some more hwmod data, we
> introduce a few extra properties to OMAP DT
> data in order to be able to pass the needed
> information through DT.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 4f6a82c..c6b9515 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -23,6 +23,13 @@ Optional properties:
>    during suspend.
>  - ti,no-reset-on-init: When present, the module should not be reset at init
>  - ti,no-idle-on-init: When present, the module should not be idled at init
> +- ti,rev_offs: IP block revision register offset (defaults to 0)
> +- ti,sysc_offs: OCP_SYSCONFIG register offset (defaults to 0)
> +- ti,syss_offs: OCP_SYSSTATUS register offset (defaults to 0)
> +- ti,srst_udelay: Delay needed after a softreset in usecs (defaults to 0)
> +- ti,idlemodes: Slave and Master supported idling modes
> +- ti,clockact: default value of clock activity bits (defaults to 0)
> +- ti,sysc_type: OCP_SYSCONFIG type. Valid types are 1, 2 or 3 (defaults to 1)
Once if all the hwmod data comes to dt it will be very dufficult to see all the data
together. Can we separate out hwmod class data like clocks data is separated out into different node
or something of the sort like below?

	ti, hwmod_class {
		ti,class_name = <>;
		ti,rev_offs = <>;
		ti,sysc_offs = <>;
		ti,syss_offs = <>;
		ti,srst_udelay = <>;
		ti,idlemodes = <>;
		ti,clockact = <>;
		ti,sysc_type = <>;
	};

example:
	counter32k: counter@44e86000 {
			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
			reg = <0x44e86000 0x40>;
			ti,hwmods = "counter_32k";
			ti,hwmod_class {
				ti,class_name = "synctimer";
				ti,idlemodes = <0x3>;
				ti,sysc_flags = <0x20>;
				ti,sysc_offs = <0x4>;
			};
	};

Thanks and regards,
Lokesh
		
>  
>  Example:
>  
> 

