From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: OMAP: SX1: remove check for CONFIG_SX1_OLD_FLASH
Date: Thu, 29 May 2014 21:02:27 +0200
Message-ID: <20140529190227.GB18230@amd.pavel.ucw.cz>
References: <1400182902.11786.21.camel@x220>
 <20140516211231.GF12881@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57878 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbaE2TC3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2014 15:02:29 -0400
Content-Disposition: inline
In-Reply-To: <20140516211231.GF12881@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Fri 2014-05-16 14:12:31, Tony Lindgren wrote:
> * Paul Bolle <pebolle@tiscali.nl> [140515 12:42]:
> > A check for CONFIG_SX1_OLD_FLASH was added in v2.6.24. But the related
> > Kconfig symbol was never part of the tree. So we can remove some dead
> > code.
> 
> Thanks applying into omap-for-v3.16/board.

Actually... It seems there are two variant of SX1, and this is very
useful piece of documentation how the _other_ variant looks.

And if someone is hacking linux on sx1, he can probably figure out
#ifdef in .c file...

IOW adding the config option might be better solution.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
