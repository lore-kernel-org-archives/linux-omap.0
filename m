From: Tony Lindgren <tony@atomide.com>
Subject: Re: Android on N810 File System Problem
Date: Mon, 28 Apr 2008 16:38:28 -0700
Message-ID: <20080428233827.GE8449@atomide.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com> <48116F5C.9040009@googlemail.com> <20080425183605.GA27479@kedavra.cpe.vivax.com.br> <87fxt7my4o.fsf@nokia.com> <20080427223248.GA5962@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59057 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934014AbYD1Xie (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 19:38:34 -0400
Content-Disposition: inline
In-Reply-To: <20080427223248.GA5962@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Kalle Valo <kalle.valo@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, Jonathan Herriott <herriojr@gmail.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080427 15:31]:
> On Sun, Apr 27, 2008 at 12:43:19PM +0300, Kalle Valo wrote:
> > "ext Felipe Balbi" <me@felipebalbi.com> writes:
> > 
> > > Current linux-omap's head has all the necessary pieces to get n810
> > > working. Touchscreen, keypad, ambient light sensor, led, usb, everything
> > > is there.
> > 
> > What about sound?
> 
> I'm sure it'll come from alsa-devel soon.

I've merged Jarkko's asoc patch to linux-omap for testing. Have not
gotten any sound out of it on my n810 though.. Maybe some alsamixer
settings issue?

Kalle, do you have any tips on getting WLAN to work on n8x0?

Don't know if there's anything new there to you, but I posted some
info on getting things to work with current linux-omap kernel at:

http://www.muru.com/linux/n8x0/

Regards,

Tony
