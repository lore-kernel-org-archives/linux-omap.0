From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv3 2/9] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add recursive
 usecount tracking
Date: Fri, 1 Jun 2012 04:27:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206010427030.17068@utopia.booyaka.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com> <1338470942-20185-3-git-send-email-t-kristo@ti.com> <CAOMWX4dPQGw=_u5HvD8T9cJ1aSo8tTsmok+bj2Op5TWtbp9R4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48317 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758571Ab2FAK1v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 06:27:51 -0400
In-Reply-To: <CAOMWX4dPQGw=_u5HvD8T9cJ1aSo8tTsmok+bj2Op5TWtbp9R4A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 1 Jun 2012, Menon, Nishanth wrote:

> On Thu, May 31, 2012 at 8:28 AM, Tero Kristo <t-kristo@ti.com> wrote:
> minor comment:
> > +void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
> <snip>
> > +void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
> 
> I know the understand that rest of the code lacks kernel-doc,

Almost all of the powerdomain code has kerneldoc present.

> but at least can we ensure that the new functions does?

Indeed:

http://www.spinics.net/lists/arm-kernel/msg164548.html


- Paul
