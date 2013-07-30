From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 06/21] ARM: OMAP: overo: use new display drivers
Date: Tue, 30 Jul 2013 11:51:30 +0530
Message-ID: <51F75B6A.6090900@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com> <1374822504-28949-7-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53072 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3G3GWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 02:22:51 -0400
In-Reply-To: <1374822504-28949-7-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Friday 26 July 2013 12:38 PM, Tomi Valkeinen wrote:
> Use the new display drivers for OMAP3 Overo board.
>
> The new OMAP display drivers were merged for 3.11, and we can now change
> the board files to use the new ones and phase out the old ones.
>
> Note that the LCD add-on boards for lcd43 and lcd35 use the same GPIOs
> for the panels. This means that both panel devices cannot be probed at
> the same time.
>
> DT will handle this correctly, i.e. the DT data will contain the panel
> device only for the add-on board that is attached. However, for the
> board file we need a hackish solution: We parse the kernel boot command
> line, and see whether lcd43 or lcd35 is set as a default display, and
> add the given one. Or, if neither is given, default to lcd43.
>

<snip>

>   static struct omap_dss_board_info overo_dss_data = {
> -	.num_devices	= ARRAY_SIZE(overo_dss_devices),
> -	.devices	= overo_dss_devices,
> -	.default_device	= &overo_dvi_device,
> +	.default_display_name = "lcd43",
>   };

The default display previously was the dvi device, if both lcd43 and 
lcd35 are on add-on boards, then we should probably stick to dvi itself, 
right? The hack won't work if dvi is the default device though.

Archit

