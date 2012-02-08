From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: OMAP34xx
Date: Wed, 8 Feb 2012 15:15:51 -0800
Message-ID: <20120208231551.GA9009@kroah.com>
References: <20120205175809.GF17309@n2100.arm.linux.org.uk>
 <20120205182910.GK1426@atomide.com>
 <87lioegtk9.fsf@ti.com>
 <87y5sei1qz.fsf@ti.com>
 <CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
 <87k43xfee3.fsf@ti.com>
 <20120208170653.GA3492@kroah.com>
 <CANOLnOOTKwtNjWZWXEqsNVy20s8QLwK=2UKGMp8S_Zj6qZH9dg@mail.gmail.com>
 <20120208195327.GA5223@kroah.com>
 <871uq53p3c.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38363 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab2BHXQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 18:16:22 -0500
Received: by pbcun15 with SMTP id un15so1006853pbc.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 15:16:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <871uq53p3c.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Wed, Feb 08, 2012 at 03:03:19PM -0800, Kevin Hilman wrote:
> Hi Greg,
> 
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> [...]
> 
> >> It would look to me like they are queued for 3.4 but Kevin says there
> >> were intended for 3.3-rc.
> >
> > Kevin might have wished they would go into 3.3, but given that the first
> > round of these patches had to be reverted, I thought it safer to wait
> > for 3.4.
> 
> Sorry for the churn on these, but I guess we weren't expecting you to
> apply the first before it got some testing/acks.  Sorry about that.

Don't send me anything, saying it needs to get into the -rc merge
window, that you don't actually want to see merged.  Otherwise, how long
am I supposed to know to wait?  That's just looney.

> The version you have currently queued is needed for v3.3 as they fix
> brokenness on v3.3.  Any chance they can be applied queued for 3.3?
> We'll have another set of enhancements on top of those that are
> targetted for v3.4, but those you have queued currently are defintely
> fixes.

At this point in the release cycle, I would prefer to wait.

But, after they go into Linus's tree for the 3.4-rc1 merge, send the git
commit ids of the patches to stable@vger.kernel.org and they can get
merged to the 3.3.y tree to make things better there.

thanks,

greg k-h
