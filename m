From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Wed, 30 Dec 2009 13:07:45 -0600
Message-ID: <001801ca8983$5f101110$544ff780@am.dhcp.ti.com>
References: <6ed0b2680912021329g372bd0a4vb5b4a80244960f95@mail.gmail.com> <20091202215442.GA30658@oksana.dev.rtsoft.ru> <20091202223156.GA14921@nokia.com> <20091202225922.GA15568@oksana.dev.rtsoft.ru> <20091203083958.GB31110@nokia.com> <6ed0b2680912030255o57d7c46qb5ae1cfcb82e9976@mail.gmail.com> <20091203110332.GO1361@nokia.com> <6ed0b2680912100609g11706296qdbcea887dc3a5733@mail.gmail.com> <20091210141830.GA10687@oksana.dev.rtsoft.ru> <20091210142127.GB12526@nokia.com> <20091210144411.GA13120@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753352AbZL3TIO@vger.kernel.org>
In-Reply-To: <20091210144411.GA13120@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: avorontsov@ru.mvista.com, 'Felipe Balbi' <felipe.balbi@nokia.com>
Cc: 'Grazvydas Ignotas' <notasas@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]
> Sent: Thursday, December 10, 2009 8:44 AM
> To: Felipe Balbi
> Cc: Grazvydas Ignotas; linux-kernel@vger.kernel.org; Madhusudhan
> Chikkature; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI
> charger
> 
> On Thu, Dec 10, 2009 at 04:21:27PM +0200, Felipe Balbi wrote:
> > Hi,
> >
> > On Thu, Dec 10, 2009 at 03:18:30PM +0100, ext Anton Vorontsov wrote:
> > >>Ok since it doesn't look like this will resolve soon, what about
> > >>adding some DEVICE_ATTR for the time being and requiring userspace to
> > >>write charge current here to start actual charging?
> > >
> > >Works for me. Let's think of the kernel charging support as an
> > >yet unimplemented feature.
> >
> > but if you guys are ok with this one for now. It can always be
> > changed later :-)
> 
> Yep. The only thing I'm afraid of is that once the driver is in,
> then nobody will bother with improving it to do the right thing.
> But an imperfect driver is better than none.
> 

So, what is the conclusion then? Are you planning to push the BCI charger
patch currently and handle updates later?

Regards,
Madhu

> Thanks,
> 
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
