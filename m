From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 04/11] OMAP2: Devkit8000: Setup LCD reset
Date: Mon, 5 Jul 2010 15:57:16 +0300
Message-ID: <20100705125714.GW15951@atomide.com>
References: <1275478671-24563-1-git-send-email-weber@corscience.de>
 <1275478671-24563-5-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1275478671-24563-5-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org, Kan-Ru Chen <kanru@0xlab.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Thomas Weber <weber@corscience.de> [100602 14:33]:
> From: Kan-Ru Chen <kanru@0xlab.org>
> 
> This patch corrects the LCD reset pin configuration.
> 
> Original code from early devkit8000 patch sets the TWL4030 GPIO_1
> to EHCI_nOC and TWL4030_GPIO_MAX+1 to ledA. Indeed these two pins
> are both LCD_PWREN. Setup the lcd reset_gpio properly so it can be
> disabled when other display is turned on.

Applied this and the rest of the series too.

Tony
