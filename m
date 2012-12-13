From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: add pwm driver using dmtimers.
Date: Thu, 13 Dec 2012 09:34:33 -0800
Message-ID: <20121213173433.GD4989@atomide.com>
References: <20121212192430.50cea126@notabene.brown>
 <50C8ABFC.3080309@ti.com>
 <20121213140635.4eda5858@notabene.brown>
 <50CA0B4D.2000302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50CA0B4D.2000302@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: NeilBrown <neilb@suse.de>, Thierry Reding <thierry.reding@avionic-design.de>, Grant Erickson <marathon96@gmail.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Jon Hunter <jon-hunter@ti.com> [121213 09:11]:
> On 12/12/2012 09:06 PM, NeilBrown wrote:
> > On Wed, 12 Dec 2012 10:08:28 -0600 Jon Hunter <jon-hunter@ti.com> wrote:
> >> On 12/12/2012 02:24 AM, NeilBrown wrote:
> >>> +
> >>> +#include <plat/dmtimer.h>
> >>
> >> This is going to be a problem for the single zImage work, because we
> >> cannot include any plat headers in driver code any more. Therefore,
> >> although it is not ideal, one way to handle this is pass function
> >> pointers to the various dmtimer APIs that are needed via the platform
> >> data. Painful I know ...
> > 
> > But that doesn't work with devicetree does it?
> 
> Ugh, you are right! This is becoming an increasing problem.
> 
> > Can't we move the dmtimer.h file to include/linux/omap-dmtimer.h or something?
> 
> I can ask Tony if he thinks we could do that.

Yeah we need to fix this somehow. First we need to limit that header
to the minimum and have most of it in a local header file for the
clocksource and clockevent. Then let's move the minimal header to
include/linux/omap-dmtimer.h until we have something Linux generic
available for doing things like this.

Regards,

Tony
