From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/14] clkdev: get rid of redundant clk_add_alias()
 prototype in linux/clk.h
Date: Sat, 4 Apr 2015 13:53:04 +0100
Message-ID: <20150404125303.GE4027@n2100.arm.linux.org.uk>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
 <E1Ye593-0001B1-W4@rmk-PC.arm.linux.org.uk>
 <87lhi8rrmd.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lhi8rrmd.fsf@free.fr>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Apr 04, 2015 at 02:43:22PM +0200, Robert Jarzmik wrote:
> Russell King <rmk+kernel@arm.linux.org.uk> writes:
> 
> > clk_add_alias() is provided by clkdev, and is not part of the clk API.
> > Howver, it is prototyped in two locations: linux/clkdev.h and
> > linux/clk.h.  This is a mess.  Get rid of the redundant and unnecessary
> > version in linux/clk.h.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> Actually, this serie fixes a regression I've seen in linux-next, and
> which was triggering the Oops in [1] on lubbock. With your serie, the
> kernel boots fine.

Yes, this series does fix a regression - I mentioned that the per-user
clk patches broke quite a bit of this code in the cover to the series.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
