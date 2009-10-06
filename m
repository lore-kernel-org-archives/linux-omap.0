From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: fix rx51 board keymap
Date: Mon, 5 Oct 2009 22:06:56 -0700
Message-ID: <20091006050656.GI27881@core.coreip.homeip.net>
References: <1254317128-13954-1-git-send-email-amit.kucheria@verdurent.com> <20090930184843.GQ16865@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756247AbZJFFHl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090930184843.GQ16865@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>, List Linux Kernel <linux-kernel@vger.kernel.org>, List Linux Omap <linux-omap@vger.kernel.org>, Lauri Leukkunen <lauri.leukkunen@nokia.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 30, 2009 at 11:48:44AM -0700, Tony Lindgren wrote:
> * Amit Kucheria <amit.kucheria@verdurent.com> [090930 06:26]:
> > The original driver was written with the KEY() macro defined as (col, row)
> > instead of (row, col) as defined by the matrix keypad infrastructure. So the
> > keymap was defined accordingly.
> > 
> > Since the driver that was merged upstream uses the matrix keypad
> > infrastructure, modify the keymap accordingly.
> > 
> > While we are at it, fix the comments in twl4030.h and define PERSISTENT_KEY as
> > (r,c) instead of (c, r)
> > 
> > Tested on a RX51 (N900) device.
> > 
> > Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Dimitry, will you queue this one?
> 
> I'll also add it into omap-fixes-testing while waiting for it
> to go to mainline.
> 

Applied to the 'for-linus' branch.

-- 
Dmitry
