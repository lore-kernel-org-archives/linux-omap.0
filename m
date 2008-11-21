From: David Brownell <david-b@pacbell.net>
Subject: Re: [OMAP and mainline][RFC 2.6.28-rc2-omap 3/3] USB: OHCI-OMAP: Switch to gpio_request/free calls
Date: Fri, 21 Nov 2008 15:37:13 -0800
Message-ID: <200811211537.13253.david-b@pacbell.net>
References: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com> <20081112095318.621bb99d.jarkko.nikula@nokia.com> <20081121221638.GE4927@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:37050 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752779AbYKUXhQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 18:37:16 -0500
In-Reply-To: <20081121221638.GE4927@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

On Friday 21 November 2008, Tony Lindgren wrote:
> > > 
> > I just sent a patch extending width to 20 bytes via LKML and you in cc
> > list. I looked mainline and there were many labels more than 12 but
> > less 20 bytes. One longer was "board a9m9750dev extirq2" but looks like
> > it can be squeezed.
> 
> Jarkko, any news on updating this patch series? It would be nice to
> have this queued up for  2.6.29.

The gpiolib change is in mainline git.

