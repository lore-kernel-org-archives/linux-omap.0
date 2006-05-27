From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [ANNOUNCE] TI DaVinci git tree available
Date: Fri, 26 May 2006 17:19:51 -0700
Message-ID: <1148689191.10467.17.camel@vence.internal.net>
References: <1147826617.8739.32.camel@vence.internal.net>
	<446B44B9.2000900@gmail.com>
	<1147885134.8739.70.camel@vence.internal.net>
	<20060526232147.GP4132@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-O7qZa7yhyA/cG6p+fCrh"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060526232147.GP4132@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


--=-O7qZa7yhyA/cG6p+fCrh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-05-26 at 16:21 -0700, Tony Lindgren wrote:
> * Kevin Hilman <khilman@mvista.com> [060517 13:46]:
> > On Wed, 2006-05-17 at 17:43 +0200, Dirk Behme wrote:
> > > Kevin Hilman wrote:
> > > > The kernel git tree[1] for the TI DaVinci platform is now available
> > > 
> > > What are the pros and cons for having one tree vs. two trees 
> > > for OMAP1 & OMAP2 (& OMAP3?) & DaVinci in the long term?
> > 
> > It may be a good idea long term, in fact I almost released this tree as
> > a branch of the OMAP tree instead of Linus' tree.  As I thought about it
> > though, there's very little shared code between the two trees, so I
> > assumed it would be more of a burden on the OMAP community.  So in the
> > end, I decided to wait and see what type of development community
> > sprouts up around DaVinci and go from there.  If the OMAP community is
> > interested in absorbing the DaVinci support, I think long-term
> > maintenance would be easier.
> > 
> > I'm not fixed on one way or the other, and could easily be pursuaded to
> > rebase the DaVinci tree.  For kicks, I rebased locally, and there's a
> > patch adding DaVinci support to todays OMAP tree available here:
> > http://source.mvista.com/~khilman/davinci/
> 
> Let's wait and see then. If we have lots of drivers to share then it
> makes sense to have them in the same tree. But for few drivers, let's
> just work them out and try to have them integrated into the mainline
> tree.

So you're leaning towards keeping the trees separate?  It would
incentivize pushing things upstream.   In any case, I've attached a
patch which adds core DaVinci support to todays OMAP tree.  You can see
that there no changes to common files (except Makefile/Kconfig) and will
not affect OMAP.
 
> > Some existing areas of overlap I can think of off the top of my head:
> > 
> > - CONFIG_DEBUG_LL patch to kernel/printk.c
> 
> Hmmm, what are you using for CONFIG_DEBUG_LL then?

The change to kernel/printk.c is not in mainline, so I've borrowed the
one from the OMAP tree.

> > - AIC23 code: DaVinci has AIC33 and I have a minor patch to support
> > AIC33
> 
> Let's try to get that integrated to the mainline tree.

I don't think the existing aic23 code is in mainline yet, is it?

> > - There's also hack to the 8250.c serial ISR that used to be needed but
> > is no longer needed on DaVinci.  It seems some mainline fixes have
> > removed the need for that.  I'm curious if it's still necessary on OMAP.
> 
> I assume you mean this chunk?
>
> @@ -1372,7 +1372,8 @@
>  
>         DEBUG_INTR("end.\n");
>  
> -       return IRQ_RETVAL(handled);
> +       //return IRQ_RETVAL(handled);
> +       return IRQ_HANDLED;     /* FIXME: iir status not ready on 1510 */
>  }

Yeah, that's what I"m referring to.

> I'll see if things work now without that.
> 

DaVinci doesn't seem to need it anymore.

I remembered one other driver that will be shared and that's the Mentor
high-speed usb driver which is the same on 243x and DaVinci.  

Kevin


--=-O7qZa7yhyA/cG6p+fCrh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-O7qZa7yhyA/cG6p+fCrh--
