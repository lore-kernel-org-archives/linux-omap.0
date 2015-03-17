From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: remove dead kconfig option OMAP4_ERRATA_I688
Date: Tue, 17 Mar 2015 10:27:37 -0700
Message-ID: <20150317172737.GE31346@atomide.com>
References: <1424889867-8980-1-git-send-email-stefan.hengelein@fau.de>
 <20150316233005.GA2598@atomide.com>
 <550855B7.3020905@oracle.com>
 <550856FF.9080702@ti.com>
 <20150317163440.GC31346@atomide.com>
 <CAGo_u6oHk9MXPGQv1rCpvW_oegzEzFTu3sZ_4j_6HFEivnXZXg@mail.gmail.com>
 <20150317171000.GD31346@atomide.com>
 <CAGo_u6rNj=k0cYx1G_v2eFHcf0sHY++bUz0uM6PfiRXbc2chqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGo_u6rNj=k0cYx1G_v2eFHcf0sHY++bUz0uM6PfiRXbc2chqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Stefan Hengelein <stefan.hengelein@fau.de>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [150317 10:18]:
> On Tue, Mar 17, 2015 at 12:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> >
> >
> > Yes that's a good point and adding a printk is a good idea. Care to
> > crank out a separate patch for that?
> 
> 
> had hoped to have it part of this patch - does'nt that make more sense?

Hmm well this patch removes code that's been dead for a few years.. I'd
rather keep this as clean up, then merge what you're suggesting as a
separate non-critical patch as that we could already do without removing
this code.

Regards,

Tony
