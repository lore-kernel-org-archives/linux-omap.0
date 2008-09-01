From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 28/33] add tsc2301 driver
Date: Mon, 1 Sep 2008 10:58:08 +0300
Message-ID: <20080901075806.GT9887@frodo>
References: <1220116593-862-21-git-send-email-me@felipebalbi.com> <1220116593-862-22-git-send-email-me@felipebalbi.com> <1220116593-862-23-git-send-email-me@felipebalbi.com> <1220116593-862-24-git-send-email-me@felipebalbi.com> <1220116593-862-25-git-send-email-me@felipebalbi.com> <1220116593-862-26-git-send-email-me@felipebalbi.com> <1220116593-862-27-git-send-email-me@felipebalbi.com> <1220116593-862-28-git-send-email-me@felipebalbi.com> <1220116593-862-29-git-send-email-me@felipebalbi.com> <20080901103512.bc42d187.jarkko.nikula@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38486 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYIAH6x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 03:58:53 -0400
Content-Disposition: inline
In-Reply-To: <20080901103512.bc42d187.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Mon, Sep 01, 2008 at 10:35:12AM +0300, Jarkko Nikula wrote:
> On Sat, 30 Aug 2008 20:16:28 +0300
> "ext Felipe Balbi" <me@felipebalbi.com> wrote:
> 
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  drivers/spi/Kconfig         |   22 +
> >  drivers/spi/Makefile        |    3 +
> >  drivers/spi/tsc2301-core.c  |  301 +++++++++++++
> >  drivers/spi/tsc2301-mixer.c | 1004 ++++++++++++++++++++++++++++++++++
> > +++++++++ 4 files changed, 1330 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/spi/tsc2301-core.c
> >  create mode 100644 drivers/spi/tsc2301-mixer.c
> > 
> Mixer driver here is also obsolete and used by N800 only. I think
> TSC2003 driver is easier to handle by trying to push only core,
> keyboard and ts part first. There is no place for mixer driver until
> it's ported to ASoC codec driver.

Cool, I'll drop this one as well. Will you take care of moving it to
ASoC ?

-- 
balbi
