From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: gta04: add serial console wakeup irq
Date: Mon, 24 Sep 2018 15:03:45 -0700
Message-ID: <20180924220345.GG5662@atomide.com>
References: <20180923150719.8211-1-andreas@kemnade.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180923150719.8211-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Kemnade <andreas@kemnade.info>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [180923 08:12]:
> This enables the possibility to have more aggressive runtime pm
> by providing proper wakeup irq for the serial console.

Thanks applying to omap-for-v4.20/dt.

FYI, you can now grep wake /proc/interrupts and see the
wakeirq counts increase when they trigger. Might be handy
for debugging PM stuff.

Regards,

Tony
