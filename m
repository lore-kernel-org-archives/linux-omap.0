From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Wed, 21 Sep 2011 17:52:53 -0700
Message-ID: <20110922005252.GM2937@atomide.com>
References: <20110917014623.GC2937@atomide.com>
 <201109202346.11393.arnd@arndb.de>
 <20110920223311.GK2937@atomide.com>
 <1836081.h7sKlomlak@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59722 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751051Ab1IVAw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 20:52:57 -0400
Content-Disposition: inline
In-Reply-To: <1836081.h7sKlomlak@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [110920 23:34]:
> On Tuesday 20 September 2011 15:33:12 Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [110920 14:12]:
> > > On Tuesday 20 September 2011, Arnd Bergmann wrote:
> > > > 
> > > > One more thing: my randconfig tests are running now and
> > > > have spit out a new error after merging lost of stuff
> > > > today:
> > 
> > Good to hear you got "arndconfig" running :)
> > 
> > Do you think we could also add support for something
> > like this:
> > 
> > $ echo CONFIG_ARCH_OMAP=y > .config
> > $ make randconfig
> > 
> > or
> > 
> > $ make --force=CONFIG_ARCH_OMAP randconfig
> > 
> > Where randconfig would keep the forced CONFIG_ARCH_OMAP
> > static while randomly selecting the others?
> > 
> > This would allow targeted randconfig for each patch more
> > or less..
> 
> The mechanism I use is setting KCONFIG_ALLCONFIG= to a file
> that has the options I want to have set to a specific value.
> 
> If you don't do that, randconfig will take the default option
> for each 'choice' statement, which means we build for the
> ARCH_VERSATILE platform.
> 
> See the script I'm using at the end of this mail. It should
> be easy for you to pick out the parts you need.

Thanks will take a look at that for sure.

Tony
