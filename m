From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/2 rev2] McBSP and ASoC OMAP update patches for 2430 and
	34xx
Date: Mon, 8 Sep 2008 17:48:58 -0700
Message-ID: <20080909004858.GJ29054@atomide.com>
References: <20080905165641.GI24202@atomide.com> <1220869784-16607-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58541 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbYIIAtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 20:49:01 -0400
Content-Disposition: inline
In-Reply-To: <1220869784-16607-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080908 03:30]:
> Here is second version of patch adding support for 2430 in McBSP driver.
> Updated version uses phys_base instead of virt_base. See following commits from Russell King:
> 
> ecec3b3e080464cc1b4e792cf4d8e7e89d50b011
> 2cfd6fcda3b8c6ee7a5fa9a4573e3246532a0716
> 
> Second patch is the same than first version. It's for testing ASoC OMAP
> and eventually it will go through the alsa-devel.

Thanks, pushing these to l-o tree.

Tony
