From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] musb/tusb6010 fixes for host mode
Date: Fri, 4 May 2007 10:01:33 -0700
Message-ID: <20070504170133.GF12331@atomide.com>
References: <11782105181141-git-send-email-tony@atomide.com>
	<1178295770.2017.67.camel@paris.hilman.org>
	<20070504164807.GE12331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070504164807.GE12331@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [070504 09:49]:
> * Kevin Hilman <khilman@mvista.com> [070504 09:23]:
> > On Thu, 2007-05-03 at 16:41 +0000, Tony Lindgren wrote:
> > 
> > > Here are some USB patches that make tusb6010 host mode work
> > > finally reliably on at least N800. Now all testusb cases pass
> > > with N800 running as a host.
> > 
> > Tony,
> > 
> > There are some uses of tusb_dma_omap() that are not defined when
> > compiling for !tusb platforms.  The hack below gets it to compile on
> > 2430, but is probably not "the right thing."
> 
> Thanks, looks like I missed that. That's how it should be :) I'll push
> it today.

Actually, I'll just move the #define tusb_dma_omap() to dma.h there.

Tony
