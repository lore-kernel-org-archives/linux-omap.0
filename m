From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v3.2-rc2
Date: Wed, 23 Nov 2011 14:03:58 -0800
Message-ID: <20111123220358.GI31337@atomide.com>
References: <20111119194408.GD31337@atomide.com>
 <201111232115.41035.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33759 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753348Ab1KWWED (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 17:04:03 -0500
Content-Disposition: inline
In-Reply-To: <201111232115.41035.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>, "Cousson, Benoit" <b-cousson@ti.com>

* Arnd Bergmann <arnd@arndb.de> [111123 12:40]:
> On Saturday 19 November 2011, Tony Lindgren wrote:
> > Please pull omap fixes from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> > 
> > Most of this pull request are fixes needed by Tomi for the
> > display driver clocking.
> > 
> 
> Hi Tony,
> 
> Sorry for the delay on my side, I've only today looked at this series.
> The patches all look ok, as far as I can tell, but please rebase
> the series to make it easier to see what is going on:
> 
> * At least one of the sub-branches is based on a random commit on
>   Linus' tree. Please always base patches on an -rc for consistency!

Yes sorry I made the same comment earlier to Benoit. That one patch
is certainly based on a random commit.. Will cherry pick that one.

The earlier patches are based on the earlier fixes (while waiting
for them to get merged). So that's certainly not a random commit.
Or at least was not at that time :) I can rebase those too anyways
now that the earlier fixes are merged.
 
> * Out of the 20 patches, not one is marked for 'stable' backports.
>   I really want to make sure this time that all long-standing bugs
>   get fixed in stable releases, so please go through the list and
>   add 'Cc: stable@kernel.org' to the ones you want to have backported.
>   If all patches are actually addressing regressions, just tell me
>   in the introductory mail next time.

It's mostly regressions and fixes on new features merged during
the merge window. But looks like there's at least one patch that
might make sense for stable too, will check them all.
 
> * Since a lot of patches address the dss, it would be nice to have
>   a separate pull request for those. It's not really important, but
>   I feel that it's easier to review stuff that is less mixed and
>   splitting them out should be easy if you rebase the series anyway.

OK will place those into fixes-dss branch.

Cheers,

Tony 
