From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] TWD: enable one-shot mode
Date: Mon, 10 Jan 2011 21:12:36 -0800
Message-ID: <4D2BE6C4.4040806@codeaurora.org>
References: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.org>, Erik Gilling <konkers@android.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@stericsson.com>, Olof Johansson <olof@lixom.net>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/24/2010 11:18 AM, Russell King - ARM Linux wrote:
> Allow one shot timer mode to be used with the TWD.  This allows
> NOHZ mode to be used on SMP systems using the TWD localtimer.
>
> Tested on Versatile Express.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Acks/Tested-by's would be appreciated, thanks.
>

I see this patch was already tested and merged but can you elaborate on
why this was done? From what I understand, NOHZ selects one-shot (like
is done in this patch), so why don't the machines with a TWD choose NOHZ
or high res timers?

Putting it another way, if my machine supports a oneshot capable
clockevent device should I be selecting oneshot regardless of the NOHZ
and high res config option being chosen?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
