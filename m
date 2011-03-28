From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 1/2] isp1704_charger: allow board specific powering
 routine
Date: Mon, 28 Mar 2011 12:17:41 +0400
Message-ID: <4D904425.3050307@ru.mvista.com>
References: <1301295099-22066-1-git-send-email-kalle.jokiniemi@nokia.com> <1301295099-22066-2-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61996 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1C1ITP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Mar 2011 04:19:15 -0400
In-Reply-To: <1301295099-22066-2-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, heikki.krogerus@nokia.com, jhnikula@gmail.com, khilman@ti.com

Hello.

On 28-03-2011 10:51, Kalle Jokiniemi wrote:

> The ISP1704/1707 chip can be put to full power down
> state by asserting the CHIP_SEL line. This patch enables
> platform or board specific hooks to put the device into
> power down mode in case not needed.

> These patches are preparatio for enabling this powering

    Preparation.

> routine in n900 (rx-51) devices.

> Thanks to Heikki Krogerus for helping out with the patch.

> Signed-off-by: Kalle Jokiniemi<kalle.jokiniemi@nokia.com>
> Cc: Heikki Krogerus<heikki.krogerus@nokia.com>
[...]

> diff --git a/include/linux/power/isp1704_charger.h b/include/linux/power/isp1704_charger.h
> new file mode 100644
> index 0000000..68096a6
> --- /dev/null
> +++ b/include/linux/power/isp1704_charger.h
> @@ -0,0 +1,29 @@
> +/*
> + * ISP1704 USB Charger Detection driver
> + *
> + * Copyright (C) 2011 Nokia Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +
> +#ifndef __ISP1704_CHARGER_H
> +#define __ISP1704_CHARGER_H
> +
> +struct isp1704_charger_data {
> +	void		(*set_power)(bool on);
> +};
> +
> +#endif

    There should be include/linux/platform_data/ directory now, specifically 
for such headers...

WBR, Sergei
