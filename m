From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: Re: [PATCH] OMAP3: SDTI: Prevent access to sdti writing if module
	is not initialized.
Date: Mon, 2 Mar 2009 10:27:50 +0200
Message-ID: <20090302082750.GC24691@pure.research.nokia.com>
References: <1234438768-20697-1-git-send-email-roman.tereshonkov@nokia.com> <20090216113303.GL21181@scadufax.research.nokia.com> <20090227183524.GI11594@atomide.com> <20090227190053.GH16801@frodo> <20090228100855.GA10606@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65127 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbZCBI2V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 03:28:21 -0500
Content-Disposition: inline
In-Reply-To: <20090228100855.GA10606@mail.solidboot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Juha Yrjola <juha.yrjola@solidboot.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "Tereshonkov Roman (Nokia-D/Helsinki)" <roman.tereshonkov@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 28/02/09 11:08 +0100, ext Juha Yrjola wrote:
> On Fri, Feb 27, 2009 at 09:00:53PM +0200, Felipe Balbi wrote:
> 
> > Juha could you comment again what were the problems on starting the sti
> > console based on console= command line ??
> 
> STI console is enabled based on runtime decisions by the bootloader. The
> kernel command line is unusable for us, because there is no way to append to
> the line. We don't want to remove the possibility how having the user
> create a custom kernel with a custom command line.

*I* don't have a problem with having the bootloader always define the
cmdline, you are the one against it :)

/lauri

