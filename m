From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [OMAP and mainline][RFC 2.6.28-rc2-omap 3/3] USB: OHCI-OMAP:
 Switch to gpio_request/free calls
Date: Wed, 12 Nov 2008 09:53:18 +0200
Message-ID: <20081112095318.621bb99d.jarkko.nikula@nokia.com>
References: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com>
	<200811101423.50989.david-b@pacbell.net>
	<20081111151737.3dc034d5.jarkko.nikula@nokia.com>
	<200811112228.13664.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50491 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYKLHxt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2008 02:53:49 -0500
In-Reply-To: <200811112228.13664.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Tue, 11 Nov 2008 22:28:13 -0800
"ext David Brownell" <david-b@pacbell.net> wrote:

> > Do you see are there any issue to change label into last column like
> > in /proc/interrupts so that width doesn't have to be fixed?
> 
> Only that the amount of data to the right of that label
> is variable size too.  I was following a convention that
> the standard debug dump code (gpiolib) and the gpio_chip
> specific stuff all looked pretty much the same except for
> the extras (pullups, pulldowns, drive strength, debounce,
> and so on) on the right.
> 
Yep, again zero thinking from me :-)

> I'd keep it simple and just allow for fatter labels.
> Less work all around.
> 
I just sent a patch extending width to 20 bytes via LKML and you in cc
list. I looked mainline and there were many labels more than 12 but
less 20 bytes. One longer was "board a9m9750dev extirq2" but looks like
it can be squeezed.


Jarkko
