From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: omap2: throw the die id into the entropy pool
Date: Thu, 3 Oct 2013 11:13:33 -0700
Message-ID: <20131003181332.GQ8949@atomide.com>
References: <1378366158-31183-1-git-send-email-linus.walleij@linaro.org>
 <alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
 <CACRpkdartxUGNqNkpymecaTrgVrkcDTg9UN7LRiCVRcwnE01Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44869 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264Ab3JCSNi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Oct 2013 14:13:38 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdartxUGNqNkpymecaTrgVrkcDTg9UN7LRiCVRcwnE01Og@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>

* Linus Walleij <linus.walleij@linaro.org> [130910 01:28]:
> On Mon, Sep 9, 2013 at 9:14 PM, Paul Walmsley <paul@pwsan.com> wrote:
> 
> > Heh, that function name "add_device_randomness()" is a bit misleading.
> > It's not actually intended to add "randomness": from
> > drivers/char/random.c:
> 
> Yeah you're right...
> 
> Tony feel free to edit the commit message when applying.
> 
> >  * None of this adds any entropy, it is meant to avoid the
> >  * problem of the nonblocking pool having similar initial state
> >  * across largely identical devices.
> 
> It's noble enough, just a few years back I ran into the problem where
> all boards in a test farm came up with the same ethernet MAC
> address due to the initialization of the nonblocking pool being
> constant.

Thanks, I'll apply this into omap-for-v3.13/fixes-not-urgent
with updated comments.

Tony

