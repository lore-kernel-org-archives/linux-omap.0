From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: Re: [PATCH 1/5] I2C: LM8323: Introduce lm8323 keypad driver
Date: Wed, 9 Apr 2008 21:28:04 +0300
Message-ID: <20080409182804.GB24100@pure.research.nokia.com>
References: <1207742644-6260-1-git-send-email-felipe.balbi@nokia.com> <1207742644-6260-2-git-send-email-felipe.balbi@nokia.com> <20080409121124.GS7338@gandalf.research.nokia.com> <fb249edb0804091026h796d373bn7ad2a58a2edb6e0d@mail.gmail.com> <20080409180557.GA15913@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16640 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493AbYDISaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 14:30:09 -0400
Content-Disposition: inline
In-Reply-To: <20080409180557.GA15913@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Felipe Balbi <me@felipebalbi.com>
Cc: andrzej zaborowski <balrogg@gmail.com>, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Stone <daniel.stone@nokia.com>

On 09/04/08 21:05 +0300, ext Felipe Balbi wrote:
> On Wed, Apr 09, 2008 at 07:26:31PM +0200, andrzej zaborowski wrote:
> > Question not really related to this patchset, but in the TSC2005
> > driver some averaging and limit checks are done to the ADC values.
> > Shouldn't that be done in userspace instead?  (The ADS784x and TSC2301
> > drivers do the same evidently.)
> 
> Now that's not really up to me, but if we move it now it probably won't
> provide the feature n810 needs. I mean, n810 is designed on top of the
> features provided by driver, the application probably expects the driver
> to do the averaging and limit checks so at least for tsc2005 I think
> it's not a good idea to change due to application requirements.

User-space is too late for this filtering, we would end up feeding ~1k samples
per second there, and that would simply clog the system pretty badly, can't
do much buffering either as that degrades interactive responsiveness of the
UI. In my opinion kernel should provide "correct" data to user-space, not
some pseudo-random interference from the LCD. Micro-kernel people will of
course disagree.

/lauri

