From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [alsa-devel] [PATCHv3 3/4] Add ASoC support for DevKit8000
Date: Thu, 11 Feb 2010 13:14:18 +0200
Message-ID: <20100211131418.9521c603.jhnikula@gmail.com>
References: <1265829784-19224-1-git-send-email-swirl@gmx.li>
	<1265882112.3179.1.camel@odin>
	<20100211124022.ec6573dc.jhnikula@gmail.com>
	<1265885388.3179.8.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:1281 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab0BKLJw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 06:09:52 -0500
Received: by ey-out-2122.google.com with SMTP id d26so300102eyd.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Feb 2010 03:09:51 -0800 (PST)
In-Reply-To: <1265885388.3179.8.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, weber@corscience.de, Thomas Weber <swirl@gmx.li>, Tomi.Valkeinen@nokia.com, tony@atomride.com, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

On Thu, 11 Feb 2010 10:49:48 +0000
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> I do agree this makes good sense for boards that are very similar and
> have different audio options/config, but in this case the ASoC mach
> drivers are identical (atm). Imo it just makes more sense to keep the
> one Kconfig.
> 
Yeah, after thinking twice, we don't have zillions of options for e.g.
Intel HDA either. If we ever figure out some common OMAP+TWL4030
driver, the defconfigs are anyway have to modify so it's better stay
with the original patch:

http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025129.html

Sorry about line noise, Thomas :-)

-- 
Jarkko
