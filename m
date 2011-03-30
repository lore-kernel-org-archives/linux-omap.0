From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v2 1/2] isp1704_charger: allow board specific powering
 routine
Date: Wed, 30 Mar 2011 15:18:56 +0400
Message-ID: <4D9311A0.1000005@ru.mvista.com>
References: <1301295099-22066-1-git-send-email-kalle.jokiniemi@nokia.com> <1301295099-22066-2-git-send-email-kalle.jokiniemi@nokia.com> <4D904425.3050307@ru.mvista.com> <9D0D31AA57AAF5499AFDC63D6472631B06D67D@008-AM1MPN1-036.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41751 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977Ab1C3LUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 07:20:32 -0400
In-Reply-To: <9D0D31AA57AAF5499AFDC63D6472631B06D67D@008-AM1MPN1-036.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kalle.jokiniemi@nokia.com
Cc: sshtylyov@mvista.com, cbouatmailru@gmail.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, Heikki.Krogerus@nokia.com, jhnikula@gmail.com, khilman@ti.com

Hello.

On 29.03.2011 9:52, kalle.jokiniemi@nokia.com wrote:

>>   >  >  diff --git a/include/linux/power/isp1704_charger.h
>   >   >  b/include/linux/power/isp1704_charger.h
>   >   >  >  new file mode 100644
>   >   >  >  index 0000000..68096a6
>   >   >  >  --- /dev/null
>   >   >  >  +++ b/include/linux/power/isp1704_charger.h
>   >   >  >  @@ -0,0 +1,29 @@
>   >   >  >  +/*
>   >   >  >  + * ISP1704 USB Charger Detection driver
>   >   >  >  + *
>   >   >  >  + * Copyright (C) 2011 Nokia Corporation
>   >   >  >  + *
>   >   >  >  + * This program is free software; you can redistribute it and/or modify
>   >   >  >  + * it under the terms of the GNU General Public License as published by
>   >   >  >  + * the Free Software Foundation; either version 2 of the License, or
>   >   >  >  + * (at your option) any later version.
>   >   >  >  + *
>   >   >  >  + * This program is distributed in the hope that it will be useful,
>   >   >  >  + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   >   >  >  + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   >   >  >  + * GNU General Public License for more details.
>   >   >  >  + *
>   >   >  >  + * You should have received a copy of the GNU General Public License
>   >   >  >  + * along with this program; if not, write to the Free Software
>   >   >  >  + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
>   >  USA
>   >   >  >  + */
>   >   >  >  +
>   >   >  >  +
>   >   >  >  +#ifndef __ISP1704_CHARGER_H
>   >   >  >  +#define __ISP1704_CHARGER_H
>   >   >  >  +
>   >   >  >  +struct isp1704_charger_data {
>   >   >  >  +	void		(*set_power)(bool on);
>   >   >  >  +};
>   >   >  >  +
>   >   >  >  +#endif

>   >   >      There should be include/linux/platform_data/ directory now, specifically
>   >   >  for such headers...

>   >  Thanks for the pointer, I'll put it there.

> There are things like msm-serial.h and tegra-usb.h there, but I'm not so convinced
> that this isp1704_charger.h should be there. The isp1707 component on n900 is
> a discrete chip, it's not part of the SoC, so in theory some other device or platform
> could also use it as a charger. It's not even made by TI, so it's not related in that
> sense to OMAP platform...

    This directory is very new, so there's not much there yet. I don't think 
it's dedicated to SoC devices. Frankly speaking, I didn't get your 
argumentation here...

> What do you think about keeping it still in /include/linux/power ?

    Well, I wouldn't object. It seemed to me initially that you're going to 
put it into include/linux/, so I've pointed to a better place...

> - Kalle

WBR, Sergei
