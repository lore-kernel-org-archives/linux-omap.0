From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add
 recursive usecount tracking
Date: Mon, 4 Jun 2012 12:38:44 +0300
Message-ID: <1338802724.8834.211.camel@sokoban>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
	 <1338470942-20185-3-git-send-email-t-kristo@ti.com>
	 <CAOMWX4dPQGw=_u5HvD8T9cJ1aSo8tTsmok+bj2Op5TWtbp9R4A@mail.gmail.com>
	 <alpine.DEB.2.00.1206010427030.17068@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46322 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727Ab2FDJiv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 05:38:51 -0400
In-Reply-To: <alpine.DEB.2.00.1206010427030.17068@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 2012-06-01 at 04:27 -0600, Paul Walmsley wrote:
> On Fri, 1 Jun 2012, Menon, Nishanth wrote:
> 
> > On Thu, May 31, 2012 at 8:28 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > minor comment:
> > > +void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
> > <snip>
> > > +void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
> > 
> > I know the understand that rest of the code lacks kernel-doc,
> 
> Almost all of the powerdomain code has kerneldoc present.
> 
> > but at least can we ensure that the new functions does?
> 
> Indeed:
> 
> http://www.spinics.net/lists/arm-kernel/msg164548.html

Mmm yea, I'll add those for next rev.

-Tero


