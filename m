From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Sat, 27 Sep 2008 10:17:22 -0700
Message-ID: <200809271017.23081.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <200809270804.16788.david-b@pacbell.net> <5e088bd90809270840n52353a1bp7b7635fb6b5345e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:37876 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752811AbYI0RR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Sep 2008 13:17:26 -0400
In-Reply-To: <5e088bd90809270840n52353a1bp7b7635fb6b5345e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>, me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Saturday 27 September 2008, Steve Sakoman wrote:
> On Sat, Sep 27, 2008 at 8:04 AM, David Brownell <david-b@pacbell.net> wrote:
> 
> > I stand not-completely-corrected, then!  No channels are wired
> > on the beagle; but some are wired internally to its T2 chip.  ;)
> 
> On Overo, ADC channels 2-7 are brought out on one of the 2 70 pin
> expansion connectors.

Right; you mentioned that before.

Have you had thoughts on how they might best be exposed?
Would sysfs work?  Are kernel-to-kernel interfaces needed?

