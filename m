From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Sat, 27 Sep 2008 08:40:13 -0700
Message-ID: <5e088bd90809270840n52353a1bp7b7635fb6b5345e@mail.gmail.com>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
	 <20080926174643.GA9890@frodo> <48DDE2AD.1030202@nokia.com>
	 <200809270804.16788.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:48027 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbYI0PkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Sep 2008 11:40:14 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1535388wfd.4
        for <linux-omap@vger.kernel.org>; Sat, 27 Sep 2008 08:40:13 -0700 (PDT)
In-Reply-To: <200809270804.16788.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>, me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, Sep 27, 2008 at 8:04 AM, David Brownell <david-b@pacbell.net> wrote:

> I stand not-completely-corrected, then!  No channels are wired
> on the beagle; but some are wired internally to its T2 chip.  ;)

On Overo, ADC channels 2-7 are brought out on one of the 2 70 pin
expansion connectors.

Steve
