From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v5 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
Date: Wed, 14 Jan 2015 17:49:49 +0100
Message-ID: <20150114164949.GM3843@piout.net>
References: <1411556741-5810-1-git-send-email-m.szyprowski@samsung.com>
 <20150114154603.GK3843@piout.net>
 <20150114162150.GQ11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150114162150.GQ11502@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, tony@atomide.com, linus.walleij@linaro.org, Tomasz Figa <tomasz.figa@gmail.com>, drake@endlessm.com, loeliger@gmail.com, Kyungmin Park <kyungmin.park@samsung.com>, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On 14/01/2015 at 16:21:50 +0000, Russell King - ARM Linux wrote :
> On Wed, Jan 14, 2015 at 04:46:03PM +0100, Alexandre Belloni wrote:
> > Hi,
> > 
> > This patch set hasn't moved since while. We actually need patch 4 to
> > properly configure prefetch on sama5d4. What would be needed to come to
> > an agreement ?
> 
> What do you mean "hasn't moved since a while" - there has been movement.
> It was discovered that it breaks OMAP4 platforms.
> 
> Since then, work has been done to resolve that breakage, and I've merged
> the recent patch set into my tree for further regression testing, and
> I'm going to push it out to linux-next later this week.
> 

Indeed, my searching skills are not great. I was actually looking for
mails from Tomasz but he is not taking care of it now...

Thanks for the info!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
