From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: TWD: Consolidate local timers support
Date: Tue, 30 Nov 2010 22:16:15 +0000
Message-ID: <20101130221615.GA9424@n2100.arm.linux.org.uk>
References: <20101130173105.GA26929@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101130173105.GA26929@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kukjin Kim <kgene.kim@samsung.com>, Benoit Cousson <b-cousson@ti.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Colin Cross <ccross@android.com>, Varun Swara <Varun.Swara@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 30, 2010 at 08:31:05PM +0300, Anton Vorontsov wrote:
> This greatly reduces amount of platform-specific code, and thus
> makes it easier to add local timers for new platforms.
> 
> Technically, it's not very nice to place machine-specific (i.e.
> local_timer_setup()) routine into the machine-agnostic code.
> But the true thing is: currently all machines want the same thing.

I've just been talking to someone this week about (presumably) non-TWD
local timers.

I suspect your patch is all part of the "lets try to get ARM building
for every platform in the world in one kernel" but it's really painful
to see carefully abstracted interfaces being trodden on by this argument
- which is just going to make things more difficult in the future.
