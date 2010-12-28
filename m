From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] TWD: enable one-shot mode
Date: Tue, 28 Dec 2010 02:17:42 +0100
Message-ID: <AANLkTinU+x2uV34SCO=p2K4z6BO_DSYy2+1BRU5eAgHO@mail.gmail.com>
References: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Bryan Huntsman <bryanh@codeaurora.org>, Colin Cross <ccross@android.com>, Daniel Walker <dwalker@codeaurora.org>, David Brown <davidb@codeaurora.org>, Erik Gilling <konkers@android.com>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

2010/12/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> Allow one shot timer mode to be used with the TWD. =A0This allows
> NOHZ mode to be used on SMP systems using the TWD localtimer.
>
> Tested on Versatile Express.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Acks/Tested-by's would be appreciated, thanks.

Tested on the U8500 and doesn't seem to break anything...

Local interrupts after a few minutes of use before patching
(and enabling NO_HZ):
LOC:       8203       8224

After patching;
LOC:        233        322

Looks like it's working, too.

Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
