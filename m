From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.23-omap] misc musb tweaks
Date: Mon, 15 Oct 2007 07:46:12 -0700
Message-ID: <20071015144612.GA20513@atomide.com>
References: <Pine.LNX.4.44L0.0710142127330.32416-100000@netrider.rowland.org>
	<200710141844.32657.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200710141844.32657.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [071014 18:45]:
> On Sunday 14 October 2007, Alan Stern wrote:
> > On Sun, 14 Oct 2007, David Brownell wrote:
> > 
> > > > What else should we still fix before submitting to linux-usb-devel?
> > > 
> > > I don't see much of a reason why it shouldn't go upstream "now"...
> > 
> > The host part will need a bunch of changes to put it in line with the 
> > new urb->status stuff.  Without that it won't even compile.  Not 
> > difficult to do, just something to keep in the back of your mind...
> 
> And that's all in the current kernel.org GIT tree, ISTR ...

OK, I'll look into it and prepare the patches for review within next
few days hopefully.

Regards,

Tony
