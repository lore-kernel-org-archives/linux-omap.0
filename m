From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] tty: serial: 8250: omap: Add pinctrl support for suspend
Date: Tue, 25 Nov 2014 10:22:21 -0800
Message-ID: <20141125182221.GJ2817@atomide.com>
References: <1415300850-21452-1-git-send-email-bigeasy@linutronix.de>
 <545BC8C1.4070503@ti.com>
 <545BCF3F.8020705@linutronix.de>
 <CAGo_u6qTqp1Wpo8E26gLpStu_EiRw32gstkCiXw+EWNDWSnHbw@mail.gmail.com>
 <20141106203544.GE31454@atomide.com>
 <5474C4D0.1060908@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50135 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaKYSYy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2014 13:24:54 -0500
Content-Disposition: inline
In-Reply-To: <5474C4D0.1060908@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [141125 10:07]:
> On 11/06/2014 09:35 PM, Tony Lindgren wrote:
> > The pinctrl change in this patch and the wake-up events are a separate
> > issue.
> 
> So this patch can go in and wake-up issue will be fixed once the
> infrastructure is there. No misunderstanding here?

Yes it will be mostly just removal of code.

Regards,

Tony
