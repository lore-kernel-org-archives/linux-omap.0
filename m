From: Tony Lindgren <tony@atomide.com>
Subject: Re: [i2c] N800 problems with MMC, LM8323 on current linux-omap git
	head
Date: Mon, 4 Aug 2008 17:42:59 +0300
Message-ID: <20080804144258.GN8885@atomide.com>
References: <20080722124743.GA5820@kos.to> <90eb4be1e5a489819f08e76ad872e920@felipebalbi.com> <20080722133742.GA7492@kos.to> <20080722134314.GC8318@fluff.org.uk> <eb09f11f1e5a25903cfd4c2157ecbba5@felipebalbi.com> <20080723093849.GA13505@kos.to> <0487ae10263d239a8a891c9ed068da1c@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65394 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbYHDOnP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Aug 2008 10:43:15 -0400
Content-Disposition: inline
In-Reply-To: <0487ae10263d239a8a891c9ed068da1c@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, i2c@lm-sensors.org

* Felipe Balbi <me@felipebalbi.com> [080723 13:13]:
> 
> 
> On Wed, 23 Jul 2008 12:38:49 +0300, Riku Voipio <riku.voipio@iki.fi> wrote:
> > Indeed - compared to my previous version, this one makes the boardfile
> > even smaller:
> > 
> >    text    data     bss     dec     hex filename
> >    2362    1552       4    3918     f4e
> > old/arch/arm/mach-omap2/board-n800.o
> >    2354    1456       4    3814     ee6
> > new/arch/arm/mach-omap2/board-n800.o
> 
> Cool :-)

Pushing to linux-omap tree.

Tony


> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://blog.felipebalbi.com
> me@felipebalbi.com
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
