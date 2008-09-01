From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 17/33] add tea5761 radio driver
Date: Mon, 1 Sep 2008 10:59:38 +0300
Message-ID: <20080901075937.GU9887@frodo>
References: <1220116593-862-10-git-send-email-me@felipebalbi.com> <1220116593-862-11-git-send-email-me@felipebalbi.com> <1220116593-862-12-git-send-email-me@felipebalbi.com> <1220116593-862-13-git-send-email-me@felipebalbi.com> <1220116593-862-14-git-send-email-me@felipebalbi.com> <1220116593-862-15-git-send-email-me@felipebalbi.com> <1220116593-862-16-git-send-email-me@felipebalbi.com> <1220116593-862-17-git-send-email-me@felipebalbi.com> <1220116593-862-18-git-send-email-me@felipebalbi.com> <20080901102431.b7bc647e.jarkko.nikula@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38585 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbYIAH7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 03:59:45 -0400
Content-Disposition: inline
In-Reply-To: <20080901102431.b7bc647e.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

On Mon, Sep 01, 2008 at 10:24:31AM +0300, Jarkko Nikula wrote:
> On Sat, 30 Aug 2008 20:16:17 +0300
> "ext Felipe Balbi" <me@felipebalbi.com> wrote:
> 
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> > 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  drivers/media/radio/Kconfig         |   13 +
> >  drivers/media/radio/Makefile        |    1 +
> >  drivers/media/radio/radio-tea5761.c |  517 ++++++++++++++++++++++++++
> > +++++++++ 3 files changed, 531 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/media/radio/radio-tea5761.c
> > 
> I have the impression that Eduardo Valentin had work in progress to
> push this via v4l list. However, don't know the current status.

Better asking. Eduardo, were you planning to push this one upstream ?

-- 
balbi
