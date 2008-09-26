From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 0/9] twl4030 updates
Date: Fri, 26 Sep 2008 12:10:41 -0700
Message-ID: <5e088bd90809261210x61bbd07ey6742dfd13180073f@mail.gmail.com>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
	 <200809261012.28007.david-b@pacbell.net>
	 <200809261200.30728.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:54386 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbYIZTKn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 15:10:43 -0400
Received: by gxk9 with SMTP id 9so8716883gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2008 12:10:42 -0700 (PDT)
In-Reply-To: <200809261200.30728.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Sep 26, 2008 at 12:00 PM, David Brownell <david-b@pacbell.net> wrote:
> And after applying this, and removing MADC config from
> the Beagle and Overo board setup files, things worked!!

That's really great news!

> Moreover ... the USB host code worked, at least partially.
> (Finally!  RC7.)  It enumerated the external hub, and the
> Ethernet adapter hooked up to it.

Just to clarify -- you are referring to musb host code, correct?

Steve
