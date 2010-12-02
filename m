From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] FOR TESTING ONLY
Date: Thu, 2 Dec 2010 14:27:36 -0800
Message-ID: <20101202222736.GZ17222@atomide.com>
References: <20101202114805.GT5429@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64939 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab0LBW1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 17:27:45 -0500
Content-Disposition: inline
In-Reply-To: <20101202114805.GT5429@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

* Felipe Balbi <balbi@ti.com> [101202 03:38]:
> Hi Tony,
> 
> I have a gigantic amount of patches on musb starting to move it to a
> place where we can build am35x.c, omap2430.c and tusb6010.c together and
> have a working binary.
> 
> There are a few changes still needed (as per comments Mike's comments on
> linux-usb) but it's working fine on my pandaboard. Mike's comments are
> mostly cosmetic (appending _musb suffix to function names and adding
> const to a struct, for example).
> 
> If you could merge them into linux-omap so we can put the hwmod and
> pm_runtime patches on top, I'd be glad.
> 
> Keep in mind that branch still might get rebased, so get ready to merge
> -s ours :-p

Great, yeah I'll merge them into linux-omap master branch for testing
probably later on today.

Tony
