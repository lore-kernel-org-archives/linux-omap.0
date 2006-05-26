From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] add-RGB444-support-to-omapfb.patch
Date: Fri, 26 May 2006 15:43:00 -0700
Message-ID: <20060526224259.GJ4132@atomide.com>
References: <20060407193941.35989.qmail@web36915.mail.mud.yahoo.com>
	<20060413164602.GP12731@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060413164602.GP12731@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jonathan McDowell <noodles@earth.li> [060413 09:47]:
> On Fri, Apr 07, 2006 at 08:39:41PM +0100, Mark Underwood wrote:
> > This is an updated version of my patch that adds support for RGB444
> > mode for the internal LCD controller which now applies against
> > linux-2.6.16 with the patch-2.6.16-omap2 applied. 
> >  
> > Jonathan McDowell posted a slightly modified version of my original
> > patch to this list previously:
> >
> > http://Linux.omap.com/pipermail/linux-omap-open-source/2006-April/006839.html 
> >  
> > This patch is used by the Amstrad Delta (E3). 
> >  
> > Signed-Off-By: Mark Underwood <basicmark@yahoo.com>
> 
> This, or something that achieves the same result, is needed for the E3
> in order to get a sensible palette. I've been using Mark's patch for the
> past week on my E3 without issues and I've seen a few other bits of
> positive feedback from others too.
> 
> Acked-By: Jonathan McDowell <noodles@earth.li>

Pushing today.

Tony
