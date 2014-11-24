From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 06/10] ARM: dts: am4372: Add DCAN nodes
Date: Mon, 24 Nov 2014 08:05:00 -0800
Message-ID: <20141124160459.GE2817@atomide.com>
References: <1415881371-4982-1-git-send-email-rogerq@ti.com>
 <1415881371-4982-7-git-send-email-rogerq@ti.com>
 <5469F35D.80504@ti.com>
 <20141121235032.GC7046@atomide.com>
 <20141122000853.GI7046@atomide.com>
 <54730144.9070106@ti.com>
 <54731250.9050909@ti.com>
 <20141124154903.GC2817@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141124154903.GC2817@atomide.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [141124 07:49]:
> * Roger Quadros <rogerq@ti.com> [141124 03:13]:
> > 
> > I couldn't reproduce the errors on linux-next nor on your branch. Maybe you had a conflict resolution issue?
> 
> I guess it must have been a conflict resolution issue at my end then.
> 
> > I've rebased the patches on omap-for-v3.19/dt-v2 and are available for you to pull from:
> > 
> > The following changes since commit 0f39f7b906dbeabe2ffd8739d5201e890d102ea6:
> > 
> >   ARM: dts: AM43xx: add tscadc DT entries for am437x-evm and am43x-epos-evm (2014-11-21 16:25:06 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git@github.com:rogerq/linux.git for-v3.19/omap-dts-dcan
> 
> Pulling into omap-for-v3.19/dts thanks. Let's also switch into fixes
> only mode for v3.19 now with -rc6 out.

Knowing you most likely don't have anything else based on this branch,
I ended up just picking the patches from your branch to unify the
subject line for one of the patches.

Regards,

Tony
