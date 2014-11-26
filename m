From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 26 Nov 2014 18:28:57 +0100
Message-ID: <20141126172857.GA26157@amd>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38704 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbaKZR27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 12:28:59 -0500
Content-Disposition: inline
In-Reply-To: <20141027230138.GB7805@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, pali.rohar@gmail.com

On Tue 2014-10-28 01:01:38, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> > +
> > +	if (!of_have_populated_dt())
> > +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> > +
> 
> Maybe use WARN so that the warning is more verbose and kernel gets tainted?

Well.. Pali still has regression where /proc/cpuinfo changes in a way
that breaks existing userspace, when dt is used on N900.

And rmk was less then helpfull...

Should we maybe solve that before adding backtraces to our boot
messages?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
