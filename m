From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] OMAP3: SDTI: Prevent access to sdti writing if module is not initialized.
Date: Sat, 28 Feb 2009 12:08:55 +0200
Message-ID: <20090228100855.GA10606@mail.solidboot.com>
References: <1234438768-20697-1-git-send-email-roman.tereshonkov@nokia.com> <20090216113303.GL21181@scadufax.research.nokia.com> <20090227183524.GI11594@atomide.com> <20090227190053.GH16801@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from solidboot.com ([92.48.122.80]:39535 "EHLO rei.solidboot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbZB1Kh6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 28 Feb 2009 05:37:58 -0500
Content-Disposition: inline
In-Reply-To: <20090227190053.GH16801@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, "Tereshonkov Roman (Nokia-D/Helsinki)" <roman.tereshonkov@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Feb 27, 2009 at 09:00:53PM +0200, Felipe Balbi wrote:

> Juha could you comment again what were the problems on starting the sti
> console based on console= command line ??

STI console is enabled based on runtime decisions by the bootloader. The
kernel command line is unusable for us, because there is no way to append to
the line. We don't want to remove the possibility how having the user
create a custom kernel with a custom command line.

Cheers,
Juha
