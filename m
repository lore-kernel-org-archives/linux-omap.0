From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 01/21] usb: phy: nop: Add some parameters to
 platform data
Date: Wed, 20 Mar 2013 09:13:24 -0700
Message-ID: <20130320161324.GL16413@atomide.com>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
 <1363794300-31526-2-git-send-email-rogerq@ti.com>
 <20130320155555.GG1567@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130320155555.GG1567@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [130320 09:00]:
> On Wed, Mar 20, 2013 at 05:44:40PM +0200, Roger Quadros wrote:
> > Add clk_rate parameter to platform data. If supplied, the
> > NOP phy driver will program the clock to that rate during probe.
> > 
> > Also add 2 flags, needs_vcc and needs_reset.
> > If the flag is set and the regulator couldn't be found
> > then the driver will bail out with -EPROBE_DEFER.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > Acked-by: Felipe Balbi <balbi@ti.com>
> 
> Hi Tony,
> 
> maybe you might prefer to merge commit 1f0972f from my next branch which
> is exactly this patch. Basically, if you:
> 
> $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
> $ git merge 1f0972f
> 
> you get $SUBJECT and can apply the others without fear of conflicts
> later.

OK thanks will use commit 1f0972f, so let's consider that commit immutable.

Regards,

Tony
