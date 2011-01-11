From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] TWD: enable one-shot mode
Date: Tue, 11 Jan 2011 11:52:09 +0000
Message-ID: <20110111115209.GA12781@n2100.arm.linux.org.uk>
References: <20101224191855.GJ20587@n2100.arm.linux.org.uk> <4D2BE6C4.4040806@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D2BE6C4.4040806@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.org>, Erik Gilling <konkers@android.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@stericsson.com>, Olof Johansson <olof@lixom.net>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 10, 2011 at 09:12:36PM -0800, Stephen Boyd wrote:
> On 12/24/2010 11:18 AM, Russell King - ARM Linux wrote:
> > Allow one shot timer mode to be used with the TWD.  This allows
> > NOHZ mode to be used on SMP systems using the TWD localtimer.
> >
> > Tested on Versatile Express.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > Acks/Tested-by's would be appreciated, thanks.
> >
> 
> I see this patch was already tested and merged but can you elaborate on
> why this was done? From what I understand, NOHZ selects one-shot (like
> is done in this patch), so why don't the machines with a TWD choose NOHZ
> or high res timers?

You're right - so it's not actually required.  It should probably be
reverted, though it does no damage...
