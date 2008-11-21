From: Tony Lindgren <tony@atomide.com>
Subject: Re: [OMAP and mainline][RFC 2.6.28-rc2-omap 3/3] USB: OHCI-OMAP:
	Switch to gpio_request/free calls
Date: Fri, 21 Nov 2008 14:16:40 -0800
Message-ID: <20081121221638.GE4927@atomide.com>
References: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com> <200811101423.50989.david-b@pacbell.net> <20081111151737.3dc034d5.jarkko.nikula@nokia.com> <200811112228.13664.david-b@pacbell.net> <20081112095318.621bb99d.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53132 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbYKUWQn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 17:16:43 -0500
Content-Disposition: inline
In-Reply-To: <20081112095318.621bb99d.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [081111 23:54]:
> On Tue, 11 Nov 2008 22:28:13 -0800
> "ext David Brownell" <david-b@pacbell.net> wrote:
> 
> > > Do you see are there any issue to change label into last column like
> > > in /proc/interrupts so that width doesn't have to be fixed?
> > 
> > Only that the amount of data to the right of that label
> > is variable size too.  I was following a convention that
> > the standard debug dump code (gpiolib) and the gpio_chip
> > specific stuff all looked pretty much the same except for
> > the extras (pullups, pulldowns, drive strength, debounce,
> > and so on) on the right.
> > 
> Yep, again zero thinking from me :-)
> 
> > I'd keep it simple and just allow for fatter labels.
> > Less work all around.
> > 
> I just sent a patch extending width to 20 bytes via LKML and you in cc
> list. I looked mainline and there were many labels more than 12 but
> less 20 bytes. One longer was "board a9m9750dev extirq2" but looks like
> it can be squeezed.

Jarkko, any news on updating this patch series? It would be nice to
have this queued up for 2.6.29.

Tony
