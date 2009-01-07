From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] legacy gpio phaseout (V) ...
Date: Wed, 7 Jan 2009 17:56:34 +0200
Message-ID: <20090107155633.GT27566@atomide.com>
References: <1228289844-5897-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58188 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZAGP4g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 10:56:36 -0500
Content-Disposition: inline
In-Reply-To: <1228289844-5897-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [081203 09:38]:
> Hi
> 
> With these two patches gpiolib conversion in mainline is almost complete when
> applied on top of Tony's Omap gpio update set for 2.6.29. Only board-apollon.c
> is remain in mainline but it is differentiated quite much from linux-omap so
> I'm going to send my next set against linux-omap only.
> 
> Note, these versions don't change mach/gpio.h include statement to
> linux/gpio.h due merge conflicts in mainline. SX1 seems to lack some
> gpio-swich related patch and omap2 onenand is getting some include fixes
> from mtd tree.

I've finally pushed these as one patch and also removed the remaining
calls. Also on their way to mainline hopefully within next few days.

Regards,

Tony
