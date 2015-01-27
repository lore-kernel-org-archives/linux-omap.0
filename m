From: "Devshatwar, Nikhil" <nikhil.nd@ti.com>
Subject: RE: [PATCH] dtc: parser: Add label while overriding nodes
Date: Tue, 27 Jan 2015 15:11:55 +0000
Message-ID: <E60A9E1B4132A24DB80BD56ABC92684735043E3E@DBDE04.ent.ti.com>
References: <1420726362-22555-1-git-send-email-nikhil.nd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37142 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbbA0PMG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2015 10:12:06 -0500
In-Reply-To: <1420726362-22555-1-git-send-email-nikhil.nd@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Devshatwar, Nikhil" <nikhil.nd@ti.com>, "devicetree-compiler@vger.kernel.org" <devicetree-compiler@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "devicetree-spec@vger.kernel.org" <devicetree-spec@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>

Hi all,

Does this patch make sense?

> -----Original Message-----
> From: Devshatwar, Nikhil
> Sent: Thursday, January 08, 2015 7:43 PM
> To: devicetree-compiler@vger.kernel.org; devicetree@vger.kernel.org;
> devicetree-spec@vger.kernel.org; linux-omap@vger.kernel.org
> Cc: Devshatwar, Nikhil
> Subject: [PATCH] dtc: parser: Add label while overriding nodes
> 
> Current device tree compiler allows to define multiple labels when
> defining the device node the first time. Typically device nodes are
> defined in DTSI files. Now these nodes can be overriden for updating
> some of the properties. Typically, device nodes are overridden in DTS
> files.
> 
> When working with adapter boards, most of the time adapter board can
> fit to multiple base boards. But depending on which base board it is
> connected to, the devices on the adapter board would be children of
> different devices.
> 
> e.g. On dra7-evm.dts, i2c2 is exported for expansion connector whereas
> on dra72-evm.dts, i2c5 is exported for expansion connector.
> This causes a problem when writing a generic device tree file for the
> adapter board. Because, you cannot know wheather all the devices on
> adpter board are present on i2c or i2c5.
> 
> The problem can be solved by adding a common label (e.g. i2cexp) in
> both of the DTS files when overriding the device nodes for i2c2 or
> i2c5.
> This way, generic adapter board file would override the i2cexp. And
> depending on which base board you use the adpter board, all the devices
> are automatically added for correct device nodes.
> 
> Change-Id: I3ad7247a79baed7268a91fc691360aece73d6d1b
> Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
> ---
>  scripts/dtc/dtc-parser.y |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y index
> f412460..d9ed3b7 100644
> --- a/scripts/dtc/dtc-parser.y
> +++ b/scripts/dtc/dtc-parser.y
> @@ -145,6 +145,18 @@ devicetree:
>  		{
>  			$$ = merge_nodes($1, $3);
>  		}
> +
> +	| devicetree DT_LABEL DT_REF nodedef
> +		{
> +			struct node *target = get_node_by_ref($1, $3);
> +
> +			add_label(&target->labels, $2);
> +			if (target)
> +				merge_nodes(target, $4);
> +			else
> +				print_error("label or path, '%s', not found",
> $2);
> +			$$ = $1;
> +		}
>  	| devicetree DT_REF nodedef
>  		{
>  			struct node *target = get_node_by_ref($1, $2);
> --
> 1.7.9.5

