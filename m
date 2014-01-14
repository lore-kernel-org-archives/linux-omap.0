From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 3/4] trivial omap big endian changes for v3.14 merge
 window
Date: Tue, 14 Jan 2014 14:33:27 -0800
Message-ID: <20140114223326.GD18512@atomide.com>
References: <20140109011940.GI31323@atomide.com>
 <20140109012139.GK31323@atomide.com>
 <871u0a6vqf.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62749 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaANWdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2014 17:33:33 -0500
Content-Disposition: inline
In-Reply-To: <871u0a6vqf.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@linaro.org> [140114 14:33]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:
> >
> >   Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/be-signed
> >
> > for you to fetch changes up to fc6ca98c81bf0ea8b46064915b5947b971594101:
> >
> >   ARM: OMAP: debug-leds: raw read and write endian fix (2014-01-07 16:09:45 -0800)
> >
> > ----------------------------------------------------------------
> > Trivial search and replace of read and write functions to allow
> > further patches to make omaps work also in big endian mode.
> >
> > ----------------------------------------------------------------
> 
> I think this one should wait for v3.15.  While a trivial rename, it's a
> pretty broad change and risks having conflicts and fallouts with other
> changes (thinking especially of ongoing clock changes.)

Sure no problem.

Tony
