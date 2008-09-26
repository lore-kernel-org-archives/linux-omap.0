From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Fri, 26 Sep 2008 13:01:59 -0700
Message-ID: <5e088bd90809261301r66611a85u66ccdccd3e18fa89@mail.gmail.com>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
	 <1222427996-7018-9-git-send-email-felipe.balbi@nokia.com>
	 <1222427996-7018-10-git-send-email-felipe.balbi@nokia.com>
	 <200809261250.50893.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:39864 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbYIZUCA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 16:02:00 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1272631wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2008 13:01:59 -0700 (PDT)
In-Reply-To: <200809261250.50893.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mikko Ylinen <mikko.k.ylinen@nokia.com>

On Fri, Sep 26, 2008 at 12:50 PM, David Brownell <david-b@pacbell.net> wrote:
> Steve, if Overo wires out any of the ADC channels on that
> one connector, you may want to come up with a better fox.

Overo does bring out the ADC channels to one of the 2 70 pin connectors.

Let's go ahead with your proposed patch for now.  I will revisit it
when I get an Overo "buddy" board that actually makes the ADC channels
accessible.  At that point I can prepare a patch that includes all
changes required to get the ADC stuff functioning.

Steve
