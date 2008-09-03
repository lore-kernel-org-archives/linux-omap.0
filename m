From: Eduardo Valentin <eduardo.valentin@indt.org.br>
Subject: Re: [PATCH 17/33] add tea5761 radio driver
Date: Wed, 3 Sep 2008 11:01:21 -0400
Message-ID: <20080903150121.GA28711@knuth>
References: <1220116593-862-11-git-send-email-me@felipebalbi.com> <1220116593-862-12-git-send-email-me@felipebalbi.com> <1220116593-862-13-git-send-email-me@felipebalbi.com> <1220116593-862-14-git-send-email-me@felipebalbi.com> <1220116593-862-15-git-send-email-me@felipebalbi.com> <1220116593-862-16-git-send-email-me@felipebalbi.com> <1220116593-862-17-git-send-email-me@felipebalbi.com> <1220116593-862-18-git-send-email-me@felipebalbi.com> <20080901102431.b7bc647e.jarkko.nikula@nokia.com> <20080901075937.GU9887@frodo>
Reply-To: eduardo.valentin@indt.org.br
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64315 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbYICPBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 11:01:20 -0400
Content-Disposition: inline
In-Reply-To: <20080901075937.GU9887@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi guys,

Sorry for the late answer.

On Mon, Sep 01, 2008 at 10:59:38AM +0300, ext Felipe Balbi wrote:
> On Mon, Sep 01, 2008 at 10:24:31AM +0300, Jarkko Nikula wrote:
> > On Sat, 30 Aug 2008 20:16:17 +0300
> > "ext Felipe Balbi" <me@felipebalbi.com> wrote:
> > 
> > > From: Felipe Balbi <felipe.balbi@nokia.com>
> > > 
> > > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > > ---
> > >  drivers/media/radio/Kconfig         |   13 +
> > >  drivers/media/radio/Makefile        |    1 +
> > >  drivers/media/radio/radio-tea5761.c |  517 ++++++++++++++++++++++++++
> > > +++++++++ 3 files changed, 531 insertions(+), 0 deletions(-)
> > >  create mode 100644 drivers/media/radio/radio-tea5761.c
> > > 
> > I have the impression that Eduardo Valentin had work in progress to
> > push this via v4l list. However, don't know the current status.

Yes, that's true. I tried pushing this through v4l list.
But it got blocked. It seams there is duplicated code here.
v4l already has a radio interface for tea. However, it is
based on radio tuner api.

The work here is to update our driver to use current code
already in v4l2. Just a simple patch to remove duplicated code
and adapt to use correct API.

> 
> Better asking. Eduardo, were you planning to push this one upstream ?
> 
> -- 
> balbi

-- 

BR,

---
Eduardo Bezerra Valentin
+55 92 21261118
