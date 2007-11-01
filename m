From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH resend] Make the dev_*() family of macros in
 device.hcomplete
Date: Thu, 1 Nov 2007 16:57:00 -0700
Message-ID: <20071101165700.aa5167fb.akpm@linux-foundation.org>
References: <1193697795-7823-1-git-send-email-Emilian.Medve@Freescale.com>
	<20071030000054.GA19022@suse.de>
	<598D5675D34BE349929AF5EDE9B03E27016E5FCB@az33exm24.fsl.freescale.net>
	<20071030154008.GA22809@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759860AbXKAX6H@vger.kernel.org>
In-Reply-To: <20071030154008.GA22809@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Emilian.Medve@freescale.com, linux-kernel@vger.kernel.org, hjlipp@web.de, tilman@imap.cc, gigaset307x-common@lists.sourceforge.net, kkeil@suse.de, isdn4linux@listserv.isdn4linux.de, mac@melware.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, 30 Oct 2007 08:40:08 -0700
Greg KH <gregkh@suse.de> wrote:

> On Tue, Oct 30, 2007 at 05:11:24AM -0700, Medve Emilian-EMMEDVE1 wrote:
> > Hi Greg K-H,
> > 
> > 
> > > > +#define dev_info(dev, format, arg...)		\
> > > > +	dev_printk(KERN_INFO, dev, format, ## arg)
> > > > +
> > > >  #ifdef DEBUG
> > > >  #define dev_dbg(dev, format, arg...)		\
> > > > -	dev_printk(KERN_DEBUG , dev , format , ## arg)
> > > > +	dev_printk(KERN_DEBUG, dev, format, ## arg)
> > > 
> > > Those extra spaces are there for a good reason, older versions of gcc
> > > are broken without it.  So please, put them all back...
> > 
> > You mean I should add spaces before commas only where they were
> > initially or to all new code and/or macros?
> 
> Put it back where it was, and do the same for all other macros.
> 
> > I've observed other kernel code and more often there are no spaces
> > before commas. I'm asking because the CodingStyle document is not very
> > explicit about this rule.
> 
> This is a gcc rule, for variable length macros, not a CodingStyle
> guideline.  It just will not work without it :)
> 

The space-before-a-comma requirement was for gcc-2.95, iirc.

It got to the stage where I was the only person testing with gcc-2.95 so I
spent inordinate amounts of time adding spaces before people's newly-added
commas.  Fortunately we abamdoned that gcc version so the space-before-a-comma
requirement no longer exists.
