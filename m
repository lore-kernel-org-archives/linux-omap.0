From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: [PATCH] cbus-retu-wdt: Store all data in device struct
Date: Mon, 07 Mar 2011 12:28:42 +0100
Message-ID: <1299497322.7466.10.camel@maggie>
References: <1299252779.21644.11.camel@marge>
	 <20110307074324.GE2522@legolas.emea.dhcp.ti.com>
	 (sfid-20110307_084334_986395_FFFFFFFFB882C95C)
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:49064 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370Ab1CGL2u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 06:28:50 -0500
In-Reply-To: <20110307074324.GE2522@legolas.emea.dhcp.ti.com> (sfid-20110307_084334_986395_FFFFFFFFB882C95C)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 2011-03-07 at 09:43 +0200, Felipe Balbi wrote: 
> > -	struct miscdevice	retu_wdt_miscdev;
> > +	struct miscdevice	miscdev;
> 
> this rename is not part of $SUBJECT

Well, that element is used in several new container_of() instances.
retu_wdt_miscdev is needlessly long and just increases the line-length
pain on the container_of() lines.
The retu_wdt prefix is useless, because it's an element of the retu_wdt
data structure.

> >  	struct delayed_work	ping_work;
> > +	struct mutex		mutex;
> 
> checkpatch.pl --strict will complain about this mutex not having a
> comment explaining it. Can you add something ?

Is that really required? I mean, it's obvious what the mutex is used
for and what it is protecting (the whole struct).

> > -static int _retu_modify_counter(unsigned int new)
> > +static inline void _retu_modify_counter(struct retu_wdt_dev *wdev,
> > +					unsigned int new)
> 
> let the compiler inline it, maybe ?!?

Ok, it doesn't change the object code either way.

-- 
Greetings Michael.

