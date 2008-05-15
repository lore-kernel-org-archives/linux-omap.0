From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] Input: Make lm8323 sticky key to work with console
Date: Thu, 15 May 2008 01:29:57 -0700
Message-ID: <20080515082957.GM8928@atomide.com>
References: <1210824079-22548-1-git-send-email-tony@atomide.com> <1210824079-22548-2-git-send-email-tony@atomide.com> <1210824079-22548-3-git-send-email-tony@atomide.com> <20080515080333.GD4625@kedavra.cpe.vivax.com.br> <fb249edb0805150114vdcf2a7crbd498f36613c7bc@mail.gmail.com> <20080515082013.GB4853@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50920 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbYEOI36 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 04:29:58 -0400
Content-Disposition: inline
In-Reply-To: <20080515082013.GB4853@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: andrzej zaborowski <balrogg@gmail.com>, linux-omap@vger.kernel.org, daniel.stone@nokia.com

* Felipe Balbi <me@felipebalbi.com> [080515 01:19]:
> On Thu, May 15, 2008 at 10:14:24AM +0200, andrzej zaborowski wrote:
> > On 15/05/2008, Felipe Balbi <me@felipebalbi.com> wrote:
> > > On Wed, May 14, 2008 at 09:01:19PM -0700, Tony Lindgren wrote:
> > >  > This allows using N810 keyboard from console by adding optional
> > >  > Fn and shift sticky key handling by passing them from platform_data.
> > >  >
> > >  > Currently some not so obvious mappings are:
> > >  >
> > >  > - Pipe is Fn + Enter
> > >  > - Delete is Fn + Backspace
> > >  > - Escape is Fn + Ctrl
> > >
> > >  no tab? :-(
> > >
> > >  Fn + space maybe?? :-p
> > 
> > Fn + Right is assigned in the patch (I check too :) ).  But I'm not
> > sure whther that should be done in the lm8323 driver or elsewhere. The
> > existence of keys like Fn and Shift is N810-specific and lm8323 is
> > just a gpio matrix keypad chip.
> 
> but that's coming from board file. It should be ok.

Yeah I think it should be OK too as nothing happens if platform_data does
not pass fn or shift keys. So the driver should work with any keyboard
layout.

Tony
