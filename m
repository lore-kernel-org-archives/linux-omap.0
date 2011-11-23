From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for v3.2-rc2
Date: Wed, 23 Nov 2011 21:15:40 +0000
Message-ID: <201111232115.41035.arnd@arndb.de>
References: <20111119194408.GD31337@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61778 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab1KWVPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 16:15:43 -0500
In-Reply-To: <20111119194408.GD31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Saturday 19 November 2011, Tony Lindgren wrote:
> Please pull omap fixes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> 
> Most of this pull request are fixes needed by Tomi for the
> display driver clocking.
> 

Hi Tony,

Sorry for the delay on my side, I've only today looked at this series.
The patches all look ok, as far as I can tell, but please rebase
the series to make it easier to see what is going on:

* At least one of the sub-branches is based on a random commit on
  Linus' tree. Please always base patches on an -rc for consistency!

* Out of the 20 patches, not one is marked for 'stable' backports.
  I really want to make sure this time that all long-standing bugs
  get fixed in stable releases, so please go through the list and
  add 'Cc: stable@kernel.org' to the ones you want to have backported.
  If all patches are actually addressing regressions, just tell me
  in the introductory mail next time.

* Since a lot of patches address the dss, it would be nice to have
  a separate pull request for those. It's not really important, but
  I feel that it's easier to review stuff that is less mixed and
  splitting them out should be easy if you rebase the series anyway.

Thanks for your patience,

	Arnd
