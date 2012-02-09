From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 10:49:20 -0800
Message-ID: <20120209184920.GA15635@kroah.com>
References: <CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
 <87k43xfee3.fsf@ti.com>
 <20120208170653.GA3492@kroah.com>
 <CANOLnOOTKwtNjWZWXEqsNVy20s8QLwK=2UKGMp8S_Zj6qZH9dg@mail.gmail.com>
 <20120208195327.GA5223@kroah.com>
 <871uq53p3c.fsf@ti.com>
 <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com>
 <87vcngiy3z.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46859 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758190Ab2BISuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 13:50:16 -0500
Received: by pbcun15 with SMTP id un15so1770273pbc.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 10:50:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87vcngiy3z.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Wed, Feb 08, 2012 at 05:39:28PM -0800, Kevin Hilman wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > What changeset(s) do you want me to take from my tty-next tree and put
> > it in the tty-linus tree to be merged for the 3.3-final timeframe?
> 
> 6bbcbf2 tty: serial: omap-serial: wakeup latency constraint is in microseconds, 
> edbe5db tty: serial: OMAP: block idle while the UART is transferring data in PIO
> 5816269 tty: serial: OMAP: use a 1-byte RX FIFO threshold in PIO mode

Thanks, but they needed to be applied in backwards order :)

greg k-h
