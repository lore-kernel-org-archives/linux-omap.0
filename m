From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/9] ARM: OMAP: Fix McBSP spin_lock deadlock
Date: Wed, 28 Jan 2009 18:05:38 -0800
Message-ID: <200901281805.38609.david-b@pacbell.net>
References: <20090128181931.21007.73744.stgit@localhost> <200901281553.07677.david-b@pacbell.net> <20090129005127.GW32148@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:41673 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752288AbZA2CFk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Jan 2009 21:05:40 -0500
In-Reply-To: <20090129005127.GW32148@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

On Wednesday 28 January 2009, Tony Lindgren wrote:
> 
> > > AFAIK it happens in the mainline with CONFIG_PREMEPT and ASoC.
> > 
> > I thought it was just spinlock debugging, period.

... on top of ASoC, yes.

 
> Yeah right, that's all there is to it. Without ASoC there may not be
> any McBSP users.. And to see the warnings spinlock debugging is needed.

And, as I understand, it works OK without spinlock debugging.

Some of us leave that on all the time though, which means that
OMAP3 ALSA support is more heard "of" than heard.  ;)

- Dave


