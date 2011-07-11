From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Subject: Re: [PATCH 00/22] Tahvo cleanups and Retu optimization
Date: Mon, 11 Jul 2011 15:41:26 +0200
Message-ID: <20110711154126.082c1514@maggie>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
	<20110711132842.10606a31@maggie>
	<20110711131231.GB2680@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bues.ch ([80.190.117.144]:37867 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217Ab1GKNli (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 09:41:38 -0400
In-Reply-To: <20110711131231.GB2680@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Michael =?UTF-8?B?QsO8c2No?= <mb@bu3sch.de>

On Mon, 11 Jul 2011 16:12:32 +0300
Felipe Balbi <balbi@ti.com> wrote:
> > Are you planning to implement a backlight driver for tahvo? I'm actually
> > using the functionality that you removed in this patchset in the OpenWRT
> > distribution.
> 
> if you have some extra documentation available, I could implement it
> whenever I have some extra couple hours to play with this again... I
> have no docs at all, but a led-tahvo.c would be really simple to get
> done :-)

All I have is the old code. No docs. It seems rather simple, though.
Only a PWM register. That's pretty straightforward.
