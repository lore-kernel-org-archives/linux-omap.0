From: Tony Lindgren <tony@atomide.com>
Subject: Re: kexec on Nokia Internet Tablets
Date: Tue, 17 Feb 2009 13:46:12 -0800
Message-ID: <20090217214612.GB11928@atomide.com>
References: <20090217213228.GH24800@guug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58240 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZBQVqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 16:46:16 -0500
Content-Disposition: inline
In-Reply-To: <20090217213228.GH24800@guug.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Otto Solares <solca@guug.org>
Cc: linux-omap@vger.kernel.org

* Otto Solares <solca@guug.org> [090217 13:37]:
> Hi all!
> 
> I want to make kexec work on current Nokia Internet Tablets but
> maybe someone here have a clue or better if a patch :)

Do you need to patch anything for this, or does it work out of the box?

> When I run a kexec enabled linux-omap kernel and try to boot the
> production Maemo kernel or a linux-omap kernel I only succeed if
> the serial-console flag in r&d mode is set, if not the device
> just hangs.

Sounds like something does not get correctly initialized..

> It seems as a timing problem because if I insert small delays to
> the kexeced kernel via CONFIG_BOOT_PRINTK_DELAY it works too 
> without the serial-console flag set.
> 
> Any idea what to debug or where to start?

Well since the LCD is on, you could write a little function that
writes the output to the LCD. You just need to find out the virtual
address of the LCD and then add a function for displaying fonts..
Pretty easy to do.

BTW, do you have some Maemo package for kexec?

Tony
