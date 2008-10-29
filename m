From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/21 Continue phasing out legacy GPIO calls
Date: Wed, 29 Oct 2008 09:00:56 -0700
Message-ID: <20081029160056.GD20456@atomide.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54164 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbYJ2QBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 12:01:01 -0400
Content-Disposition: inline
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Jarkko Nikula <jarkko.nikula@nokia.com> [081029 04:37]:
> This set continues OMAP gpio call clean-up started by David Brownell and
> is generated on top of his rebased set.
> 
> First patch is the important one here and remaining set gradually
> convert omap_request_gpio and omap_free_gpio calls to use gpiolib
> gpio_request and gpio_free calls with hopefully sensible name label.
> 
> Probably bit overkill size set but wanted to separate them some sort of
> logical way for easier mainline merge. I can combine them if needed.
> 
> Build and boot tested only on N810. Will do test builds later on as well but
> wanted to get some early comments as early as possible :-)

Great. One request though:

Let's do the clean-up patches in two phases, one series that
applies against the mainline kernel, then additional patches for
linux-omap. Otherwise we'll never get out of this merge hell.

BTW, we should try to do the same for anything that we can already
patch in the mainline kernel.

Regards,

Tony
