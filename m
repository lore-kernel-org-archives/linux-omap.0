From: Peter Barada <peterb@logicpd.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Thu, 20 Aug 2009 12:29:02 -0400
Message-ID: <1250785742.10817.38.camel@blitz>
References: <20090810161605.GA4357@gandalf>
	 <1249923607.31495.13.camel@blitz> <20090810170236.GA3528@gandalf>
	 <1249925323.31495.31.camel@blitz> <20090810184818.GA4281@gandalf>
	 <1249936961.31495.87.camel@blitz> <20090811063305.GB4573@nokia.com>
	 <1250004077.18768.17.camel@blitz> <20090811205106.GC13969@gandalf>
	 <1250025476.18517.109.camel@blitz>  <20090811211725.GE13969@gandalf>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:54167 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754871AbZHTQYh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Aug 2009 12:24:37 -0400
In-Reply-To: <20090811211725.GE13969@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Wed, 2009-08-12 at 00:17 +0300, Felipe Balbi wrote:
> On Tue, Aug 11, 2009 at 05:17:56PM -0400, Peter Barada wrote:
> > On Tue, 2009-08-11 at 23:51 +0300, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Tue, Aug 11, 2009 at 11:21:17AM -0400, Peter Barada wrote:
> > > > Unfortunately, with the patch, and:
> > > > 
> > > > 1) modprobe musb_hdrc
> > > > 2) modprobe g_ether
> > > > 3) connect micro-a cable
> > > > 4) echo 1 > /sys/devices/platform/musb_hdrc/connect
> > > > 
> > > > Nothing happens - no isr or output.
> > > 
> > > did you have anything at the other end of the micro-a cable ?
> > 
> > Not then. :)
> > 
> > I just connected my OTG adapter/thumbdrive,  in step three and nothing
> > no isr or output.
> > 
> > I know my OTG adapter (micro-a -> female A) is valid as I ohm'd out ID
> > and ground on the baseboard (with the SOM removed), and indeed ID is
> > shorted to ground with the adapter plugged in and open with it
> > removed...
> 
> Well, looks like I'll have to go back to my documentation tomorrow at
> the office and see if I can get it working on one board of mine,
> let's see what happens and if I have to patch anything and what.

Felipe,

I was wondering if you've had a look at this?

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
