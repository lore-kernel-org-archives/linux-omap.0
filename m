From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 13/21] ARM: omap: convert wakeupgen to stacked domains
Date: Thu, 15 Jan 2015 14:50:21 +0000
Message-ID: <87sifcgksy.fsf@approximate.cambridge.arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
	<1421087187-26988-14-git-send-email-marc.zyngier@arm.com>
	<20150114222814.GU2419@atomide.com>
	<871tmwi0d6.fsf@approximate.cambridge.arm.com>
	<20150115144016.GA19920@kahuna>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150115144016.GA19920@kahuna> (Nishanth Menon's message of
	"Thu, 15 Jan 2015 14:40:16 +0000")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, Stefan Agner <stefan@agner.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 15 2015 at  2:40:16 pm GMT, Nishanth Menon <nm@ti.com> wrote:
> On 14:28-20150115, Marc Zyngier wrote:
>> Assuming the workaround I posted earlier works, the OMAP/DRA7 part of
>> this series is going to require some rework too (I need to know where
>> these legacy interrupts are attached: crossbar, WUGEN, or GIC?).
>> 
> crossbar will never work with legacy static interrupts anyways - since
> there was never a static interrupt possible - I believe we had removed
> all the legacy hardcoded interrupt definitions for DRA7. ideally, they
> should all be dt only now.

Yes, I guessed as much after looking at the DRA7XX hwmod.

So only OMAP4/5 is b0rken at the moment. I can probably work around it
as I did in this example patch, just by changing the compatible strings
for the xlate callback. Very ugly.

	M.
-- 
Jazz is not dead. It just smells funny.
