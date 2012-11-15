From: Tony Lindgren <tony@atomide.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Thu, 15 Nov 2012 08:27:44 -0800
Message-ID: <20121115162743.GH6801@atomide.com>
References: <k80da6$61d$1@ger.gmane.org>
 <CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
 <20121114175149.GT6801@atomide.com>
 <CAORVsuWAwCWktfsA1_juQ=B_pR26tnfSq5Fzjki0c1iW7nBn1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49507 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S2992633Ab2KOQ1r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 11:27:47 -0500
Content-Disposition: inline
In-Reply-To: <CAORVsuWAwCWktfsA1_juQ=B_pR26tnfSq5Fzjki0c1iW7nBn1g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: i.mazanov@gmail.com, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

* Jean Pihet <jean.pihet@newoldbits.com> [121115 06:49]:
> Hi Tony,
> 
> On Wed, Nov 14, 2012 at 6:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Jean Pihet <jean.pihet@newoldbits.com> [121114 08:43]:
> >>
> >> The patch should change the name of the hwmod entry as well, can you
> >> fold this change in the current patch?
> >
> > This was caused by the merge of omap-for-v3.8/pm into omap-for-v3.8/clock.
> > I noticed a smilar issue for omap3, but missed at least this one.
> >
> > Jean, can you please check omap-for-v3.8/clock for the smartreflex
> > clock names in case there are more issues like this remaining?
> The hwmod clock names are OK for 3xxx, 36xx, 33xx and 44xx. The hwmod
> names are OK excepted for 33xx where they respectively should be
> "smartreflex_mpu_iva" and ""smartreflex_core".
> 
> This issue is caused by 99e7938d "ARM: OMAP3: clock: Add 3xxx data
> using common struct clk" in omap-for-v3.8/clock.

OK thanks for checking.

Regards,

Tony
