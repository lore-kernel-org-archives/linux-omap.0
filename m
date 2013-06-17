From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/6] omap cleanup for v3.11 merge window
Date: Mon, 17 Jun 2013 03:33:42 -0700
Message-ID: <20130617103342.GL20992@atomide.com>
References: <pull-1371061475-206272>
 <51b8bce9.1265310a.49c1.ffff940eSMTPIN_ADDED_MISSING@mx.google.com>
 <20130614212815.GB17326@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64288 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932409Ab3FQKdr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 06:33:47 -0400
Content-Disposition: inline
In-Reply-To: <20130614212815.GB17326@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [130614 14:34]:
> On Wed, Jun 12, 2013 at 11:24:33AM -0700, Tony Lindgren wrote:
> > The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> > 
> >   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/cleanup-signed
> > 
> > for you to fetch changes up to 09182ab11b49b67d04598b19eb89cf0bbd672a60:
> > 
> >   ARM: OMAP4: hwmod data: Remove irq entries from mcspi, mmc hwmods (2013-06-12 09:41:46 -0700)
> > 
> > ----------------------------------------------------------------
> > Move omap4 over to device tree based booting. This allows us to get rid
> > a big pile of platform init code for things that are already handled by
> > device tree related code. As am33xx is already device tree based, we
> > can also remove the same data for am33xx.
> 
> Hm. This one has a somewhat silly conflict with the am33xx hwmod fix for uart2.
> I.e. the fix is reverted since the code is no longer needed -- data comes from
> device tree. Please double-check my merge resolution on it though.

Thanks yes that should not be needed any longer in the hwmod data.

Regards,

Tony
