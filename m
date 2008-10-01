From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/25] twl4030 patches (v5)
Date: Wed, 1 Oct 2008 13:42:40 +0300
Message-ID: <20081001104239.GF15017@atomide.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com> <200809301241.09171.david-b@pacbell.net> <5e088bd90809301630h99d25c6vf2cddfa6699ee0b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63675 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYJAKjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Oct 2008 06:39:52 -0400
Content-Disposition: inline
In-Reply-To: <5e088bd90809301630h99d25c6vf2cddfa6699ee0b6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Steve Sakoman <sakoman@gmail.com> [081001 02:30]:
> On Tue, Sep 30, 2008 at 12:41 PM, David Brownell <david-b@pacbell.net> wrote:
> > On Tuesday 30 September 2008, Felipe Balbi wrote:
> >> Hopefully this is the final version:
> >
> > For the core?  This is IMO suitable for merging to linux-omap.
> > In terms of no-bugs-Dave-knows-about, for stuff he's touched.
> >
> > There will however be other updates later...
> >
> > ... including the patch 26/25 I'm about to send -- shrinkage.  ;)
> 
> I tested the v5 series (26/25) on Overo and found no issues other than
> the musb problem we discussed earlier.
> 
> I agree that it is suitable for merging.
> 
> I'll prepare a "twl4030-gpio: overo pull up/down init" and submit it
> after the merge.

OK, these 25 + 1 twl4030 patches pushed now.

Tony
