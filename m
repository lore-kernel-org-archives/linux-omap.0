From: Kevin Hilman <khilman@ti.com>
Subject: Re: OMAP34xx
Date: Wed, 08 Feb 2012 17:39:28 -0800
Message-ID: <87vcngiy3z.fsf@ti.com>
References: <87lioegtk9.fsf@ti.com> <87y5sei1qz.fsf@ti.com>
	<CANOLnOMXdgBv_aGeK7ngD-d07QLRTR22iqD-4571LAuN0PV1FQ@mail.gmail.com>
	<87k43xfee3.fsf@ti.com> <20120208170653.GA3492@kroah.com>
	<CANOLnOOTKwtNjWZWXEqsNVy20s8QLwK=2UKGMp8S_Zj6qZH9dg@mail.gmail.com>
	<20120208195327.GA5223@kroah.com> <871uq53p3c.fsf@ti.com>
	<20120208231551.GA9009@kroah.com>
	<alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
	<20120209004731.GA11343@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:59819 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751706Ab2BIBjb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 20:39:31 -0500
Received: by mail-pw0-f41.google.com with SMTP id wz17so1332882pbc.14
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 17:39:31 -0800 (PST)
In-Reply-To: <20120209004731.GA11343@kroah.com> (Greg KH's message of "Wed, 8
	Feb 2012 16:47:31 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul@pwsan.com>, Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Greg KH <gregkh@linuxfoundation.org> writes:

> What changeset(s) do you want me to take from my tty-next tree and put
> it in the tty-linus tree to be merged for the 3.3-final timeframe?

6bbcbf2 tty: serial: omap-serial: wakeup latency constraint is in microseconds, 
edbe5db tty: serial: OMAP: block idle while the UART is transferring data in PIO
5816269 tty: serial: OMAP: use a 1-byte RX FIFO threshold in PIO mode

Thank you,

Kevin
