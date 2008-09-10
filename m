From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] This patch fixes the typo which breaks the build on
	OMAP1
Date: Wed, 10 Sep 2008 10:40:25 -0700
Message-ID: <20080910174024.GB21163@atomide.com>
References: <dfeb90390809090040r59b401eciafb005f7d31cd398@mail.gmail.com> <20080910101842.1cd49bb6.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49223 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbYIJRke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 13:40:34 -0400
Content-Disposition: inline
In-Reply-To: <20080910101842.1cd49bb6.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Arun KS <arunks@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Jarkko Nikula <jarkko.nikula@nokia.com> [080910 00:19]:
> On Tue, 9 Sep 2008 13:10:59 +0530
> "ext Arun KS" <arunks@mistralsolutions.com> wrote:
> 
> > diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> > index a217cf2..3a4cc4b 100644
> > --- a/sound/soc/omap/omap-mcbsp.c
> > +++ b/sound/soc/omap/omap-mcbsp.c
> > @@ -96,7 +96,7 @@ static const int omap24xx_dma_reqs[][2] = {
> >  #endif
> >  };
> >  #else
> > -static const int omap2420_dma_reqs[][2] = {};
> > +static const int omap24xx_dma_reqs[][2] = {};
> >  #endif
> > 
> Thanks, this is true. Is it ok if I add this fix directly in my
> original patch when I have chance to send it to alsa-devel?

Pushing today to l-o tree.

Tony
