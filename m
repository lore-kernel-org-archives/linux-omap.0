From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Nokia Internet Tablets
Date: Mon, 22 Dec 2008 14:27:57 +0200
Message-ID: <20081222122757.GI7125@gandalf.research.nokia.com>
References: <20081222103422.GL29448@guug.org>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19182 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbYLVM2z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2008 07:28:55 -0500
Content-Disposition: inline
In-Reply-To: <20081222103422.GL29448@guug.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Otto Solares <solca@guug.org>
Cc: linux-omap@vger.kernel.org

On Mon, Dec 22, 2008 at 04:34:22AM -0600, ext Otto Solares wrote:
> Hi all!
> 
> I want to resurrect missing support for the Nokia Internet Tablets
> starting with the N8x0s for my NITdroid project, which uses just
> standard Linux kernel APIs.
> 
> So first I would like to ask some very newbie questions:
> 
> -Is there any ongoing effort to support these devices in latest kernels
>  at the same level as the latest Nokia production kernel (2.6.21-omap)?

n8x0 devices should boot fine with current linux-omap and I'd say we
have all the drivers here as well, besides audio, camera and wifi (me thinks)

> -I don't plan to suspend but just sleep while idling, is this a good
>  approach to power management (pm)?

That's broken afaict.

> -I read about the pm branch, where can I pull it?

from linux-omap git.

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git pm

should do it

> -Same for the camera drivers, why it was removed and what is required
>  to port it back?

get the patch out of linux-omap and send it through v4l2 maintainer.

> -AFAIK the recent removals of the N800 sound driver was because it was
>  not written for ALSA OMAP SoC API, right?

yes.

> -Can the retu RTC be ported to the CONFIG_RTC_CLASS API?
> 
> -Are the CONFIG_REGULATOR and CONFIG_POWER_SUPPLY APIs of any use for
>  the Internet Tablets?

hmm... it could be used for charging but it won't work unless you get
documentation of the charging chips used on n8x0. Also, you'd need to
change BME I suppose, which you can't :-s

> If it is lack of time of the original developers, I would like to step
> in, willing to try to complete this work as long as you are willing to
> support me with answers to my newbie questions as this devices are in
> plenty operation today but the Nokia kernel is getting really old and
> it's a good thing if we can port all the drivers to standard Linux API.

Sure, I totally agree with you. If I had more time I'd help cleaning up
some of the old drivers and send them upstream myself, but unfortunately
I don't.

If you wanna hack, go for it.

-- 
balbi
