From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 5/8] ARM: OMAP: hwmod: Add support for per
 hwmod/module context lost count
Date: Wed, 30 May 2012 11:02:24 +0300
Message-ID: <1338364944.8834.104.camel@sokoban>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
	 <1336989796-26594-6-git-send-email-t-kristo@ti.com>
	 <CAOMWX4eKp+JymSNyapRJ3+u=Q1U-yMyFS5M6KUe7pOgOYyt6Ug@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54639 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521Ab2E3ICc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 04:02:32 -0400
In-Reply-To: <CAOMWX4eKp+JymSNyapRJ3+u=Q1U-yMyFS5M6KUe7pOgOYyt6Ug@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Tue, 2012-05-29 at 14:32 -0500, Menon, Nishanth wrote:
> On Mon, May 14, 2012 at 5:03 AM, Tero Kristo <t-kristo@ti.com> wrote:
> [...]
> > +/**
> >  * _enable - enable an omap_hwmod
> >  * @oh: struct omap_hwmod *
> >  *
> > @@ -1599,6 +1629,8 @@ static int _enable(struct omap_hwmod *oh)
> >        _enable_clocks(oh);
> >        _enable_module(oh);
> >
> > +       _omap4_update_context_lost(oh);
> > +
> >        r = _wait_target_ready(oh);
> >        if (!r) {
> >                /*
> 
> Dumb q: Since we monitor the count around _enable, how do we ensure
> that context loss counter is accurate
> around OFF and idle transitions for domains that could have been
> hwauto? it might be good to have limitations
> in the $commit_message if it is not targeted to do so.

True, I can add a comment to the commit msg about this.

-Tero

