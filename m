From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 00/25] twl4030 patches (v5)
Date: Tue, 30 Sep 2008 16:30:50 -0700
Message-ID: <5e088bd90809301630h99d25c6vf2cddfa6699ee0b6@mail.gmail.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
	 <200809301241.09171.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:55164 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbYI3Xaw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 19:30:52 -0400
Received: by wf-out-1314.google.com with SMTP id 27so297770wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 30 Sep 2008 16:30:51 -0700 (PDT)
In-Reply-To: <200809301241.09171.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Tue, Sep 30, 2008 at 12:41 PM, David Brownell <david-b@pacbell.net> wrote:
> On Tuesday 30 September 2008, Felipe Balbi wrote:
>> Hopefully this is the final version:
>
> For the core?  This is IMO suitable for merging to linux-omap.
> In terms of no-bugs-Dave-knows-about, for stuff he's touched.
>
> There will however be other updates later...
>
> ... including the patch 26/25 I'm about to send -- shrinkage.  ;)

I tested the v5 series (26/25) on Overo and found no issues other than
the musb problem we discussed earlier.

I agree that it is suitable for merging.

I'll prepare a "twl4030-gpio: overo pull up/down init" and submit it
after the merge.

Steve
