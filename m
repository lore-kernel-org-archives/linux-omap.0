From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [GIT PULL] ARM: OMAP: IRQ domain support for INTC
Date: Mon, 5 Mar 2012 16:03:51 +0100
Message-ID: <20120305150351.GB2108@localhost>
References: <4F4BB0FB.3040308@ti.com>
 <20120228234837.GH18901@atomide.com>
 <4F4E4F1D.7020109@ti.com>
 <20120305135838.GA2108@localhost>
 <4F54CCBD.2080802@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33931 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932150Ab2CEPDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 10:03:54 -0500
Received: by lahj13 with SMTP id j13so4740811lah.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 07:03:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F54CCBD.2080802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

On Mon, Mar 05, 2012 at 03:25:01PM +0100, Cousson, Benoit wrote:
> On 3/5/2012 2:58 PM, Johan Hovold wrote:
> > On Wed, Feb 29, 2012 at 05:15:25PM +0100, Cousson, Benoit wrote:
> >> On 2/29/2012 12:48 AM, Tony Lindgren wrote:
> >>> * Cousson, Benoit<b-cousson@ti.com>   [120227 08:04]:
> >>> Hmm, looks like this now produces the following warning at least on omap3:
> >>
> >> Yes, Rajendra has just reported that issue with linux-next.
> >
> > I'm getting the same warning and initialisation failure with 3.3-rc6 on
> > overo. Are these fixes queued up for 3.3 (and not just 3.4) somewhere?
> 
> It is under review, I posted the series last Friday:
> mfd: twl: Fix for irqdomain/next + SPARSE_IRQ + MMC card detect
> 
> It will be anyway material for 3.4 since it is in linux-next.

Yes, I noted that there was a fix against linux-next. My question was
whether any fix is planned for 3.3 as twl4030 is broken with SPARSE_IRQ
enabled.

Disabling SPARSE_IRQ will be the only workaround until 3.4 is out then?

Thanks,
Johan
