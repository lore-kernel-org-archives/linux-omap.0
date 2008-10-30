From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/21 Continue phasing out legacy GPIO calls
Date: Thu, 30 Oct 2008 10:34:25 -0700
Message-ID: <20081030173424.GV13227@atomide.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <20081029160056.GD20456@atomide.com> <20081030151127.e0b8b430.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63219 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbYJ3Re1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 13:34:27 -0400
Content-Disposition: inline
In-Reply-To: <20081030151127.e0b8b430.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [081030 06:12]:
> On Wed, 29 Oct 2008 09:00:56 -0700
> "ext Tony Lindgren" <tony@atomide.com> wrote:
> 
> > Great. One request though:
> > 
> > Let's do the clean-up patches in two phases, one series that
> > applies against the mainline kernel, then additional patches for
> > linux-omap. Otherwise we'll never get out of this merge hell.
> > 
> > BTW, we should try to do the same for anything that we can already
> > patch in the mainline kernel.
> > 
> Is it most easiest to you if I leave the set aside for a while and base
> only first patch against mainline or David's recent set?

Well if possible we should queue them up for mainline via Dave's
gpiolib patches.

> Probably first conversion set is then for those board files which are
> in mainline and second set to non-mainline merged board files. Drivers
> probably can be converted gradually as they are going via their mailing
> lists?

I'd just send them all at once via Dave's gpiolib patches.

> At least with my first patch it's easy to detect from debugfs what is
> needed to convert :-)
> 
> +static inline int omap_request_gpio(int gpio)
> +{
> +	return gpio_request(gpio, "FIXME");
> +}

Yes, these are pretty straightforward patches :)

Tony
