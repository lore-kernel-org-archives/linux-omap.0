From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 3/3] omap: rx51: Add supplies for the tlv320aic3x codec
 driver
Date: Wed, 5 May 2010 21:41:58 +0300
Message-ID: <20100505214158.0605f710.jhnikula@gmail.com>
References: <1272902176-21033-1-git-send-email-jhnikula@gmail.com>
	<1272902176-21033-3-git-send-email-jhnikula@gmail.com>
	<20100505172011.c57044f0.jhnikula@gmail.com>
	<20100505142513.GA11441@sirena.org.uk>
	<20100505151539.GU29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f222.google.com ([209.85.219.222]:54461 "EHLO
	mail-ew0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282Ab0EESkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 14:40:47 -0400
Received: by ewy22 with SMTP id 22so1580723ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 11:40:46 -0700 (PDT)
In-Reply-To: <20100505151539.GU29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@nokia.com>

On Wed, 5 May 2010 08:15:39 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Mark Brown <broonie@opensource.wolfsonmicro.com> [100505 07:20]:
> > Seems sensible to merge this along with the CODEC driver patch it
> > depends on if everyone else is happy (assuming no merge issues)?
> 
> Sounds good to me. I'll take the other ones, if there are merge issues
> then we can move some of the other patches into your tree too.
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

I would rather keep the board-rx51-peripherals.c in linux-omap sync
than get the N900 audio working as soon as possible :-)

None of these patches are build or boot critical so I can wait & repost
the last one when the codec patches hit into mainline.

Only harm from some missing board-rx51-peripherals.c patch is that
codec either doesn't probe or is kept in reset but system boots up
fine. And trees are clean too!


-- 
Jarkko
