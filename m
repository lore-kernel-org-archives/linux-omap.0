From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated to v2.6.27-rc2, help needed
Date: Wed, 13 Aug 2008 10:48:42 +0300
Message-ID: <20080813074841.GD14224@atomide.com>
References: <20080811152620.GO25784@atomide.com> <20080812101332.a321e783.jarkko.nikula@nokia.com> <20080812114446.GG6705@atomide.com> <20080812143119.GL6705@atomide.com> <20080813104237.6b704dd4.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52966 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbYHMHqa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Aug 2008 03:46:30 -0400
Content-Disposition: inline
In-Reply-To: <20080813104237.6b704dd4.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Eduardo Valentin <edubezval@gmail.com>

* Jarkko Nikula <jarkko.nikula@nokia.com> [080813 10:44]:
> On Tue, 12 Aug 2008 17:31:20 +0300
> "ext Tony Lindgren" <tony@atomide.com> wrote:
> 
> > > > > - Alignment error on omap2/3. This seems to happen also with
> > > > >   718fc6cd4db902aa2242a736cc3feb8744a4c71a reverted?
> > > > > 
> > > > - N800 boots up to UI with "gcc version 3.4.4 (release)
> > > > (CodeSourcery ARM 2005q3-2" and with DEBUG_LL=y. Without DEBUG_LL
> > > > it hangs somewhere before serial is initialized
> > > > 
> > > > - With "gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite
> > > > 2007q3-53)" there is alignment exception in early booting
> > > > independently of 718fc6cd4db902aa2242a736cc3feb8744a4c71a
> > > 
> > > Weird that this alignment exception only happens on 24xx, not on
> > > 34xx.
> > 
> > For me reverting 0e5194e1a84c219bebbb78f305b7a8eabc4a3656 fixes this.
> > Reverting 718fc6cd4db902aa2242a736cc3feb8744a4c71a like Felipe
> > mentioned does not help for me with gcc version 4.2.3 (Sourcery G++
> > Lite 2008q1-126).
> > 
> I reverted the 0e5194e1a84c219bebbb78f305b7a8eabc4a3656 and now it
> boots with gcc 4.2.1 but only if DEBUG_LL=y. With gcc 3.4.4 there is no
> difference. Looks like that alignment is one issue and DEBUG_LL is
> another?

Does it behave the same way with Paul's patches?

Tony
