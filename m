From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH resend] Make the dev_*() family of macros in
 device.hcomplete
Date: Tue, 30 Oct 2007 08:29:31 -0700
Message-ID: <20071030082931.113274cc.randy.dunlap@oracle.com>
References: <1193697795-7823-1-git-send-email-Emilian.Medve@Freescale.com>
	<20071030000054.GA19022@suse.de>
	<598D5675D34BE349929AF5EDE9B03E27016E5FCB@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756218AbXJ3PcH@vger.kernel.org>
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27016E5FCB@az33exm24.fsl.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
Cc: Greg KH <gregkh@suse.de>, mochel@osdl.org, linux-kernel@vger.kernel.org, hjlipp@web.de, tilman@imap.cc, gigaset307x-common@lists.sourceforge.net, kkeil@suse.de, isdn4linux@listserv.isdn4linux.de, mac@melware.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, 30 Oct 2007 05:11:24 -0700 Medve Emilian-EMMEDVE1 wrote:

> Hi Greg K-H,
> 
> 
> > > +#define dev_info(dev, format, arg...)		\
> > > +	dev_printk(KERN_INFO, dev, format, ## arg)
> > > +
> > >  #ifdef DEBUG
> > >  #define dev_dbg(dev, format, arg...)		\
> > > -	dev_printk(KERN_DEBUG , dev , format , ## arg)
> > > +	dev_printk(KERN_DEBUG, dev, format, ## arg)
> > 
> > Those extra spaces are there for a good reason, older versions of gcc
> > are broken without it.  So please, put them all back...
> 
> You mean I should add spaces before commas only where they were
> initially or to all new code and/or macros? I've observed other kernel
> code and more often there are no spaces before commas. I'm asking
> because the CodingStyle document is not very explicit about this rule.

My (hazy?) recollection of the gcc issue is that it is only the
comma before the ## that needs spaces around it.

I'm not even sure that we are still supporting that gcc version,
but you should just put the spaces back to be safe IMO.

---
~Randy
