From: "Maulik" <x0082077@ti.com>
Subject: RE: [PATCH 1/2] ARM : OMAP: MUSB : Pass board specific data using a structure
Date: Wed, 30 Dec 2009 17:51:08 +0530
Message-ID: <010401ca894a$923b1050$808918ac@apr.dhcp.ti.com>
References: <1262169883-31226-1-git-send-email-x0082077@ti.com> <19F8576C6E063C45BE387C64729E7394044A277B44@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44882 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZL3MVW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 07:21:22 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A277B44@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Gupta, Ajay Kumar'" <ajay.gupta@ti.com>, linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, 'Felipe Balbi' <felipe.balbi@nokia.com>, 'Tony Lindgren' <tony@atomide.com>, 'Greg Kroah-Hartman' <gregkh@suse.de>


>>Isn't it simpler to use same name across the boards like,
>>'musb_board_data'
>>Instead of 'omap3430sdp_data'.

[Maulik] Will change in the next version. 

> 
> -extern void usb_musb_init(enum musb_mode mode, unsigned power);
> +struct musb_omap_data {
> +u8	interface_type;
> +u8	mode;
> +u8	power;
> +};

>>It's board data so how about 'struct omap_musb_board_data'.

[Maulik] Will change in the next version.

> +
> +enum musb_interface	{MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
> +
> +extern void usb_musb_init(void *);

Can be modified to:
+extern void usb_musb_init(omap_musb_board_data *);

[Maulik] Will change in the next version.


> +void __init usb_musb_init(void *arch_data)

>>It's actually board data so *board_data is clearer.

[Maulik] Can be done. Will change in the next version.


> +	musb_plat.arch_data = arch_data;

>>Not needed.

[Maulik] The patch adds a field interface_type for selecting between UTMI
and ULPI PHY. This is done for OMAP4 which uses internal UTMI phy.

Moreover in future if we need to add any board specific data it can be part
of this structure.

> --- felipe_musb.orig/include/linux/usb/musb.h
> +++ felipe_musb/include/linux/usb/musb.h
> @@ -84,6 +84,9 @@ struct musb_hdrc_platform_data {
> 
>  	/* MUSB configuration-specific details */
>  	struct musb_hdrc_config	*config;
> +
> +	/* Board specific data	*/
> +	void		*arch_data;

>>We don't need it as we will continue using 'power', 'mode', 'extvbus'
>>From musb_plat only.

[Maulik] The patch adds a field interface_type for selecting between UTMI
and ULPI PHY. This is done for OMAP4 which uses internal UTMI phy.

Moreover in future if we need to add any board specific data it can be part
of this structure.


