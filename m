From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 01/23] mfd: omap-usb-host: get rid of
 cpu_is_omap..() macros
Date: Fri, 14 Dec 2012 10:30:28 -0800
Message-ID: <20121214183027.GC4989@atomide.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com>
 <1355134833-5199-2-git-send-email-rogerq@ti.com>
 <20121213214949.GH4989@atomide.com>
 <20121214005450.GO26699@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121214005450.GO26699@sortiz-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: balbi@ti.com, paul@pwsan.com, keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Samuel Ortiz <sameo@linux.intel.com> [121213 16:57]:
> Hi Tony,
> 
> On Thu, Dec 13, 2012 at 01:49:49PM -0800, Tony Lindgren wrote:
> > Hi Samuel,
> > 
> > * Roger Quadros <rogerq@ti.com> [121210 02:23]:
> > > Instead of using cpu_is_omap..() macros in the device driver we
> > > rely on information provided in the platform data.
> > > 
> > > The only information we need is whether the USB Host module has
> > > a single ULPI bypass control bit for all ports or individual bypass
> > > control bits for each port. OMAP3 REV2.1 and earlier have the former.
> > 
> > I'd like to apply this patch as a fix so I can finally nuke plat/cpu.h
> > for omaps by -rc1 before more drivers start using it again.
> > 
> > That is assuming nobody else is planning on merging this series for
> > v3.8 presumably. 
> This should go into 3.9, yes.

OK looks like you have all the necessary acks except for one
clock change. I replied to that one. 
 
> > Want to ack this one?
> Looks fine to me:
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Thanks, I'll queue that one and then after -rc1 hopefully
you have all the necessary acks to queue this one via your
mfd tree.

Regards,

Tony
