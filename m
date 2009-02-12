From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc3-omap-git] omap3: gpio pin config bugfixes
Date: Wed, 11 Feb 2009 17:51:13 -0800
Message-ID: <200902111751.13546.david-b@pacbell.net>
References: <200902082055.08954.david-b@pacbell.net> <4d34a0a70902090424n5e64a4fjeae8ce20bd4fafd0@mail.gmail.com> <20090212004500.GG13748@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:45458 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754738AbZBLBvR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Feb 2009 20:51:17 -0500
In-Reply-To: <20090212004500.GG13748@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kim Kyuwon <chammoru@gmail.com>, OMAP <linux-omap@vger.kernel.org>, Manikandan Pillai <mani.pillai@ti.com>

On Wednesday 11 February 2009, Tony Lindgren wrote:
> > >
> > 
> > So the thing is, OMAP34XX_PIN_INPUT doens't mean input-only, but
> > input-and-output. And OMAP34XX_PIN_OUTPUT doen't mean output, but output-only.
> > Names of macros are really confusing me. Shouldn't we change names of these
> > macros first? For example,
> > OMAP34XX_PIN_INPUT -> OMAP34XX_PIN_INPUT_EN
> > OMAP34XX_PIN_OUTPUT -> OMAP34XX_PIN_OUTPUT_ONLY
> 
> I like this idea to cut down on confusion.

Makes sense to me.  Though I suggest merging this first,
and then changing everything in the tree ... instead of
changing everything first, and then redoing this patch.  :)

