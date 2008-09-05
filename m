From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Fri, 5 Sep 2008 09:56:41 -0700
Message-ID: <20080905165641.GI24202@atomide.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com> <20080905011235.GZ23085@atomide.com> <5e088bd90809042318k762df6c8k79ef1fcbad9a8781@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61608 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbYIEQ4n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 12:56:43 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809042318k762df6c8k79ef1fcbad9a8781@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [080904 23:36]:
> On Thu, Sep 4, 2008 at 6:12 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Jarkko Nikula <jarkko.nikula@nokia.com> [080821 04:58]:
> >> Here are two patches adding support for OMAP2430 in McBSP driver and
> >> adding support for 2430 and 34xx in ASoC OMAP McBSP DAI driver.
> >>
> >> These are generated from top of currect l-o head but they apply also on
> >> top of Hiroshi's virtual clock patches with some offsets.
> >>
> >> If you have change to try them out on those CPUs, I would be happy to
> >> hear. I've tested these only on N810. Second patch will naturally go
> >> through the alsa-devel when we have necessary McBSP patches upstream.
> >
> > Can you please refresh these against the current l-o head?
> 
> I've been testing these patches along with my Overo patches on the
> current l-o head.  Audio is working fine, so the mcbsp changes haven't
> broken anything.

At least the first patch needs to be updated for phys_pbase instead of
virt_base.

> I do miss having functional USB though :-)

Hmm, is the musb broken now?

Tony
