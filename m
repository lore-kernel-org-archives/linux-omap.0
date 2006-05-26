From: Tony Lindgren <tony@atomide.com>
Subject: Re: [ANNOUNCE] TI DaVinci git tree available
Date: Fri, 26 May 2006 16:21:47 -0700
Message-ID: <20060526232147.GP4132@atomide.com>
References: <1147826617.8739.32.camel@vence.internal.net>
	<446B44B9.2000900@gmail.com>
	<1147885134.8739.70.camel@vence.internal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1147885134.8739.70.camel@vence.internal.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [060517 13:46]:
> On Wed, 2006-05-17 at 17:43 +0200, Dirk Behme wrote:
> > Kevin Hilman wrote:
> > > The kernel git tree[1] for the TI DaVinci platform is now available
> > 
> > What are the pros and cons for having one tree vs. two trees 
> > for OMAP1 & OMAP2 (& OMAP3?) & DaVinci in the long term?
> 
> It may be a good idea long term, in fact I almost released this tree as
> a branch of the OMAP tree instead of Linus' tree.  As I thought about it
> though, there's very little shared code between the two trees, so I
> assumed it would be more of a burden on the OMAP community.  So in the
> end, I decided to wait and see what type of development community
> sprouts up around DaVinci and go from there.  If the OMAP community is
> interested in absorbing the DaVinci support, I think long-term
> maintenance would be easier.
> 
> I'm not fixed on one way or the other, and could easily be pursuaded to
> rebase the DaVinci tree.  For kicks, I rebased locally, and there's a
> patch adding DaVinci support to todays OMAP tree available here:
> http://source.mvista.com/~khilman/davinci/

Let's wait and see then. If we have lots of drivers to share then it
makes sense to have them in the same tree. But for few drivers, let's
just work them out and try to have them integrated into the mainline
tree.
 
> Some existing areas of overlap I can think of off the top of my head:
> 
> - CONFIG_DEBUG_LL patch to kernel/printk.c

Hmmm, what are you using for CONFIG_DEBUG_LL then?

> - AIC23 code: DaVinci has AIC33 and I have a minor patch to support
> AIC33

Let's try to get that integrated to the mainline tree.

> - There's also hack to the 8250.c serial ISR that used to be needed but
> is no longer needed on DaVinci.  It seems some mainline fixes have
> removed the need for that.  I'm curious if it's still necessary on OMAP.

I assume you mean this chunk?

@@ -1372,7 +1372,8 @@
 
        DEBUG_INTR("end.\n");
 
-       return IRQ_RETVAL(handled);
+       //return IRQ_RETVAL(handled);
+       return IRQ_HANDLED;     /* FIXME: iir status not ready on 1510 */
 }

I'll see if things work now without that.

Regards,

Tony
