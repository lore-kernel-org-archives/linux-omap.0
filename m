From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: [PATCH resend] Make the dev_*() family of macros in device.hcomplete
Date: Tue, 30 Oct 2007 05:11:24 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27016E5FCB@az33exm24.fsl.freescale.net>
References: <1193697795-7823-1-git-send-email-Emilian.Medve@Freescale.com> <20071030000054.GA19022@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754336AbXJ3MLj@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <20071030000054.GA19022@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org, hjlipp@web.de, tilman@imap.cc, gigaset307x-common@lists.sourceforge.net, kkeil@suse.de, isdn4linux@listserv.isdn4linux.de, mac@melware.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Greg K-H,


> > +#define dev_info(dev, format, arg...)		\
> > +	dev_printk(KERN_INFO, dev, format, ## arg)
> > +
> >  #ifdef DEBUG
> >  #define dev_dbg(dev, format, arg...)		\
> > -	dev_printk(KERN_DEBUG , dev , format , ## arg)
> > +	dev_printk(KERN_DEBUG, dev, format, ## arg)
> 
> Those extra spaces are there for a good reason, older versions of gcc
> are broken without it.  So please, put them all back...

You mean I should add spaces before commas only where they were
initially or to all new code and/or macros? I've observed other kernel
code and more often there are no spaces before commas. I'm asking
because the CodingStyle document is not very explicit about this rule.


Thank you,
Emil.
