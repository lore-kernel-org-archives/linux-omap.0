From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAP3 Beagle: update defconfig to match board file
Date: Wed, 28 May 2008 13:27:21 -0700
Message-ID: <20080528202720.GF8845@atomide.com>
References: <5e088bd90805272245q4ab6c1aue4b4d7d76e025422@mail.gmail.com> <bf8bea47238577986216c6ae6927cbac@felipebalbi.com> <5e088bd90805280548j10d287cbxe417dfbd85b51a90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:50614 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbYE1U1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 16:27:22 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90805280548j10d287cbxe417dfbd85b51a90@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <me@felipebalbi.com>

* Steve Sakoman <sakoman@gmail.com> [080528 05:49]:
> What is your preference, Tony?  Would you like me to resubmit as a single patch?

No need to resubmit thanks, although one patch would have been better
in this case :)

Tony


> 
> Steve
> 
> On Wed, May 28, 2008 at 2:57 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> >
> >
> > On Tue, 27 May 2008 22:45:03 -0700, "Steve Sakoman" <sakoman@gmail.com>
> > wrote:
> >> While preparing a set of patches to add nand support for beagle I
> >> noticed that the beagle defconfig hasn't kept up with the features
> >> present in board-omap3beagle.c
> >>
> >> This series of patches updates the defconfig to enable mmc, rtc, usb, and
> >> fb
> >
> > All of these could come in only one patch.
> >
> >
> > --
> > Best Regards,
> >
> > Felipe Balbi
> > http://felipebalbi.com
> > me@felipebalbi.com
> >
> >
