From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Fri, 5 Sep 2008 10:52:01 -0700
Message-ID: <20080905175200.GO24202@atomide.com>
References: <1219319718-1750-1-git-send-email-jarkko.nikula@nokia.com> <20080905011235.GZ23085@atomide.com> <5e088bd90809042318k762df6c8k79ef1fcbad9a8781@mail.gmail.com> <20080905165641.GI24202@atomide.com> <5e088bd90809051023t6aab7d93jd04d18d6843cb4e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60373 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbYIERwF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 13:52:05 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809051023t6aab7d93jd04d18d6843cb4e6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Steve Sakoman <sakoman@gmail.com> [080905 10:24]:
> > At least the first patch needs to be updated for phys_pbase instead of
> > virt_base.
> 
> Yes it does, mcbsp is likely still working by the same accident of fate.
> 
> > Hmm, is the musb broken now?
> 
> It is on Overo if I base my patches against current top of tree
> (a376251519ced5831ed07ed234430725230ed93a)
> 
> Doesn't crash, just quietly doesn't work.  I hear from Beagle folk
> that musb doesn't work there either.   I have it configured as a host
> port, and IIRC so do the Beagle folks
> 
> If I base my patches against the state of the tree just prior to the
> move to rc5 (81c893795c2e1fbe0bf5f638ed6ae1e500b80a2d), musb works as
> well as it ever has.

Well with -rc5 we switched to the drivers/usb/musb code from mainline
kernel. Maybe try to diff musb code with:

$ git-diff 81c893795c2e1fbe0bf5f638ed6ae1e500b80a2d.. drivers/usb/musb

And see if there are any clues?

Tony
