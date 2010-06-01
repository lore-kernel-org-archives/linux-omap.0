From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Tue, 1 Jun 2010 13:13:14 -0700
Message-ID: <20100601201314.GA17468@core.coreip.homeip.net>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
 <20100601094358.GJ841@atomide.com>
 <27F9C60D11D683428E133F85D2BB4A53043E538286@dlee03.ent.ti.com>
 <20100601185358.GE23818@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100601185358.GE23818@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "ext Arce, Abraham" <x0066660@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 01, 2010 at 09:53:58PM +0300, Felipe Balbi wrote:
> On Tue, Jun 01, 2010 at 05:14:09PM +0200, ext Arce, Abraham wrote:
> >I am using #ifdef CONFIG_ARCH_OMAP4 for this portion of code, what
> >you are suggesting is to check at runtime?
> 
> you need to add both checks. If you build omap3-only or omap2-only
> you don't want that code to be compiled, but if you build
> omap1-2-3-4 kernel, you want it to work correctly on all cases.
> 

It sould be nice if cpu_is_xxx were stubbed out for "wrong" arches
withing the same group (like omap, etc) so we could reduce the #ifdef
clutter.

-- 
Dmitry
