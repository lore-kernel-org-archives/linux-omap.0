From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: omap3: cm-t35: add support for cm-t3730
Date: Tue, 14 Jun 2011 00:36:49 -0700
Message-ID: <20110614073648.GI3352@atomide.com>
References: <4DC27317.7020206@compulab.co.il>
 <1304839231-11329-1-git-send-email-grinberg@compulab.co.il>
 <20110531130447.GK11352@atomide.com>
 <4DE8E3B7.5020107@compulab.co.il>
 <20110613133307.GC3352@atomide.com>
 <4DF66659.3070102@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:10226 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752645Ab1FNHgw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 03:36:52 -0400
Content-Disposition: inline
In-Reply-To: <4DF66659.3070102@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [110613 12:30]:
> On 06/13/11 16:33, Tony Lindgren wrote:
> > * Igor Grinberg <grinberg@compulab.co.il> [110603 06:33]:
> >> I'm not sure I understand what are you trying to propose here...
> >> If you look once again on the code, there is currently only one if (cpu_is_..) {} else {}
> >> statement currently present.
> >> (I can remove the "if (cpu_is_omap3630())" - it indeed has no value)
> >>
> >> Indeed, there will be some other differences...
> >> Each time I submit a patch, I try to be as optimal as I can,
> >> but again I'm open for suggestions...
> >> (though I think it is optimal, e.g. 33 lines for a new running board...)
> > What I meant is that maybe you should do the detection first in some
> > get_revision function and populate the gpio pins there. Sort of like
> > this recent beagle patch:
> >
> > https://patchwork.kernel.org/patch/859662/
> 
> Yes I've seen this patch (actually, I was one of the people who reviewed it).
> 
> > That way adding support for other differences will be easier.
> 
> OK, now I understand what you mean.
> I think currently this is not optimal for cm-t35/3730 and will just complicate
> things and introduce more l-o-c.
> 
> The situation on beagle board is much more complicated then on cm-t3x.
> Beagle has quite a large number of revisions,
> while cm-t35 has only one and cm-t3730 has only one.
> Moreover, there is no difference in gpios - same numbers are used
> for the same functionality.
> 
> In particular the only two differences (that s/w cares about) between the boards are:
> 1) mux of the DSS pins
> 2) no NAND on cm-t3730 (still not introduced by the patch in subj)
> 
> Nevertheless, I will try to come up with something,
> so we can see and decide what is a better option.

OK if the differences are minimal, then it's up to you to which way
you want to patch it: )
 
> I will base it on your devel-board branch
> (correct me if you want it some other way).

That's good thanks.

Regards,

Tony
