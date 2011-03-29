From: <kalle.jokiniemi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2 1/2] isp1704_charger: allow board specific powering
 routine
Date: Tue, 29 Mar 2011 05:52:03 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06D67D@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1301295099-22066-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301295099-22066-2-git-send-email-kalle.jokiniemi@nokia.com>
 <4D904425.3050307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Heikki.Krogerus-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

 > -----Original Message-----
 > From: Jokiniemi Kalle (Nokia-MS/Tampere)

<snip>

>  > > diff --git a/include/linux/power/isp1704_charger.h
 >  > b/include/linux/power/isp1704_charger.h
 >  > > new file mode 100644
 >  > > index 0000000..68096a6
 >  > > --- /dev/null
 >  > > +++ b/include/linux/power/isp1704_charger.h
 >  > > @@ -0,0 +1,29 @@
 >  > > +/*
 >  > > + * ISP1704 USB Charger Detection driver
 >  > > + *
 >  > > + * Copyright (C) 2011 Nokia Corporation
 >  > > + *
 >  > > + * This program is free software; you can redistribute it and/or modify
 >  > > + * it under the terms of the GNU General Public License as published by
 >  > > + * the Free Software Foundation; either version 2 of the License, or
 >  > > + * (at your option) any later version.
 >  > > + *
 >  > > + * This program is distributed in the hope that it will be useful,
 >  > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
 >  > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 >  > > + * GNU General Public License for more details.
 >  > > + *
 >  > > + * You should have received a copy of the GNU General Public License
 >  > > + * along with this program; if not, write to the Free Software
 >  > > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
 > USA
 >  > > + */
 >  > > +
 >  > > +
 >  > > +#ifndef __ISP1704_CHARGER_H
 >  > > +#define __ISP1704_CHARGER_H
 >  > > +
 >  > > +struct isp1704_charger_data {
 >  > > +	void		(*set_power)(bool on);
 >  > > +};
 >  > > +
 >  > > +#endif
 >  >
 >  >     There should be include/linux/platform_data/ directory now, specifically
 >  > for such headers...
 > 
 > Thanks for the pointer, I'll put it there.

There are things like msm-serial.h and tegra-usb.h there, but I'm not so convinced
that this isp1704_charger.h should be there. The isp1707 component on n900 is
a discrete chip, it's not part of the SoC, so in theory some other device or platform
could also use it as a charger. It's not even made by TI, so it's not related in that
sense to OMAP platform...

What do you think about keeping it still in /include/linux/power ?

- Kalle

 > 
 > - Kalle
 > 
 >  >
 >  > WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
