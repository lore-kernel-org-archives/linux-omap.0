From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap dss board clean-up for v3.10 merge window
Date: Fri, 19 Apr 2013 11:45:18 -0700
Message-ID: <20130419184518.GA30836@quad.lixom.net>
References: <20130418033936.GC10155@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:57849 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab3DSSpP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 14:45:15 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa11so2418854pad.27
        for <linux-omap@vger.kernel.org>; Fri, 19 Apr 2013 11:45:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130418033936.GC10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

On Wed, Apr 17, 2013 at 08:39:37PM -0700, Tony Lindgren wrote:
> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> 
>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/dss-signed


Merged, but not happy about it.

As mentioned on IRC, I was going to let this one be until 3.11, but it sounds
like it will cause regressions in DSS if we don't merge it.

This is an indication that the work wasn't done right on the DSS rework.
Ideally the old configurations through platform_data should have been left in
for a release to give the boards a window to convert over without regressing
functionality. Tomi, please don't do it this way in the future since it's
painful for everybody to deal with.

I've queued this with late/cleanup. I noticed some conflicts with the previous
omap/fixes-non-critical and omap/boards branches that I brought in as a base so
I could fix it up in my merge instead of having it go all the way up to Linus
to resolve.


-Olof
