From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap twl platform init changes for v3.9 merge window
Date: Sat, 9 Feb 2013 18:42:28 -0800
Message-ID: <20130210024228.GA4801@atomide.com>
References: <20130206172500.GA25185@atomide.com>
 <20130210005824.GJ16278@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48600 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760952Ab3BJCmg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 21:42:36 -0500
Content-Disposition: inline
In-Reply-To: <20130210005824.GJ16278@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [130209 17:01]:
> On Wed, Feb 06, 2013 at 09:25:00AM -0800, Tony Lindgren wrote:
> > The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:
> > 
> >   Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/twl-signed-v2
> 
> <standard complaint>
> It would be nice to see TI enabling device-tree on these platforms/drivers
> instead of adding to legacy board files.
> </standard complaint>

I believe it already has at least for audio, but we cannot yet drop
the legacy support. Currently am33xx is DT only, omap4 is pretty close
to be flipped over to be DT only.
 
> Pulled into next/boards.

Thanks,

Tony
