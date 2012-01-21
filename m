From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Sat, 21 Jan 2012 00:38:30 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201210035180.28153@utopia.booyaka.com>
References: <1327055619.1921.57.camel@deskari>  <CAAL8m4xNj=-=tz7Fkv_MQzvQy5iNj9n10=00KAi0=ixtQ1GVVA@mail.gmail.com> <1327057644.1921.59.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50445 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2AUHib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jan 2012 02:38:31 -0500
In-Reply-To: <1327057644.1921.59.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>

On Fri, 20 Jan 2012, Tomi Valkeinen wrote:

> On Fri, 2012-01-20 at 16:19 +0530, Govindraj wrote:
> > On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > > Hi,
> > >
> > > I'm testing v3.3-rc1 on OMAP3 overo, and I'm having problems probably
> > > related to PM.
> > >
> > > First, when I boot up, the console (via USB serial) is very laggy, it
> > > often takes many seconds until the key pressed appears so it's more or
> > > less unusable.
> > 
> > can you try enabling CONFIG_CPU_IDLE ?
> 
> Enabling CPU_IDLE does remove the problems. I don't know what it's
> supposed to do, but it seems to keep the MPU and DSS in ON state all the
> time, so the problem disappears.

Enabling CONFIG_CPU_IDLE doesn't fix it for me.  Maybe that's because 
I'm just using omap2plus_defconfig.


- Paul
