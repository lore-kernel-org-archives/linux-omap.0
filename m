From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] non-critical omap fixes for v3.12 merge window
Date: Thu, 29 Aug 2013 19:11:42 -0700
Message-ID: <20130830021142.GA2579@quad.lixom.net>
References: <20130823054609.GW7656@atomide.com>
 <20130828185045.GI8607@quad.lixom.net>
 <20130829053705.GL7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:52394 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3H3CMW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 22:12:22 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so1214027pdj.30
        for <linux-omap@vger.kernel.org>; Thu, 29 Aug 2013 19:12:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130829053705.GL7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Matus Ujhelyi <ujhelyi.m@gmail.com>

On Wed, Aug 28, 2013 at 10:37:06PM -0700, Tony Lindgren wrote:
> * Olof Johansson <olof@lixom.net> [130828 11:58]:
> > On Thu, Aug 22, 2013 at 10:46:10PM -0700, Tony Lindgren wrote:
> > 
> > > Matus Ujhelyi (1):
> > >       ARM: OMAP2+: am33xx-restart: trigger warm reset on omap2+ boards
> > 
> > Sigh. am33xx has been a bit of a pain this release cycle. Can you please
> > start double-checking builds when you apply am33xx stuff? :(
> > 
> > This breaks with:
> > 
> >         multi_v7_defconfig:
> > arch/arm/mach-omap2/am33xx-restart.c:27:26: error: 'AM33XX_RST_GLOBAL_WARM_SW_MASK' undeclared (first use in this function)
> > 
> >         omap2plus_defconfig:
> > arch/arm/mach-omap2/am33xx-restart.c:27:26: error: 'AM33XX_RST_GLOBAL_WARM_SW_MASK' undeclared (first use in this function)
> 
> Oops sorry, I see what's going on. It builds fine against v3.11-rc6, but
> has a dependency for v3.12 for the cleanup branch that removed all the
> unused defines. 
>  
> > I've unmerged the branch until that's resolved.
> 
> Care to apply the following fix to the cleanup branch?
> 
> This way this fixes branch keeps working both against v3.11 and the
> patches queued for v3.12.

Ah, yeah. Applied. And fixes branch pulled, since we'd otherwise just get most
of them during 3.12-rc. :)


-Olof
