From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: Re: [PATCH] OMAP3: SDTI: Prevent access to sdti writing if module
	is not initialized.
Date: Mon, 2 Mar 2009 14:15:55 +0200
Message-ID: <20090302121555.GB27397@pure.research.nokia.com>
References: <1234438768-20697-1-git-send-email-roman.tereshonkov@nokia.com> <20090216113303.GL21181@scadufax.research.nokia.com> <20090227183524.GI11594@atomide.com> <20090227190053.GH16801@frodo> <20090228100855.GA10606@mail.solidboot.com> <20090302082750.GC24691@pure.research.nokia.com> <20090302113112.GA15810@mail.solidboot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42625 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758677AbZCBMQt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2009 07:16:49 -0500
Content-Disposition: inline
In-Reply-To: <20090302113112.GA15810@mail.solidboot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Juha Yrjola <juha.yrjola@solidboot.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "Tereshonkov Roman (Nokia-D/Helsinki)" <roman.tereshonkov@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 02/03/09 12:31 +0100, ext Juha Yrjola wrote:
> On Mon, Mar 02, 2009 at 10:27:50AM +0200, Lauri Leukkunen wrote:
> 
> > > STI console is enabled based on runtime decisions by the bootloader. The
> > > kernel command line is unusable for us, because there is no way to append to
> > > the line. We don't want to remove the possibility how having the user
> > > create a custom kernel with a custom command line.
> > 
> > *I* don't have a problem with having the bootloader always define the
> > cmdline, you are the one against it :)
> 
> If we did that, how would the kernel flashing process go?

flasher needs to support updating the cmdline stored in the CAL, maybe with:
flasher -b"cmdline" -f

Then you just ignore whatever the kernel builtin cmdline is. So no need to
change how the kernel is flashed. If a person is anyway modifying the
cmdline, he might as well do it using the above mentioned command instead of
hardcoding it into the kernel. This way he can experiment with different
cmdlines without having to recompile and reflash the kernel.

Maybe a -b"default" -f could be used to put back the default (perhaps also
found from the CAL area?).

This would require for the default cmdline to be written to CAL at
manufacturing time, or be carried by the bootloader binary itself.
Either way would be ok to me.

/lauri

