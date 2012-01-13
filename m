From: Paul Walmsley <paul@pwsan.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 13 Jan 2012 16:35:35 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201131634210.3659@utopia.booyaka.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <20120112095940.0a54413e@notabene.brown> <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
 <20120113222045.37f9b4ec@notabene.brown> <alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com> <20120114100915.01c96727@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52550 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab2AMXff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 18:35:35 -0500
In-Reply-To: <20120114100915.01c96727@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

On Sat, 14 Jan 2012, NeilBrown wrote:

> On Fri, 13 Jan 2012 04:31:37 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> 
> > I'm not seeing garbling at all on the OMAP3 BeagleBoard here, running v3.2 
> > with omap2plus_defconfig.  The first character from the console gets lost, 
> > which again is expected when the CORE enters a low-power state and there's 
> > no flow control on the serial interface -- but no garbling.
> 
> What baud rate?

115200 bps, no flow control.

> Presumably with working hardware handshaking we should be able to avoid any
> loss or corruption??

Yes.  If you're using off-mode, you'll need to ensure that the I/O ring is 
set to wake the system when it sees the appropriate signal level on the 
incoming flow control line.

> (I'm not sure if I said - but the board I am working on is the GTA04 Openmoko
> board: www.gta04.org).

Did not know that.  Exciting!  Maybe you can send some to the OMAP 
maintainers ;-)
 

- Paul
