From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes against v3.16-rc4
Date: Thu, 10 Jul 2014 23:30:02 -0700
Message-ID: <20140711063002.GI28884@atomide.com>
References: <20140709153552.GA28884@atomide.com>
 <20140710213554.GA1313@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43618 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752172AbaGKGaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jul 2014 02:30:05 -0400
Content-Disposition: inline
In-Reply-To: <20140710213554.GA1313@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [140710 14:37]:
> On Wed, Jul 09, 2014 at 08:35:52AM -0700, Tony Lindgren wrote:
> > The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:
> > 
> >   Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/fixes-rc4
> > 
> > for you to fetch changes up to 1d29a0722f6c38f79785c9ffb911730598de84e2:
> > 
> >   ARM: OMAP2+: Remove non working OMAP HDMI audio initialization (2014-07-08 01:08:44 -0700)
> > 
> > ----------------------------------------------------------------
> > Fixes for omaps for the -rc series. It's mostly fixes for clock rates,
> > restart handling and phy regulators and SATA interconnect data.
> 
> It's a little surprising to see a SATA fix about a week after enablement
> went in during -rc -- enabling it that late should ideally have been
> better tested than this.

Yes sorry we are having a bit hard time getting things coordinated with
driver + dts + hwmod changes. Ideally the hwmod changes for the interconnect
would be all done when adding support for a new SoC instead of adding
them one driver at a time. And those should be eventually just device
tree properties.
 
> > Also few build fixes related to the DSP driver in staging, and trivial
> > stuff like removal of broken and soon to be unused platform data init
> > for HDMI audio that would be good to get into the -rc series if not
> > too late.
> 
> Thanks, merged. Definitely time for regressions only from here on out though.

Yes agreed. So far I'm not aware of any major regressions for the first
time for a few merge cycles.

Regards,

Tony
