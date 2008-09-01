From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 28/33] add tsc2301 driver
Date: Mon, 1 Sep 2008 11:37:33 +0300
Message-ID: <20080901083732.GY9887@frodo>
References: <1220116593-862-23-git-send-email-me@felipebalbi.com> <1220116593-862-24-git-send-email-me@felipebalbi.com> <1220116593-862-25-git-send-email-me@felipebalbi.com> <1220116593-862-26-git-send-email-me@felipebalbi.com> <1220116593-862-27-git-send-email-me@felipebalbi.com> <1220116593-862-28-git-send-email-me@felipebalbi.com> <1220116593-862-29-git-send-email-me@felipebalbi.com> <20080901103512.bc42d187.jarkko.nikula@nokia.com> <20080901075806.GT9887@frodo> <20080901111107.541c3471.jarkko.nikula@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59498 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbYIAIhj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 04:37:39 -0400
Content-Disposition: inline
In-Reply-To: <20080901111107.541c3471.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Mon, Sep 01, 2008 at 11:11:07AM +0300, Jarkko Nikula wrote:
> On Mon, 1 Sep 2008 10:58:08 +0300
> "ext Felipe Balbi" <me@felipebalbi.com> wrote:
> 
> > > Mixer driver here is also obsolete and used by N800 only. I think
> > > TSC2003 driver is easier to handle by trying to push only core,
> > > keyboard and ts part first. There is no place for mixer driver until
> > > it's ported to ASoC codec driver.
> > 
> > Cool, I'll drop this one as well. Will you take care of moving it to
> > ASoC ?
> > 
> Unfortunately I have very low priority for it :-(

damn it... someone else interested could take a look at it. Let's hope
someone really does ;-)

It'd be great to get rid of all these drivers from linux-omap and get in
sync with mainline, then upcoming drivers could be discussed on proper
mailing lists :-)

-- 
balbi
